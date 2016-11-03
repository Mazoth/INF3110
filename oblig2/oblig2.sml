(*
	UiO INF3110 - Autumn 2016
	Assignment 2
	@author: syhd
*)
exception OutOfBounds;
exception VariableNotFound;

(* Datatype declarations *)
datatype expr
	= Number of int
	| Identifier of string
	| Add of expr * expr
	| Subtract of expr * expr
	| Multiply of expr * expr
	| BoolExpr of boolean
and boolean
	= BiggerThan of expr * expr
	| LessThan of expr * expr
	| EqualTo of expr * expr;
datatype direction = NORTH | SOUTH | EAST | WEST;
datatype stmt
	= Stop
	| Move of direction * expr
	| Assignment of string * expr
	| WhileStmt of boolean * stmt list
datatype var = VarDecl of string * expr;
datatype start = Start of expr * expr;
datatype grid = Size of int * int;
datatype robot = Robot of var list * start * stmt list;
datatype program = Program of grid * robot;

(* Aliases *)
type position = int * int;

(* Return the value of the variable *)
fun findVar(name, nil) = raise VariableNotFound
|	findVar(name, VarDecl(id, e)::) =
		if name = id then evalExpr(e, decls)


(* Evaluate the expressions *)
fun evalExpr(Number n, decls : var list) = n
|	evalExpr(Identifier name, decls) =
		let
			fun findDecl (nil) = raise VariableNotFound
			|	findDecl (VarDecl(id,exp)::decList) =
					if id = name
					then evalExpr(exp, decls)
					else findDecl(decList)
		in
			findDecl(decls)
		end
|	evalExpr(Add(e1,e2), decls)
		= evalExpr(e1, decls) + evalExpr(e2, decls)
|	evalExpr(Subtract(e1,e2), decls)
		= evalExpr(e1, decls) - evalExpr(e2, decls)
|	evalExpr(Multiply(e1,e2), decls)
		= evalExpr(e1, decls) * evalExpr(e2, decls)
|	evalExpr(BoolExpr(BiggerThan(e1,e2)), decls)
		= if evalExpr(e1, decls) > evalExpr(e2, decls) then 1 else 0
|	evalExpr(BoolExpr(LessThan(e1,e2)), decls)
		= if evalExpr(e1, decls) < evalExpr(e2, decls) then 1 else 0
|	evalExpr(BoolExpr(EqualTo(e1,e2)), decls)
		= if evalExpr(e1, decls) = evalExpr(e2, decls) then 1 else 0

 (* Intepret method --> return a tuple specifying final position *)
fun interpret(Program(Size(x,y), Robot(decls, Start(xpos, ypos),
	Move(direction, exp) :: stmtlst))) = ...


(*
fun interpret ( Program(Size(x, y),
	Robot(decls, Start(xpos, ypos),
		Move(direction, exp) :: stmtlst))) = ...
*)
