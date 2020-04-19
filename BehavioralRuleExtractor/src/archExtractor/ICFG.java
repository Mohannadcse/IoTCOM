package archExtractor;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

import org.codehaus.groovy.ast.MethodNode;
import org.codehaus.groovy.ast.expr.Expression;
import org.codehaus.groovy.ast.expr.MethodCallExpression;
import org.codehaus.groovy.ast.stmt.BlockStatement;
import org.codehaus.groovy.ast.stmt.CaseStatement;
import org.codehaus.groovy.ast.stmt.CatchStatement;
import org.codehaus.groovy.ast.stmt.ExpressionStatement;
import org.codehaus.groovy.ast.stmt.IfStatement;
import org.codehaus.groovy.ast.stmt.Statement;
import org.codehaus.groovy.ast.stmt.SwitchStatement;
import org.javatuples.Quartet;

public class ICFG {
	List<ICFGNode> cfg;
	List<ICFGNode> IfStatements;
	List<ICFGNode> MethodCallExpressions;
	List<ICFGNode> SwithCaseStatements;

	/* Temp variables*/
	int counter = 0;
	SwitchStatement currentSwitch;
	public ICFG(List<ICFGNode> nodes){
		cfg = nodes;
		IfStatements = new ArrayList<ICFGNode>();
		MethodCallExpressions = new ArrayList<ICFGNode>();
		SwithCaseStatements = new ArrayList<ICFGNode>();
		init();

//		System.out.println("Details about Command APIs:");
		sinkPrinter();
//		System.out.println("\n--------------------------------------------");

//		List<Integer> sinks = getSinks();
//
//		for (Integer sink : sinks) {
//			System.out.println(getAnnotation(sink));
//			System.out.println("******");
//		}
	}

	private void init(){
		/* Initialize Id*/
//		String currentSwitch;
//		System.out.println("CFG size(): "+cfg.size());
		for (ICFGNode node : cfg) {
			node.setId(++counter);
//			System.out.println("Counter:: "+ counter);
			//                System.out.println("node.getStmtType():: "+ node.getStmtType());
			if(node.getStmtType().contains("IfStatement")){
				handleIf(node);
			}
			else if(node.getStmtType().contains("CatchStatement")){
				handleCatch(node);
			}
			else if (node.getStmtType().contains("SwitchStatement")){
				handleSwitchCase(node);
			}
			else if (node.getExpType() != null && node.getExpType().equals("MethodCallExpression")){
				//                    MethodCallExpression exp = node.getStatement().asType(ExpressionStatement).getExpression().asType(MethodCallExpression);
				Expression exp = ((ExpressionStatement) node.getStatement()).getExpression();
				if (((MethodCallExpression) exp).getMethodAsString() != null) {
				if(((MethodCallExpression) exp).getMethodAsString().toLowerCase().contains("subscribe")){
					handleSubscribe(node);
				}
				else if(((MethodCallExpression) exp).getMethodAsString().toLowerCase().contains("schedule")){
					handleSchedule(node);
				}
				else{
					handleNormalCall(node);
				}
				}
			}
			else if (node.getExpType() != null && node.getExpType().contains("MapExpression")){
				//                    handleRestAPI(node);
			}
			else{
				//println node.getStatementType()+' '+node.getExpressionType()
			}
		}
	}

	private void handleCatch(ICFGNode catchnode){
		Statement block = ((CatchStatement) catchnode.getStatement()).getCode();
		if (block instanceof BlockStatement) {
			for (Statement blk : ((BlockStatement) block).getStatements()) {
				ICFGNode node = getNodeByLineNumber(blk.getLineNumber());
				Quartet<Integer, String, String, String> tuple = new Quartet<Integer, String, String, String>(catchnode.getId(),"CATCH",((CatchStatement) block).getExceptionType().getName(), null);
				node.addPredecessors(tuple);
			}

		}
	}

