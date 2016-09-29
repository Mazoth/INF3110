package statement;
import java.util.HashMap;
import robol.Robot;

public class StopStmt extends Statement {
	@Override
	public void interpret(Robot r, HashMap<String, Integer> vars) {
		// Note that param "vars" is not really needed for this method
		// Print out the robot's current position whenever it stops
		System.out.println(r.toString());
	}
}