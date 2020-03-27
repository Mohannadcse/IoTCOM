package archExtractor;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.groovy.ast.expr.BinaryExpression;
import org.codehaus.groovy.ast.expr.Expression;
import org.codehaus.groovy.ast.stmt.Statement;


public class BasicBlock {
    private List<Statement> StmtList;
    private int id;
	private String parent;
    private String iftype;
    private boolean nodeAdded;
    private BinaryExpression successors;
//    private BinaryExpression predecessor;
    private Expression predecessor;
    private boolean first;
    private boolean nested;
    private boolean splitted;
    private String splittedBBID;
    private String nodeID;
    
    public String getNodeID() {
		return nodeID;
	}

	public void setNodeID(String nodeID) {
		this.nodeID = nodeID;
	}

	public String getSplittedBBID() {
		return splittedBBID;
	}

	public void setSplittedBBID(String splittedBBID) {
		this.splittedBBID = splittedBBID;
	}

	public BasicBlock() {
		StmtList = new ArrayList<>();
		nodeAdded = false;
		splitted = false;
		nodeID = "";
	}

	public boolean isSplitted() {
		return splitted;
	}

	public void setSplitted(boolean splitted) {
		this.splitted = splitted;
	}

	public boolean isNodeAdded() {
		return nodeAdded;
	}

	public void setNodeAdded(boolean nodeAdded) {
		this.nodeAdded = nodeAdded;
	}

	public void setNested(boolean nested) {
		this.nested = nested;
	}

	public boolean isNested() {
		return nested;
	}
	
    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
    
	public Expression getPredecessor() {
		return predecessor;
	}

	public void setPredecessor(Expression predecessor) {
		this.predecessor = predecessor;
		first = false;
	}

	public boolean isFirst() {
		return first;
	}

	public void setFirst(boolean first) {
		this.first = first;
	}
	
    public List<Statement> getStmtList() {
		return StmtList;
	}

	public void addStmtList(Statement s) {
		StmtList.add(s);
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}
	
	public String getIftype() {
		return iftype;
	}

	public void setIftype(String iftype) {
		this.iftype = iftype;
	}

	public BinaryExpression getSuccessors() {
		return successors;
	}

	public void setSuccessors(BinaryExpression successors) {
		this.successors = successors;
	}
}
