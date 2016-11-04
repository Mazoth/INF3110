(**
 * UiO Autumn 2016 
 * INF3110 - Assignment 2
 * @author: syhd
 * The code uses spaces instead of tabs
 *)

exception OutOfBounds;      (* will be handled     *)
exception VariableNotFound; (* will NOT be handled *)


(* =======================================================================
 * Declaring all necessary datatypes and type aliases
 * =====================================================================*)

datatype direction = NORTH | SOUTH | EAST | WEST;
 
datatype expression
    = Num  of int
    | ID   of string
    | Add  of expression * expression
    | Sub  of expression * expression
    | Mul  of expression * expression
    | Bool of boolean
and boolean
    = More  of expression * expression
    | Less  of expression * expression
    | Equal of expression * expression
;
datatype statement
    = Stop
    | Move   of direction * expression
    | While  of boolean * statement list
    | Assign of string * expression
;
datatype variable    = Var of string * int;
datatype declaration = Decl of string * expression;
datatype start       = Start of expression * expression;
datatype board       = Size of int * int;
datatype robot       = Robot of declaration list * start * statement list;
datatype program     = Program of board * robot;

type position = int * int;
type state    = grid * variable list * position


(* =======================================================================
 * Declaring functions to work on variable list
 * =====================================================================*)
 
fun addVar(Var(id,value), varList) =
    let val curList = List.filter (fn (k,v) => k <> id) varList
    in Var(id,value)::curList end;

fun findVar(id, nil) = raise VariableNotFound
|   findVar(id, Var(k,v)::varList) =
        if id = k then v else findVar(id, varList);

    
(* =======================================================================
 * Defining functions to work on expressions
 * =====================================================================*)  

fun evalExpr(varList, Num(n)) = n
|   evalExpr(varList, ID(id)) = findVar(id, varList)
|   evalExpr(varList, Add(e1,e2))
        = evalExpr(varList, e1) + evalExpr(varList, e2)
|   evalExpr(varList, Sub(e1,e2))
        = evalExpr(varList, e1) - evalExpr(varList, e2)
|   evalExpr(varList, Mul(e1,e2))
        = evalExpr(varList, e1) * evalExpr(varList, e2)
|   evalExpr(varList, Bool(More(e1,e2)))
        = if evalExpr(varList, e1) > evalExpr(varList, e2) then 1 else 0
|   evalExpr(varList, Bool(Less(e1,e2)))
        = if evalExpr(varList, e1) < evalExpr(varList, e2) then 1 else 0
|   evalExpr(varList, Bool(Equal(e1,e2)))
        = if evalExpr(varList, e1) = evalExpr(varList, e2) then 1 else 0


(* =======================================================================
 * Defining functions that work on variable declarations and statements
 * =====================================================================*)      

fun evalDecls(nil, varList) : variable list = varList
|   evalDecls(Decl(id,expr)::decls, varList)
    = evalDecls(decls, addVar(Var(id,evalExpr(varList,expr)),varList))
    
fun move((Size(xlim,ylim),varList,(x,y)):state, xsteps, ysteps) : state =
    let val newX = x + xsteps
        val newY = y + ysteps
    in  if newX >= xlim orelse newY >= ylim then raise OutOfBounds
        else (Size(xlim,ylim), varList, (newX,newY)
    end;

fun evalStmts(s, nil) : state = s
|   evalStmts(s, Stop::_) = s
|   evalStmts(s, Move(dir,steps)::stmtList)
        = evalStmts(evalMove(s,Move(dir,steps)), stmtList)
|   evalStmts(s, Assign(id,expr)::stmtList)
        = evalStmts(evalAssign(s,Assign(id,expr)), stmtList)
|   evalStmts(s, While(cond,stmts)::stmtList)
        = evalStmts(evalWhile(s,While(cond,expr)), stmtList)
and evalMove((grid,varList,pos):state, Move(dir,expr)) : state =
    let val steps = evalExpr(varList,expr) in
        if dir = NORTH then move((grid,varList,pos), 0, steps)  else
        if dir = SOUTH then move((grid,varList,pos), 0, ~steps) else
        if dir = EAST  then move((grid,varList,pos), steps, 0)  else
        if dir = WEST  then move((grid,varList,pos), ~steps, 0) end
and evalAssign((grid,varList,pos):state, Assign(id,expr)) : state = 
    let val curVal = findVar(id, varList)
        val newVal = evalExpr(varList, expr)
        val newLst = addVar(Variable(id,newVal), varList)
    in (grid, newLst, pos) end
and evalWhile((grid,varList,pos):state, While(cond,stmts)) : state =
    let val s : state = (grid,varList,pos) in
        if evalExpr(varList, Bool(cond)) = 0 then s
        else evalWhile(evalStmts(s,stmts), While(cond,stmts))
    end;
        

(* =======================================================================
 * The interpret function
 * =====================================================================*)  

fun interpret(Program(grid, Robot(decls,Start(x,y),stmtList))) : unit =
    let val origin : position = (0,0) (* grid's origin *)
        val varList = evalDecls(decls, [])
        val xsteps = evalExpr(varList, x)
        val ysteps = evalExpr(varList, y)
        val startState = move((grid,varList,origin), xsteps, ysteps)
        val finalState = evalStmts(stmtList, startState)
        val finalXPos = Int.toString(#1(#3(finalState)))
        val finalYPos = Int.toString(#2(#3(finalState)))
    in print("Final position: (" ^ finalXPos ^ "," ^ finalYPos ^ ")\n") end
    handle OutOfBounds => print("Robot has fallen out of the grid! \n");
    
    
(* =======================================================================
 * Testing
 * =====================================================================*)  

val prog1 = Program ( 
    Size(64,64),
    Robot(nil, (* no vardecls *)
          Start(Num(23), Num(30)),
          [Move(WEST, Num(15)),
           Move(SOUTH, Num(15)),
           Move(EAST, Add(Num(2), Num(4))),
           Move(NORTH, Add(Num(10), Num(27))),
           Stop]
    )
);
val prog2 = Program (
    Size(64,64),
    Robot([Decl("i", Num(5)),
           Decl("j", Num(3))],
          Start(Num(23), Num(6)),
          [Move(NORTH, Mul(Num(3),ID("i"))),
           Move(EAST, Num(15)),
           Move(SOUTH, Num(4)),
           Move(WEST, Add(Add(Mul(Num(2),ID("i")),Mul(Num(3),ID("j"))),Num(5))),
           Stop]
    )
);
val prog3 = Program (
    Size(64,64),
    Robot([Decl("i", Num(5)),
           Decl("j", Num(3))],
          Start(Num(24), Num(6)),
          [Move(NORTH, Mul(Num(3),ID("i")),
           Move(WEST, Num(15)),
           Move(EAST, Num(4)),
           While(Bool(More(ID("j"),Num(0))),
                 [Move(SOUTH, ID("j")),
                  Assign("j", Sub(ID("j"),Num(1)))])
           Stop]
    )
);
val prog4 = Program (
    Size(64,64),
    Robot([Decl("j", Num(3))],
          Start(Num(1), Num(1)),
          [While(Bool(More(ID("j"),Num(0))),
                 [Move(NORTH, ID("j"))]),
           Stop]    
    )
);

print("Test 1 ========================== \n");
interpret(prog1);

print("Test 2 ========================== \n");
interpret(prog2);

print("Test 3 ========================== \n");
interpret(prog3);

print("Test 4 ========================== \n");
interpret(prog4);