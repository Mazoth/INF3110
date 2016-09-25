package statement;
import java.util.HashMap;
import java.util.ArrayList;
import expression.BoolExpr;
import robol.Robot;

/* <while-stmt> ::= while (<bool-expr>) {<stmt>+} */

public class WhileStmt extends Statement {
	private BoolExpr condition;
	private ArrayList<Statement> stmtList;
	
	public WhileStmt(BoolExpr cond, ArrayList<Statement> list) {
		this.condition = cond;
		this.stmtList = list;
	}
	
	public WhileStmt(BoolExpr cond, Statement first, Statement... others) {
		this.condition = cond;
		stmtList = new ArrayList<Statement>();
		stmtList.add(first);
		for(Statement s : others) stmtList.add(s);
	}
	
	public void addStmt(Statement... stmts) {
		for(Statement s : stmts) stmtList.add(s);
	}
	
	@Override
	public void interpret(Robot r, HashMap<String, Integer> vars) {
		while(condition.evaluate(vars) == 1) {
			for(Statement s : stmtList) s.interpret(r, vars);
		}
	}
}