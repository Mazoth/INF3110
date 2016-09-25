package expression;
import java.util.HashMap;

/* <exp> ::= <identifier> | <number> | <exp> | <arith-exp> | <bool-exp> */
public abstract class Expression {
	public abstract int evaluate(HashMap<String,Integer> vars);
}