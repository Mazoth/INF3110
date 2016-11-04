(**
 * UiO INF3110 - Autumn 2016
 * Assignment 2
 * @author: syhd
 *)

exception OutOfBounds;
exception VariableNotFound;


(* =======================================================================
 * Declaring all necessary datatypes and type aliases
 * =====================================================================*)

datatype direction = NORTH | SOUTH | EAST | WEST;
 
datatype expr
	= Number of int
	| Identifier of string
	| Add of expr * expr
	| Subtract of expr * expr
	| Multiply of expr * expr
	| BoolExpr of boolean
and boolean
	= MoreThan of expr * expr
	| LessThan of expr * expr
	| EqualTo of expr * expr;
	
datatype statement
	= StopStmt
	| MoveStmt of direction * expr
	| AssignStmt of string * expr
	| WhileStmt of boolean * statement list

datatype start = Start of expr * expr;
datatype declaration = VarDecl of string * expr;
datatype grid = Size of int * int;
datatype robot = Robot of declaration list * start * statement list;
datatype program = Program of grid * robot;

type position = int * int;
type variable = string * int
type state = grid * variable list * position


(* =======================================================================
 * Declaring functions to work on variable list
 * =====================================================================*)
 
(* Add a variable into a variable list *)
fun addVar(var : variable, vars : variable list) = var::vars

(* Assign a new value to a variable *)
fun setVar((id, value), varList) : variable list =
	let fun filter(nil) = raise VariableNotFound
		|	filter((k,v)::varList) 
			= if (k = id) then varList else filter(varList)
	in (id, value)::filter(varList)
	end;

(* Return a value stored in a variable *)
fun getVar(id, nil) = raise VariableNotFound
|	getVar(id, (k,v)::varList : variable list) =
		if id = k then v else getVar(id, varList);

	
(* =======================================================================
 * Declaring functions to work on expressions
 * =====================================================================*)	

fun evalExpr(varList, Number(n)) = n
|	evalExpr(varList, Identifier(id)) = getVar(id, varList)
|	evalExpr(varList, Add(e1,e2))
		= evalExpr(varList, e1) + evalExpr(varList, e2)
|	evalExpr(varList, Subtract(e1,e2))
		= evalExpr(varList, e1) - evalExpr(varList, e2)
|	evalExpr(varList, Multiply(e1,e2))
		= evalExpr(varList, e1) * evalExpr(varList, e2)
|	evalExpr(varList, BoolExpr(MoreThan(e1,e2)))
		= if evalExpr(varList, e1) > evalExpr(varList, e2) then 1 else 0
|	evalExpr(varList, BoolExpr(LessThan(e1,e2)))
		= if evalExpr(varList, e1) < evalExpr(varList, e2) then 1 else 0
|	evalExpr(varList, BoolExpr(EqualTo(e1,e2)))
		= if evalExpr(varList, e1) = evalExpr(varList, e2) then 1 else 0


(* =======================================================================
 * Declaring functions to work on variable declarations
 * =====================================================================*)	
 
(* Make a variable list with initial values from a declaration list *)
fun evalDecls(declList : declaration list) : variable list =
	let fun iter(nil, varList) = varList
		|	iter(VarDecl(id,exp)::declList, varList)
			= iter(declList, ((id,(evalExpr(varList,exp)))::varList))
	in iter(declList, nil)
	end;		


(* =======================================================================
 * Declaring functions to work on statements
 * =====================================================================*)		
 
fun move((Size(x,y), varList, curPos) : state, relPos : position) : state =
	if #1(curPos) + #1(relPos) < x andalso #2(curPos) + #2(relPos) < y
	then (Size(x,y), varList, (#1(curPos) + #1(relPos), #2(curPos) + #2(relPos)))
	else raise OutOfBounds;

fun evalStmts(s : state, nil) = s
|	evalStmts((Size(x,y), varList, (xpos, ypos)), StopStmt::_) = 
		(print ("The result is (" ^ Int.toString(xpos)
			^ "," ^ Int.toString(ypos) ^ ")\n");
		(Size(x,y), varList, (xpos, ypos)))
|	evalStmts((Size(x,y), varList, pos), MoveStmt(dir,steps)::stmtList) = 
		evalStmts(
			move((Size(x,y), varList, pos),
				if dir = NORTH then (0, evalExpr(varList,steps)) else 
				if dir = SOUTH then (0, ~(evalExpr(varList,steps))) else
				if dir = EAST then (evalExpr(varList,steps), 0)
				else (~(evalExpr(varList,steps)), 0)),
			stmtList)
|	evalStmts((Size(x,y), varList, pos), AssignStmt(id,exp)::stmtList)
		= evalStmts((Size(x,y), setVar((id, evalExpr(varList, exp)), varList), pos), stmtList)
|	evalStmts(s : state, WhileStmt(cond,stmts)::stmtList) =
		let 
			fun evalWhile((Size(x,y), varList, pos) : state) : state = 
				if evalExpr(varList, BoolExpr(cond)) = 1
				then evalWhile(evalStmts((Size(x,y), varList, pos), stmts))
				else (Size(x,y), varList, pos)
		in evalStmts(evalWhile(s), stmtList)
		end;


(* =======================================================================
 * Declaring interpret() function
 * =====================================================================*)	

fun interpret(Program(Size(x,y), Robot(decls, Start(xpos, ypos), stmtList))) : unit =
	let val varList = evalDecls(decls)
	in (evalStmts(move((Size(x,y), varList, (0,0)), (evalExpr(varList,xpos), evalExpr(varList, ypos))),
				stmtList); ())
	end;
	
	
(* =======================================================================
 * Test functions
 * =====================================================================*)	

val prog1 =
	Program(Size(64,64),
		Robot(
			[],
			Start(Number(23), Number(30)),
			[MoveStmt(WEST, Number(15)), 
			 MoveStmt(SOUTH, Number(15)),
			 MoveStmt(EAST, Add(Number(2), Number(4))),
			 MoveStmt(NORTH, Add(Number(10), Number(27))),
			 StopStmt]));
		
val prog2 = 
	Program(Size(64,64),
		Robot(
			[VarDecl("i", Number(5)),
			 VarDecl("j", Number(3))],
			Start(Number(23), Number(6)),
			[MoveStmt(NORTH, Multiply(Number(3),Identifier("i"))),
			 MoveStmt(EAST, Number(15)),
			 MoveStmt(SOUTH, Number(4)),
			 MoveStmt(WEST, Add(Add(Multiply(Number(2),Identifier("i")),
									 Multiply(Number(3),Identifier("j"))),
								 Number(5))),
			StopStmt]));