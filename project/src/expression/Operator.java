package expression;

public enum Operator {
	additionOpr, subtractionOpr, multiplyOpr,
	greaterOpr, lessOpr, equalOpr;
	
	public boolean isArithmeticOpr() {
		return this == additionOpr || 
		       this == subtractionOpr ||
		       this == multiplyOpr;
	}
	
	public boolean isBooleanOpr() {
		return this == greaterOpr ||
		       this == lessOpr ||
		       this == equalOpr;
	}
}