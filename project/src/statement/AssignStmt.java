package statement;
import java.util.HashMap;
import robol.Robot;
import robol.RobolError;
import expression.Expression;

/* <assign-stmt> ::= <id> = <expr> */

public class AssignStmt extends Statement {
	private String id;
	private Expression expr;
	
	public AssignStmt(String id, Expression expr) {
		this.id = id;
		this.expr = expr;
	}
	
	public void interpret(Robot r, HashMap<String,Integer> vars) {
		if(! vars.containsKey(id)) {
			throw new RobolError("No variable found for name \"" + id + "\"!");
		}
		vars.put(id, expr.evaluate(vars));
	}
}