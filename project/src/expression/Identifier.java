package expression;
import java.util.HashMap;
import robol.RobolError;

public class Identifier extends Expression {
	String id;
	
	public Identifier(String id) {
		this.id = id;
	}
	
	@Override
	public int evaluate(HashMap<String,Integer> vars) {
		Integer value = vars.get(id);
		if(value == null) { 
			throw new RobolError("Variable '" + id + "' not declared!");
		}
		return value.intValue();
	}
}
