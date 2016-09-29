package expression;
import java.util.HashMap;
import robol.RobolError;

/* <arith-expr> ::= <expr> {{+|-|*}} <expr> */

public class ArithExpr extends Expression {
	private Operator opr;    // the arithmetic operator
	private Expression expL; // expression on the left
	private Expression expR; // expression on the right
	
	public ArithExpr(Operator opr, Expression expL, Expression expR) {
		this.opr = opr;
		this.expL = expL;
		this.expR = expR;
	}
	
	@Override
	public int evaluate(HashMap<String, Integer> vars) {
		int res = 0; // result
		switch(opr) {
		case PLUS_OPR:
			res = expL.evaluate(vars) + expR.evaluate(vars); break;
		case MINUS_OPR:
			res = expL.evaluate(vars) - expR.evaluate(vars); break;
		case MULT_OPR:
			res = expL.evaluate(vars) * expR.evaluate(vars); break;
		default:
			throw new RobolError("Invalid operator for arithmetic expression!");
		}
		return res;
	}
}