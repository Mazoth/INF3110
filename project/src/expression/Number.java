package expression;
import java.util.HashMap;

public class Number extends Expression {
	int num;
	
	public Number(int num) {
		this.num = num;
	}
	
	@Override
	public int evaluate(HashMap<String,Integer> vars) {
		return this.num;
	}
}