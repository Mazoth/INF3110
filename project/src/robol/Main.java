package robol;
import java.lang.reflect.*;
import expression.*;
import statement.*;
import static expression.Operator.*;
import static statement.Direction.*; 

public class Main {
	public static void main(String[] args) {
		runTests(4);
	}
	
	public static void runTests(int num) {
		for(int i = 1; i <= num; i++) {
			try {
				System.out.println("================================");
				System.out.println("============ Test " + i + " ============");
				System.out.println("================================");
				String testName = "programTest" + i + "_AST";
				Method testMethod = Main.class.getMethod(testName);
				Program p = (Program) testMethod.invoke(null);
				p.interpret();
			} catch(RobolError e) {
				e.printStackTrace();
			} catch(NoSuchMethodException
			        | IllegalAccessException 
			        | InvocationTargetException e) {}
		}
	}
	
	public static Program programTest1_AST() {
		Grid grid = new Grid(64,64);
		StartStmt start = new StartStmt(new NumExpr(23), new NumExpr(30));
		Robot r = new Robot(grid, start);
		ArithExpr a1 = new ArithExpr(PLUS_OPR, new NumExpr(2), new NumExpr(4)),
		          a2 = new ArithExpr(PLUS_OPR, new NumExpr(10), new NumExpr(27));
		Statement s1 = new MoveStmt(WEST, new NumExpr(15)),
		          s2 = new MoveStmt(SOUTH, new NumExpr(15)),
		          s3 = new MoveStmt(EAST, a1),
		          s4 = new MoveStmt(NORTH, a2);
		r.addStatement(s1, s2, s3, s4, new StopStmt());
		return new Program(grid, r);
	}
	
	public static Program programTest2_AST() {
		Grid grid = new Grid(64,64);
		StartStmt start = new StartStmt(new NumExpr(23), new NumExpr(6));
		Robot r = new Robot(grid, start);
		VarDecl   v1 = new VarDecl("i", new NumExpr(5)),
		          v2 = new VarDecl("j", new NumExpr(3));
		ArithExpr a1 = new ArithExpr(MULT_OPR, new NumExpr(3), new Identifier("i")),
		          a2 = new ArithExpr(MULT_OPR, new NumExpr(2), new Identifier("i")),
		          a3 = new ArithExpr(MULT_OPR, new NumExpr(3), new Identifier("j")),
		          a4 = new ArithExpr(PLUS_OPR, a2, a3),
		          a5 = new ArithExpr(PLUS_OPR, a4, new NumExpr(5));
		Statement s1 = new MoveStmt(NORTH, a1),
		          s2 = new MoveStmt(EAST, new NumExpr(15)),
		          s3 = new MoveStmt(SOUTH, new NumExpr(4)),
		          s4 = new MoveStmt(WEST, a5);
		r.addVarDecl(v1, v2);
		r.addStatement(s1, s2, s3, s4, new StopStmt());
		return new Program(grid, r);
	}
	
	public static Program programTest3_AST() {
		Grid grid = new Grid(64,64);
		StartStmt start = new StartStmt(new NumExpr(24), new NumExpr(6));
		Robot r = new Robot(grid, start);
		VarDecl   v1 = new VarDecl("i", new NumExpr(5)),
		          v2 = new VarDecl("j", new NumExpr(3));
		ArithExpr a1 = new ArithExpr(MULT_OPR, new NumExpr(3), new Identifier("i")),
		          a2 = new ArithExpr(MINUS_OPR, new Identifier("j"), new NumExpr(1));
		BoolExpr  b1 = new BoolExpr(GT_OPR, new Identifier("j"), new NumExpr(0));
		Statement s1 = new MoveStmt(SOUTH, new Identifier("j")),
		          s2 = new AssignStmt("j", a2),
		          s3 = new MoveStmt(NORTH, a1),
		          s4 = new MoveStmt(WEST, new NumExpr(15)),
		          s5 = new MoveStmt(EAST, new NumExpr(4)),
		          s6 = new WhileStmt(b1, s1, s2);
		r.addVarDecl(v1, v2);
		r.addStatement(s3, s4, s5, s6, new StopStmt());
		return new Program(grid, r);
	}
	
	public static Program programTest4_AST() {
		Grid grid = new Grid(64,64);
		StartStmt start = new StartStmt(new NumExpr(1), new NumExpr(1));
		Robot r = new Robot(grid, start);
		VarDecl   v1 = new VarDecl("j", new NumExpr(3));
		BoolExpr  b1 = new BoolExpr(GT_OPR, new Identifier("j"), new NumExpr(0));
		Statement s1 = new MoveStmt(NORTH, new Identifier("j")),
		          s2 = new WhileStmt(b1, s1);
		r.addVarDecl(v1);
		r.addStatement(s2, new StopStmt());
		return new Program(grid, r);
	}
}