	private void handleIf(ICFGNode ifnode){
		//	        IfStatement ifstmt = ifnode.getStatement().asType(IfStatement);
		IfStatement ifstmt = (IfStatement) ifnode.getStatement();
		Integer if_id = ifnode.getId();
//		System.out.println("ifstmt.getIfBlock().getClass().getSimpleName():: "+ ifstmt.getIfBlock().getClass().getSimpleName());
		if(!(ifstmt.getIfBlock().getClass().getSimpleName().contains("EmptyStatement"))){
//			System.out.println("IfBlock");
			for (Statement blk : ((BlockStatement) ((IfStatement) ifstmt).getIfBlock()).getStatements()) {
				ICFGNode node = getNodeByLineNumber(blk.getLineNumber());
				Quartet<Integer, String, String, String> tuple = new Quartet<Integer, String, String, String>(if_id,"IfStatement","IfBlock",ifstmt.getBooleanExpression().getText());
				node.addPredecessors(tuple);
//				System.out.println("node.getPredecessors().size(IfBlock):: "+ node.getPredecessors().size());
			}
		}

		if(ifstmt.getElseBlock().getClass().getSimpleName().contains("IfStatement")){
			IfStatement nestedIf = (IfStatement) ifstmt.getElseBlock();
			ICFGNode node = getNodeByLineNumber(nestedIf.getLineNumber());
			Quartet<Integer, String, String, String> tuple = new Quartet<Integer, String, String, String>(if_id,"IfStatement","ElseBlock",ifstmt.getBooleanExpression().getText());
			node.addPredecessors(tuple);
//			System.out.println("node.getPredecessors().size(ElseBlock):: "+ node.getPredecessors().size());
		}
		else if(! (ifstmt.getElseBlock().getClass().getSimpleName().contains("EmptyStatement")) && ! (ifstmt.getElseBlock().getClass().getSimpleName().contains("IfStatement"))){
			if(ifstmt.getElseBlock().getClass().getName().contains("BlockStatement")){
				for (Statement blk: ((BlockStatement) ((IfStatement) ifstmt).getElseBlock()).getStatements()) {
					ICFGNode node = getNodeByLineNumber(blk.getLineNumber());
					Quartet<Integer, String, String, String> tuple = new Quartet<Integer, String, String, String>(if_id,"IfStatement","ElseBlock",ifstmt.getBooleanExpression().getText());
					node.addPredecessors(tuple);
//					System.out.println("node.getPredecessors().size(EmptyStatement):: "+ node.getPredecessors().size());
				}
			}
			else{

			}
		}
	}

	private void handleSubscribe(ICFGNode methodCallNode){
//		System.out.println("Inside handleSubscribe");
		//	        MethodCallExpression exp = methodCallNode.getStatement().asType(ExpressionStatement).getExpression().asType(MethodCallExpression);
		Expression exp = ((ExpressionStatement) methodCallNode.getStatement()).getExpression();
		methodCallNode.setTag("subscribe");
		methodCallNode.setMetadata(exp.getText());
	}

	private void handleNormalCall(ICFGNode methodCallNode){
		//	        MethodCallExpression exp = methodCallNode.getStatement().asType(ExpressionStatement).getExpression().asType(MethodCallExpression);
		Expression exp = ((ExpressionStatement) methodCallNode.getStatement()).getExpression();
		methodCallNode.setMetadata(exp.getText());
	}

	private void handleSchedule(ICFGNode methodCallNode){
		//	        MethodCallExpression exp = methodCallNode.getStatement().asType(ExpressionStatement).getExpression().asType(MethodCallExpression);
		Expression exp = ((ExpressionStatement) methodCallNode.getStatement()).getExpression();
//		Set<Quartet<Integer, String, String, String>> predecessors = methodCallNode.getPredecessors();
		methodCallNode.setTag("schedule");
		methodCallNode.setMetadata(exp.getText());
	}

	private void handleSwitchCase(ICFGNode switchnode){
		if(switchnode.getStmtType().contains("SwitchStatement")){
			SwitchStatement stmt = (SwitchStatement) switchnode.getStatement();
			for (CaseStatement case_stmt : stmt.getCaseStatements()) {
				BlockStatement block = (BlockStatement) ((CaseStatement) case_stmt).getCode();
				System.out.println("SW blk: "+ block.getStatements().size());
				for (Statement statement : block.getStatements()) {
					System.out.println("Stt: "+ statement);
					ICFGNode node = getNodeByLineNumber(statement.getLineNumber());
					System.out.println("after getLineNumber: "+ case_stmt.getExpression().getText());
					Quartet<Integer, String, String, String> tuple = new Quartet<Integer, String, String, String>(switchnode.getId(),"CASE",stmt.getExpression().getText(),case_stmt.getExpression().getText());
					System.out.println("Node:: "+ node.getMethodName());
					node.addPredecessors(tuple);
				}
			}
		}
	}

