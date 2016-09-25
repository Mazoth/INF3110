package robol;

/* <program> ::= <grid> <robot> */

class Program {
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