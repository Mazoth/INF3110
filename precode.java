public class Oblig1 {
	interface Robol {
		void interpret();
	}

	class Program implements Robol {
		Grid grid;
		Robot robot;
		
		public Program(Grid grid, Robot robot) {
			this.grid = grid;
			this.robot = robot;
		}
		
		public void interpret() {
			robot.interpret();
		}
	}
	/

	class Robot implements Robol {
		public void interpret() {
			//Write
		}
	}

	abstract class Statement implements Robol {
		public abstract void interpret();
	}

	class Assignment extends Statement {
		public void interpret() {
			//WRite
		}
	}

	class While extends Statement {
		BoolExp condition;
		List<Statement> statements;
		
		public void intepret() {
			//WRite
		}
	}

	abstract class Expression {
		//Write
	}

	abstract class BoolExp extends Expression {
		protected Expression left;
		protected Expression rigth;	
	}
}
