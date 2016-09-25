package expression;
import java.util.HashMap;
import robol.RobolError;

public class BoolExp extends Expression {
	Operator opr;    // the Boolean operator
	Expression expL; // expression on the left
	Expression expR; // expression on the right
	
	public BoolExp(Operator opr, Expression expL, Expression expR) {
		this.opr = opr;
		this.expL = expL;
		this.expR = expR;
	}
	
	@Override
	public int evaluate(HashMap<String, Integer> vars) {
		int res = 0; // result
		switch(opr) {
		case 
		}
		return 0;
	}

}
