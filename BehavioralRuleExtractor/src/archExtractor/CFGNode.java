package archExtractor;

import java.util.HashSet;
import java.util.Set;

import org.codehaus.groovy.ast.stmt.Statement;
import org.javatuples.Quartet;
import org.codehaus.groovy.ast.stmt.ExpressionStatement;

import groovy.lang.Tuple;

public class CFGNode {
    private Statement statement;
    private String stmtType;
    private String expType;
    private Integer lineNumber;
    private Integer id;
    private String tag;
    private String metadata;
    //private Integer predecessor
    private Tuple parent;
    private Set<Quartet<Integer, String, String, String>> predecessors;
    public CFGNode(Statement stmt){
        statement = stmt;
        lineNumber = stmt.getLineNumber();
        stmtType = statement.getClass().getSimpleName();
        if (statement instanceof ExpressionStatement) {
//            expType = statement.asType(ExpressionStatement).getExpression().getClass().getSimpleName();
            expType = ((ExpressionStatement) statement).getExpression().getClass().getSimpleName();
        }
//        predecessors = new HashSet<Tuple<Integer,String,String,String>>();
        predecessors = new HashSet<Quartet<Integer,String,String,String>>();
    }
	public Statement getStatement() {
		return statement;
	}
	public void setStatement(Statement statement) {
		this.statement = statement;
	}
	public String getStmtType() {
		return stmtType;
	}
	public void setStmtType(String stmtType) {
		this.stmtType = stmtType;
	}
	public String getExpType() {
		return expType;
	}
	public void setExpType(String expType) {
		this.expType = expType;
	}
	public Integer getLineNumber() {
		return lineNumber;
	}
	public void setLineNumber(Integer lineNumber) {
		this.lineNumber = lineNumber;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getMetadata() {
		return metadata;
	}
	public void setMetadata(String metadata) {
		this.metadata = metadata;
	}
	public Tuple getParent() {
		return parent;
	}
	public void setParent(Tuple parent) {
		this.parent = parent;
	}
	public Set<Quartet<Integer, String, String, String>> getPredecessors() {
		return predecessors;
	}
	public void setPredecessors(Set<Quartet<Integer, String, String, String>> predecessors) {
		this.predecessors = predecessors;
	}
	
	   public void joinPredecessors(Set<Tuple> preds){
//	        predecessors.add(preds);
	    }
	    public void clearIndirectPredecessors(){
//	        predecessors.removeAll {
//	            it->
//	                it.get(1)!='IfStatement'
//	        }
	    }
}
