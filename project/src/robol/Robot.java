package robol;
import java.util.ArrayList;
import java.util.HashMap;
import expression.VarDecl;
import statement.Statement;
import statement.StartStmt;

/* <robot> ::= <var-decl>* <start> <stmt>* */

public class Robot {
	static int count = 0;
	private int idNum;
	private int x = -1; // x-position on the grid (-1 for out of bound)
	private int y = -1; // y-position on the grid (-1 for out of bound)
	private Grid grid;
	private StartStmt start;
	private HashMap<String,Integer> varList = new HashMap<String,Integer>();
	private ArrayList<Statement> stmtList = new ArrayList<Statement>();
	private ArrayList<VarDecl> declList = new ArrayList<VarDecl>();
	
	public Robot(Grid grid, StartStmt start) {
		this.idNum = ++count;
		this.grid = grid;
		this.start = start;
	}
	
	public Robot(Grid grid, StartStmt start,
	             ArrayList<VarDecl> declList, ArrayList<Statement> stmtList) {
		this.grid = grid;
		this.start = start;
		this.declList = declList;
		this.stmtList = stmtList;
	}
	
	public void addVarDecl(VarDecl... decls) {
		for(VarDecl d : decls) declList.add(d);
	}
	
	public void addStatement(Statement... stmts) {
		for(Statement s : stmts) stmtList.add(s);
	}
	
	public String toString() {
		return "Robot " + idNum + " is at position (" + x + "," + y + ")"
		       + " on " + grid.toString();
	}
	
	public void moveByAbsPos(int x, int y) {
		if(grid.isOutOfBound(x, y)) {
			this.x = -1;
			this.y = -1;
			String m = "Robot " + idNum + " fell out of " + grid.toString();
			throw new RobolError(m);
		}
		this.x = x;
		this.y = y;
	}
	
	public void moveByRelPos(int x, int y) {
		if(this.x >= 0 && this.y >= 0) {
			x += this.x;
			y += this.y;
		}
		moveByAbsPos(x,y);
	}
	
	public void interpret() {
		// Interpret all variable declarations
		for(VarDecl decl : declList) decl.interpret(varList);
		
		// Interpret the start statement
		start.interpret(this, varList);
		
		// Interpret all statements in the statement list
		for(Statement stmt : stmtList) stmt.interpret(this, varList);
	}
}