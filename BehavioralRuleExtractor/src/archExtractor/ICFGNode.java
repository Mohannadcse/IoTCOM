package archExtractor;

import java.util.HashSet;
import java.util.Set;

import org.codehaus.groovy.ast.stmt.ExpressionStatement;
import org.codehaus.groovy.ast.stmt.Statement;
import org.javatuples.Pair;
import org.javatuples.Quartet;

import groovy.lang.Tuple;

public class ICFGNode {
    private Statement statement;
    private String stmtType;
    private String expType;
    private Integer lineNumber;
	private Integer id;
    private String tag;
    private String metadata;
    private Pair<String,Integer> parent;
    private String methodName;
    
    
public String getMethodName() {
		return methodName;
	}

	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}

	//    private ArrayList<Pair<String,Integer>> cg;
    private Set<Quartet<Integer, String, String, String>> predecessors;
    

//	public void setPredecessorsT(groovy.lang.Tuple pred) {
//		predecessorsT.add(pred);
//	}

	public ICFGNode(Statement stmt) {
    	metadata = "";
    	id = 0;
        statement = stmt;
        lineNumber = stmt.getLineNumber();
        stmtType = statement.getClass().getSimpleName();
        if (statement instanceof ExpressionStatement) {
        	expType = ((ExpressionStatement) statement).getExpression().getClass().getSimpleName();
        }
        predecessors = new HashSet<Quartet<Integer,String,String,String>>();
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
	
    public Set<Quartet<Integer, String, String, String>> getPredecessors() {
		return predecessors;
	}

	public void addPredecessors(Quartet<Integer, String, String, String> pred) {
		this.predecessors.add(pred);
	}

	public Statement getStatement() {
		return statement;
	}

	public void setStatement(Statement statement) {
		this.statement = statement;
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

	public Pair<String, Integer> getParent() {
		return parent;
	}

	public void setParent(Pair<String, Integer> currentMethod) {
		this.parent = currentMethod;
	}
	
//	public ArrayList<Pair<String, Integer>> getCg() {
//		return cg;
//	}
//
//	public void setCg(Pair<String, Integer> meth) {
//		this.cg.add(meth);
//	}

	public void joinPredecessors(Set<Tuple> preds){
//        predecessors.addAll(preds);
    }
	
	public void clearIndirectPredecessors(){
//        predecessors.removeAll {
//            it->
//                it.get(1)!='IfStatement'
//        }
    }
}
