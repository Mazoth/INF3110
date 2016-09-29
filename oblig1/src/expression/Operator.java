package expression;

public enum Operator {
	PLUS_OPR, MINUS_OPR, MULT_OPR,
	GT_OPR, LT_OPR, EQ_OPR;
	
	public boolean isArithmeticOpr() {
		return this == PLUS_OPR  || // addition operator 
		       this == MINUS_OPR || // subtraction operator
		       this == MULT_OPR;    // multiplication operator
	}
	
	public boolean isBooleanOpr() {
		return this == GT_OPR || // greater than operator
		       this == LT_OPR || // less than operator
		       this == EQ_OPR;   // equal operator
	}
}