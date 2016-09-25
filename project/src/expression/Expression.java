package expression;
import java.util.HashMap;

/* <expr> ::= <identifier> | <number> | (<expr>) | <arith-exp> | <bool-expr> */

public abstract class Expression {
	public abstract int evaluate(HashMap<String,Integer> vars);
}