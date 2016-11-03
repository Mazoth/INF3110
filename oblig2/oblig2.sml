(*
	UiO INF3110 - Autumn 2016
	Assignment 2
	@author: syhd
*)
exception OutOfBounds;

datatype Expr
	= Number of int
	| Identifier of string
	| ArithExpr of ArithExpr
	| BoolExpr of BoolExpr
and ArithExpr
	= Add of Expr * Expr
	| Subtract of Expr * Expr
	| Multiply of Expr * Expr
and BoolExpr
	= BiggerThan of Expr * Expr
	| LessThan of Expr * Expr
	| EqualTo of Expr * Expr; 

datatype Stmt
	= Stop
	| Move of Direction * Expr
	| Assignment of string * Expr
	| WhileStmt of BoolExpr * Stmt list
and Direction = NORTH | SOUTH | EAST | WEST;

datatype VarDecl = VarDecl of string * Expr;
datatype Start = Start of Expr * Expr;
datatype Grid = Size of int * int;
datatype Robot = Robot of VarDecl list * Start * Stmt list;
datatype Program = Program of Grid * Robot;


fun evalExpr(Number(num), decls) = 1
|	evalExpr(BiggerThan(e1, e2), decls) = 
		if evalExpr(e1, decls) > evalExpr(e2, decls) then 1 else 0;
(* |	evalExpr(LessThan(e1, e2), decls) =
		if evalExpr(e1, decls) < evalExpr(e2, decls) then 1 else 0
|	evalExpr(EqualTo(e1, e2), decls) =
		if evalExpr(e1, decls) = evalExpr(e2, decls) then 1 else 0
|	evalExpr(Add(e1, e2), decls) =
		evalExpr(e1, decls) + evalExpr(e2, decls)
|	evalExpr(Subtract(e1, e2), decls) =
		evalExpr(e1, decls) - evalExpr(e2, decls)
|	evalExpr(Multiply(e1, e2), decls) =
		evalExpr(e1, decls) * evalExpr(e2, decls)
|	evalExpr(Identifier(id), decls) = 1
*)
		

(*
fun evalExp(BiggerThan(e1, e2), decls) =
	if evalExp(e1, decls) > evalExp(e2, decls) then 1 else 0
…



fun interpret ( Program(Size(x, y),
	Robot(decls, Start(xpos, ypos),
		Move(direction, exp) :: stmtlst))) = …
*)