	public ICFGNode getNodeByLineNumber(Integer number){
		ICFGNode result = null;
		for (ICFGNode node : cfg) {
			if (node.getLineNumber() == number) {
				result = node;
			}
		}
		return result;
	}
	public ICFGNode getNodeById(Integer id){
		ICFGNode result = null;
		for (ICFGNode node : cfg) {
			if (node.getId() == id) {
				result = node;
			}
		}
		return result;
	}
	public ICFGNode get(Integer id){
		ICFGNode result = null;
		for (ICFGNode it : cfg) {
			if (it.getId() == id) {
				result = it;
			}
		}
		return result;
	}
	public String getAnnotation(Integer id){
//		System.out.println("Inside getAnnotation");
		ICFGNode node = getNodeById(id);
		Stack<Quartet<Integer, String, String, String>> stack = new Stack<Quartet<Integer, String, String, String>>();
		Quartet<Integer, String, String, String> tuple = new Quartet<Integer, String, String, String>(id,node.getParent().getValue0(),"sink",node.getMetadata());
		stack.push(tuple);

		if(node!=null){
			for (Quartet<Integer, String, String, String> it : node.getPredecessors()) {
				stack.push(it);
//				System.out.println("it.getValue0():: "+ it.getValue0());
				processPredecessor(it.getValue0(),stack);
			}
		}
		return stack.toString();
	}
	private Stack<Quartet<Integer, String, String, String>> processPredecessor(Integer id, Stack<Quartet<Integer, String, String, String>> stack){
		ICFGNode node = getNodeById(id);
		if(node!=null){
			for (Quartet<Integer, String, String, String> it : node.getPredecessors()) {
				stack.push(it);
//				System.out.println("it.getValue0():: "+ it.getValue0());
				processPredecessor(it.getValue0(), stack);
			}
		}

		return stack;
	}
	/*
	//this methd isn't used  in the ContexIoT
	public void printTriggers(Integer id) throws InstantiationException, IllegalAccessException{
		ICFGNode node = getNodeById(id);	        
		Quartet<Integer, String, String, String> tuple = new Quartet<Integer, String, String, String>(node.getId(),"sink", node.getLineNumber().toString(),node.getMetadata());

		if(node!=null){
			for (Quartet<Integer, String, String, String> it : node.getPredecessors()) {
				Queue q = null;
				q.add(tuple);
				q.add(it);
				processTriggers(it.getValue0(), q);
			}
		}
	}
	//this methd isn't used  in the ContexIoT
	private void processTriggers(Integer id, Queue queue) throws InstantiationException, IllegalAccessException {
		ICFGNode node = getNodeById(id);
		if(node!=null && node.getPredecessors().size()>0){
			System.out.println("Q size:: "+queue.size());
			for (Quartet<Integer, String, String, String> it : node.getPredecessors()) {
				Queue q = queue.getClass().newInstance();
				for (Object e : queue) {
					q.add(e);
				}
				q.add(it);
			}
		}else{
			for(Object s : queue) { 
				System.out.println("Print Queue");
				System.out.println(s.toString()); 
			}
		}
	}
	public void visitPrinter(){
		System.out.println("Inside visitPrinter");
		System.out.println("cfg Size:: "+ cfg.size());
		for (ICFGNode node : cfg) {
			System.out.println(
					node.getLineNumber()+
					"\t"+node.getStmtType()+
					"\t"+node.getMetadata()+
					"\t"+node.getId()+
					"\t"+node.getTag()+
					"\t"+node.getParent()+
					"\t"+node.getPredecessors()//+node.getPredecessorsT().sort()
					);
		}
	}
	*/
	public List<Integer> getSinks(){
//		System.out.println("Inside getSinks");
		List<Integer> result = new ArrayList<Integer>();
		//	        System.out.println("CFG size:: "+ cfg.size());
		for (ICFGNode node: cfg) {
			if(node.getTag() != null && node.getTag().equals("sink")){
				result.add(node.getId());
			}
		}
		return result;
	}
	public void sinkPrinter(){
//		System.out.println("Inside sinkPrinter");
		for (ICFGNode node: cfg) {
			if(node.getTag()=="sink"){
				System.out.println("LineNum: "+node.getLineNumber() +
						"\t"+node.getMetadata()+ 
						"\tnodeID: " + node.getId() + 
						"\tnodeTag: " + node.getTag() + 
						"\tEntryPoint: " + node.getParent() + 
						"\t" + node.getPredecessors()
						);
			}
		}
	}
	
	public void findEntryToCmd(String cmd, MethodNode node, ArrayList<String> methodHandlers) {			
			System.out.println("MethodName: "+ node.getName());
			Statement s = node.getCode();
			if (s instanceof BlockStatement) {
				System.out.println("S:: "+ s);
				List<Statement> stmts = ((BlockStatement) s).getStatements();
				for (Statement st : stmts) {
					System.out.println("\tST: "+ st);
					if (st instanceof ExpressionStatement) {
						Expression exp = ((ExpressionStatement) st).getExpression();
//						System.out.println("\t\tExp:: "+exp);
						if (exp instanceof MethodCallExpression)
							System.out.println("\t\tMCE: "+ exp.getText());
					}
				}
		}
	}
}