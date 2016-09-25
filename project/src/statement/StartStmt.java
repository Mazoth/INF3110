package statement;
import java.util.HashMap;
import expression.Expression;
import robol.Robot;

/* <start> ::= start (<expr>, <expr>) */

public class StartStmt extends Statement {
	private Expression x;
	private Expression y;
	
	public StartStmt(Expression x, Expression y) {
		this.x = x;
		this.y = y;
	}
	
	@Override
	public void interpret(Robot r, HashMap<String, Integer> vars) {
		r.moveByAbsPos(x.evaluate(vars), y.evaluate(vars));
	}
}