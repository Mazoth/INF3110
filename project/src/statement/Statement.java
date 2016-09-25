package statement;
import java.util.HashMap;
import robol.Robot;

/* <stmt> ::= <start> | <stop> | <move> | <assignment> | <while> */

public abstract class Statement {
	public abstract void interpret(Robot r, HashMap<String,Integer> vars);
}