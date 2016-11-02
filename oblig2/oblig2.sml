datatype direction = …
datatype grid = Size of int * int;

datatype exp =
	Identifier of string
…

datatype boolexp =
	BiggerThan of exp * exp
	| LessThan of exp * exp
…

datatype stmt =
	Move of direction * exp
…
datatype robot = Robot of vardecl list * start * stmt list …
datatype program = Program of grid * robot;

fun evalExp(BiggerThan(e1, e2), decls) =
	if evalExp(e1, decls) > evalExp(e2, decls) then 1 else 0
…
exception OutOfBounds;

fun interpret ( Program(Size(x, y),
	Robot(decls, Start(xpos, ypos),
		Move(direction, exp) :: stmtlst))) = …