package robol;

/* <program> ::= <grid> <robot> */

class Program {
	/* 
	 * Note that the grid is not really necessary here, because the robot
	 * has the grid already. However, we still add the grid here so that
	 * it would be easier to extend the entire program such that the grid
	 * can later be allowed to contain many different robots.
	 */
	private Grid grid;
	private Robot robot;
	
	public Program(Grid grid, Robot robot) {
		this.grid = grid;
		this.robot = robot;
	}
	
	public void interpret() {
		robot.interpret();
	}
}