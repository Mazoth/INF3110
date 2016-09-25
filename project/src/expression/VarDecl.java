package expression;
import java.util.HashMap;

/* <var-decl> ::= var <id> = <expr> */

public class VarDecl {
	private String id;
	private Expression expr;
	
	public VarDecl(String id, Expression expr) {
		this.id = id;
		this.expr = expr;
	}
	
	public void interpret(HashMap<String,Integer> vars) {
		vars.put(id, new Integer(expr.evaluate(vars)));
	}
}