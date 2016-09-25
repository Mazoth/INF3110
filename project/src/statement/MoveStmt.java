package statement;
import java.util.HashMap;
import expression.Expression;
import robol.Robot;

/* <move> ::= <direction> <expr> */

public class MoveStmt extends Statement {
	private Direction dir;
	private Expression expr;
	
	public MoveStmt(Direction dir, Expression expr) {
		this.dir = dir;
		this.expr = expr;
	}
	
	@Override
	public void interpret(Robot r, HashMap<String, Integer> vars) {
		int numSteps = expr.evaluate(vars);
		switch(dir) {
		case NORTH:
			r.moveByRelPos(0, numSteps); break;
		case SOUTH:
			r.moveByRelPos(0, -numSteps); break;
		case EAST:
			r.moveByRelPos(numSteps, 0); break;
		case WEST:
			r.moveByRelPos(-numSteps, 0); break;
		}
	}
}