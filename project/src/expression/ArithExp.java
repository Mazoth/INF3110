package expression;
import java.util.HashMap;
import robol.RobolError;

public class ArithExp extends Expression {
	Operator opr;    // the arithmetic operator
	Expression expL; // expression on the left
	Expression expR; // expression on the right
	
	public ArithExp(Operator opr, Expression expL, Expression expR) {
		this.opr = opr;
		this.expL = expL;
		this.expR = expR;
	}
	
	@Override
	public int evaluate(HashMap<String, Integer> vars) {
		int res = 0; // result
		switch(opr) {
		case additionOpr:
			res = expL.evaluate(vars) + expR.evaluate(vars); break;
		case subtractionOpr:
			res = expL.evaluate(vars) - expR.evaluate(vars); break;
		case multiplyOpr:
			res = expL.evaluate(vars) * expR.evaluate(vars); break;
		default:
			throw new RobolError("Invalid operator for arithmetic expression");
		}
		return res;
	}

}
