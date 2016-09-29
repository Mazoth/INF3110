package expression;
import java.util.HashMap;

public class NumExpr extends Expression {
	private int num;
	
	public NumExpr(int num) {
		this.num = num;
	}
	
	@Override
	public int evaluate(HashMap<String,Integer> vars) {
		// Note that the param "vars" is actually not needed here
		return this.num;
	}
}