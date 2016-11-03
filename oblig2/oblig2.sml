(*
	UiO INF3110 - Autumn 2016
	Assignment 2
	@author: syhd
*)
exception OutOfBounds;

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

(* Evaluate the expressions *)
fun evalExpr(Number n, decls : var list) = n
|	evalExpr(Identifier name, decls) = ~1
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


(*
fun evalExp(BiggerThan(e1, e2), decls) =
	if evalExp(e1, decls) > evalExp(e2, decls) then 1 else 0
...
fun interpret ( Program(Size(x, y),
	Robot(decls, Start(xpos, ypos),
		Move(direction, exp) :: stmtlst))) = ...
*)
