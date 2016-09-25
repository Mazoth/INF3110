package statement;
import java.util.HashMap;
import robol.Robot;

public class StopStmt extends Statement {
	@Override
	public void interpret(Robot r, HashMap<String, Integer> vars) {
		System.out.println(r.toString());
	}
}