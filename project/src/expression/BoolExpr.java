package expression;
import java.util.HashMap;
import robol.RobolError;

/* <bool-expr> ::= <expr> {{>|<|=}} <expr> */

public class BoolExpr extends Expression {
	private Operator opr;    // the Boolean operator
	private Expression expL; // expression on the left
	private Expression expR; // expression on the right
	
	public BoolExpr(Operator opr, Expression expL, Expression expR) {
		this.opr = opr;
		this.expL = expL;
		this.expR = expR;
	}
	
	@Override
	public int evaluate(HashMap<String, Integer> vars) {
		int res = 0; // this is either TRUE (res=1) or FALSE (res=0)
		switch(opr) {
		case GT_OPR:
			if(expL.evaluate(vars) >  expR.evaluate(vars)) res = 1; break;
		case LT_OPR:
			if(expL.evaluate(vars) <  expR.evaluate(vars)) res = 1; break;
		case EQ_OPR:
			if(expL.evaluate(vars) == expR.evaluate(vars)) res = 1; break;
		default:
			throw new RobolError("Invalid operator for Boolean expression!");
		}
		return res;
	}
}