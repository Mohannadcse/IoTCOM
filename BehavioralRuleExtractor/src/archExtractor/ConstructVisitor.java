package archExtractor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.codehaus.groovy.ast.ClassCodeVisitorSupport;
import org.codehaus.groovy.ast.MethodNode;
import org.codehaus.groovy.ast.expr.ArgumentListExpression;
import org.codehaus.groovy.ast.expr.BinaryExpression;
import org.codehaus.groovy.ast.expr.ConstantExpression;
import org.codehaus.groovy.ast.expr.DeclarationExpression;
import org.codehaus.groovy.ast.expr.Expression;
import org.codehaus.groovy.ast.expr.GStringExpression;
import org.codehaus.groovy.ast.expr.MapEntryExpression;
import org.codehaus.groovy.ast.expr.MapExpression;
import org.codehaus.groovy.ast.expr.MethodCallExpression;
import org.codehaus.groovy.ast.expr.NamedArgumentListExpression;
import org.codehaus.groovy.ast.expr.NotExpression;
import org.codehaus.groovy.ast.expr.PropertyExpression;
import org.codehaus.groovy.ast.expr.TupleExpression;
import org.codehaus.groovy.ast.stmt.BlockStatement;
import org.codehaus.groovy.ast.stmt.BreakStatement;
import org.codehaus.groovy.ast.stmt.DoWhileStatement;
import org.codehaus.groovy.ast.stmt.EmptyStatement;
import org.codehaus.groovy.ast.stmt.ExpressionStatement;
import org.codehaus.groovy.ast.stmt.ForStatement;
import org.codehaus.groovy.ast.stmt.IfStatement;
import org.codehaus.groovy.ast.stmt.ReturnStatement;
import org.codehaus.groovy.ast.stmt.Statement;
import org.codehaus.groovy.ast.stmt.WhileStatement;
import org.codehaus.groovy.control.SourceUnit;
import org.graphstream.graph.Graph;
import org.graphstream.graph.implementations.MultiGraph;
import org.javatuples.Pair;
import org.javatuples.Quartet;
import org.javatuples.Triplet;

import util.Helper;

public class ConstructVisitor extends ClassCodeVisitorSupport {
	Graph cg;
	public ArrayList<String> globals;
	Pair<String, Integer> currentMethod;
	List <String> allCommandsList;
	Set<String> validMethods;
	List<ICFGNode> nodes;
	List <Triplet<String, String, List<Pair<Expression, String>>> > intraCallList;
	List <Triplet<String, String, String> >  specialCapTuple; 
	String appId;
	String appName;
	String appDescription;
	String appCategory;
	HashSet<List<String>> cgLst;
	Helper hlp;
	List<String> foundCmdAPIs;
	private ArrayList<Pair<DeclarationExpression, String> > dexpressions;
	private HashSet<Triplet<String, String, String> > subscribeStmts;
	private List<Quartet<String, String, String, String> > deviceCap;
	private HashMap<Pair<String, String>,List<String>> numericCond;
	private HashMap<List<String>, List<String>> numericRange;
	
	public HashMap<Pair<String, String>, List<String>> getNumericCond() {
		return numericCond;
	}

	public ConstructVisitor(List <String> list, HashSet<Triplet<String, String, String>> subscibeList, List<Quartet<String, String, String, String>> dc, List<Triplet<String,String,String>> specIn) {
		cg = new MultiGraph("CG"); 
		allCommandsList = list;
		validMethods = new HashSet<>();
		nodes = new ArrayList<ICFGNode>();
		intraCallList = new ArrayList<Triplet<String, String, List<Pair<Expression, String>>> >();
		cgLst = new HashSet<List<String>>();
		hlp = new Helper(); 
		foundCmdAPIs = new ArrayList<>();
		specialCapTuple = specIn;
		dexpressions = new ArrayList<>();
		subscribeStmts = subscibeList;
		deviceCap = dc;
		numericCond = new HashMap<>();	
	}

	List<ICFGNode> getNodes(){
		return nodes;
	}

	@Override
	protected SourceUnit getSourceUnit() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void  visitMethod(MethodNode node){
		currentMethod = new Pair<String, Integer>(node.getName(),node.getParameters().length);
		if(node.getName() != "main" && node.getName() != "run") {
			validMethods.add(node.getName());
			Statement s = node.getCode();

			List<Pair<Expression, String>> ifCondLst = new ArrayList<>();
			List<Pair<Expression, String>> elseCondLst = new ArrayList<>();
			List <Statement> block = new ArrayList<>();
			
			handleABlock(s,node.getName(), "NAN", ifCondLst, elseCondLst, block);
		}
		super.visitMethod(node);
	}
	
	public Set<String> getValidMethods() {
		return validMethods;
	}

	public void generateRange() {
		
	}
	
	private void parsePredicate(BinaryExpression bex, String currentMethod) {
//		List<List<String>> condTuple = new ArrayList<>();
		Expression leftExpr = bex.getLeftExpression();
		Expression rightExpr = bex.getRightExpression();
		String operation = bex.getOperation().getText();
//		System.out.println("\tLeft: "+ leftExpr.getText() + " Type: "+ leftExpr.getClass().getSimpleName());
//		System.out.println("\tRight: "+ rightExpr.getText() + " Type: "+ rightExpr.getClass().getSimpleName());

		//I need to check the operation first
		// if the operation &&, || this means this is a compound predicate
		//in other words, for each sub predicate (left and right), I need to find <cap, attr, value> 
		//
		if (operation.equals("&&") || operation.equals("||")) {
			if (leftExpr instanceof BinaryExpression) {
				parsePredicate((BinaryExpression) leftExpr, currentMethod);
			}
			if (rightExpr instanceof BinaryExpression) {
				parsePredicate((BinaryExpression) rightExpr, currentMethod);
			}
		} else {
			//1s: I need to check if the boolean expression is performing the comparison with a numerical value
			if (rightExpr instanceof ConstantExpression) {
//				System.out.println("Number: "+ isNumeric(rightExpr.getText()));
				if (Helper.isNumeric(rightExpr.getText())) {
					if (leftExpr instanceof PropertyExpression) {
						handlePropertyExpression(bex, currentMethod);
					} else if (leftExpr instanceof MethodCallExpression) {
						handleMethodCallExpression(bex);
					}
				}
			} 
		}
	}
	
	private List<String> handleMethodCallExpression(BinaryExpression bex) {
		String operation = bex.getOperation().getText();
		List <String> condTuple = new ArrayList<>();
		Expression leftExpr = bex.getLeftExpression();
		Expression rightExpr = bex.getRightExpression();
		String attr = null, cap, value = null;
		for (Quartet<String, String, String, String> d  : deviceCap) {
			if (d.getValue0().equals(((MethodCallExpression) leftExpr).getReceiver().getText())) {
				for (Triplet<String, String, String> s : subscribeStmts) {
					if (d.getValue0().equals(s.getValue0()))
						attr = s.getValue1();
				}
				cap = d.getValue0();
				value = rightExpr.getText();
				condTuple.add(cap);
				condTuple.add(attr);
			}
		}
		System.out.println("");
		if (value != null) {
			Pair<String, String> numOper = new Pair<String, String>(value, operation);
			numericCond.put(numOper,condTuple);
		}
		return condTuple;
	}
	
	private List<String> handleNotExpression(Expression expr){
		List<String> condTuple = new ArrayList<>();
		String obj, attr, value = null;
		
		Expression subExpr = ((NotExpression)expr).getExpression();
		
		if (subExpr instanceof MethodCallExpression) {
			if (expr.getText().contains("state")) {
				obj = "state";
				
				
				if (((MethodCallExpression) subExpr).getReceiver().getText().contains(".")) {
					attr = ((MethodCallExpression) subExpr).getReceiver().getText().split("\\.")[1];
				} else {
					attr = ((MethodCallExpression) subExpr).getReceiver().getText();
				}
				value = ((MethodCallExpression) subExpr).getArguments().getText();
				condTuple.add(obj);
				condTuple.add(attr);
				System.out.println("obj: "+ obj +"\tattr: "+ attr+"\tval: "+ value);
			}
		}	
//		for (Triplet<String, String, String> s : subscribeStmts) {
//			if (s.getValue0().equals(expr.getText())) {
//				obj = s.getValue0();
//				attr = s.getValue1();
//				//find cap
//				for (Quartet<String, String, String, String> d : deviceCap) {
//					if (s.getValue0().equals(d.getValue0())) {
//						//The assumption since not   
//						value = "no_value";
//						System.out.print("\t\tCap: "+ obj + "\tAttr: "+ attr + "\tValue: "+ value);
//						condTuple.add(obj);
//						condTuple.add(attr);
//						condTuple.add(value);
//					}
//				}
//			}
//		}
		return condTuple;
	}
	
	private List<String> handlePropertyExpression(BinaryExpression bex, String parentMethod) {
		List<String> condTuple = new ArrayList<>();
		Expression leftExpr = bex.getLeftExpression();
		Expression rightExpr = bex.getRightExpression();
		String operation = bex.getOperation().getText();
		
		String attr, cap, value = null;
		if (((PropertyExpression) leftExpr).getObjectExpression().getText().equals("evt")) {

			for (Triplet<String, String, String> s : subscribeStmts) {
				if (s.getValue2().equals(parentMethod)) {
					attr = s.getValue1();
					for (Quartet<String, String, String, String> d : deviceCap) {
						if (s.getValue0().equals(d.getValue0())) {
							cap = d.getValue0();
							value = rightExpr.getText();
							condTuple.add(cap);
							condTuple.add(attr);
						}
					}
				}
			}
		} else if (((PropertyExpression) leftExpr).getObjectExpression().getText().equals("state")) {
			cap = "state";
			attr = ((PropertyExpression) leftExpr).getPropertyAsString();
			value = rightExpr.getText();
			condTuple.add(cap);
			condTuple.add(attr);
		}
		if (value != null) {
			Pair<String, String> numOper = new Pair<String, String>(value, operation);
			numericCond.put(numOper,condTuple);
		}
		
		System.out.println("");
		return condTuple;
	}
	/*
	 * range format: 
	 * 	1st arg: List of capability and its attribute
	 * 	2nd arg: List of sorted integer values in the range. So if the range contains 2 values, this means we have 3 intervals
	 */
	public HashMap<List<String>, List<Integer>> generateNumericRange() {
		HashMap<List<String>, List<Integer>> range =  new HashMap<>();
		Set<List<String>> capTuple = new HashSet<>();
//		System.out.println("Size of numeric Cond: "+ numericCond.size());
		for (Pair<String, String> k : numericCond.keySet()) {
			capTuple.add(numericCond.get(k));
		}
		
		for (List<String> c : capTuple) {
			List<Integer> r = new ArrayList<>();
			for (Pair<String, String> k : numericCond.keySet()) {
				if (numericCond.get(k).hashCode() == c.hashCode()) {
					//converting the range values into int
					r.add(Integer.parseInt(k.getValue0()));
				} 
			}
			//I need to sort the numbers in the array r 
			Collections.sort(r);
			range.put(c	, r);
		}
		return range;
	}

	//Find command methods
	@Override
	protected void visitStatement(Statement statement) {
		if (!(statement instanceof BlockStatement) && statement.getLineNumber()>0) {
			ICFGNode node = new ICFGNode(statement);
			node.setParent(currentMethod);
			
			if (node.getExpType() != null && node.getExpType().equals("DeclarationExpression")) {
				Expression expr = ((ExpressionStatement) node.getStatement()).getExpression();				
				Pair<DeclarationExpression, String> e = new Pair<DeclarationExpression, String>((DeclarationExpression) expr, currentMethod.getValue0());
				dexpressions.add(e);
				
				//Find if the declaration expression contains specialCap
				String[] specialCap = new String[] { "state", "settings", "location" };
				List<String> listspecialCap = Arrays.asList(specialCap);
				String attr, obj, value = "", cap;
			}
			
			if (node.getStmtType().equals("IfStatement")){
//				System.out.println("Found IfStatement");
//				System.out.println("\tST: "+ ((IfStatement)node.getStatement()).getBooleanExpression().getText() + " __ " + ((IfStatement)node.getStatement()).getBooleanExpression().getExpression().getClass().getSimpleName());
				if (((IfStatement)node.getStatement()).getBooleanExpression().getExpression().getClass().getSimpleName().contains("BinaryExpression")) {
					BinaryExpression boolExpr = (BinaryExpression) ((IfStatement)node.getStatement()).getBooleanExpression().getExpression();
					parsePredicate(boolExpr, currentMethod.getValue0());
				} else if (((IfStatement)node.getStatement()).getBooleanExpression().getExpression().getClass().getSimpleName().contains("NotExpression")){
					handleNotExpression(((IfStatement)node.getStatement()).getBooleanExpression().getExpression());
				}
				
			}
			
			if (node.getExpType() != null && node.getExpType().equals("MethodCallExpression")){
				Expression expr = ((ExpressionStatement) node.getStatement()).getExpression();
				
				if(((MethodCallExpression) expr).getMethod() != null){
					if(((MethodCallExpression) expr).getMethod() instanceof GStringExpression){
						node.setMetadata(expr.getText());
						node.setMethodName(((MethodCallExpression) expr).getMethodAsString());
						node.setTag("sink");
					}
				}
				if (((MethodCallExpression) expr).getMethodAsString() != null) {
					for (String cmd : allCommandsList) {
						if (cmd.equalsIgnoreCase(((MethodCallExpression) expr).getMethodAsString())) {
							node.setMetadata(expr.getText());
							node.setMethodName(((MethodCallExpression) expr).getMethodAsString());
							node.setTag("sink");
							foundCmdAPIs.add(cmd);
//							System.out.println("\tCommand API: " + expr.getText()+" | LineNumber: "+ expr.getLineNumber());
						}
					}
				}

				if (((MethodCallExpression) expr).getMethodAsString() != null)
					if(((MethodCallExpression) expr).getMethodAsString().equals("definition")){
						String exp = ((MethodCallExpression) expr).getArguments().getType().getText();
						switch (exp) {
						case "ArgumentListExpression":
							ArgumentListExpression arglistexp = (ArgumentListExpression) ((MethodCallExpression) expr).getArguments();
							MapExpression map = (MapExpression) ((ArgumentListExpression) arglistexp).getExpression(0);
							List<MapEntryExpression> entrys = map.getMapEntryExpressions();
							for (MapEntryExpression entry : ((MapExpression) entrys).getMapEntryExpressions()) {
								String key = entry.getKeyExpression().getText();
								String value = entry.getValueExpression().getText();

								if(key.equalsIgnoreCase("name")){
									appName = value;
								}
								else if (key.equalsIgnoreCase("description")){
									appDescription = value;
								}
								else if (key.equalsIgnoreCase("category")){
									appCategory = value;
								}
							}

							break;
						default:
							TupleExpression tupleExpression = (TupleExpression) ((MethodCallExpression) expr).getArguments();
							NamedArgumentListExpression namedArgumentListExpression = (NamedArgumentListExpression) ((TupleExpression) tupleExpression).getExpression(0);                            
							for (MapEntryExpression entry : namedArgumentListExpression.getMapEntryExpressions()) {
								String key = entry.getKeyExpression().getText();
								String value = entry.getValueExpression().getText();

								if(key.equalsIgnoreCase("name")){
									appName = value;
								}
								else if (key.equalsIgnoreCase("description")){
									appDescription = value;
								}
								else if (key.equalsIgnoreCase("category")){
									appCategory = value;
								}
							}
						}
					}
			}
			nodes.add(node);
		}
	}

public ArrayList<Pair<DeclarationExpression, String>> getDexpressions() {
		return dexpressions;
	}

	public void handleRunIn(MethodCallExpression mce, List<Pair<Expression, String>> ifCondLst) {
		List<Expression> args = Helper.buildExprList(mce.getArguments());
		if (args.size() >= 2) {
//			Triplet<String, String, List<Pair<BinaryExpression, String>> > tr = new Triplet<String, String, List<Pair<BinaryExpression, String>> >(mce.getMethodAsString(), args.get(1).getText(), ifCondLst);
			Triplet<String, String, List<Pair<Expression, String>>> tr = new Triplet<String, String, List<Pair<Expression, String>> >(mce.getMethodAsString(), args.get(1).getText(), ifCondLst);
			intraCallList.add(tr);
		}
	}

	public void handleSchedule(MethodCallExpression mce, List<Pair<Expression, String>> cond) {
		List<Expression> args = Helper.buildExprList(mce.getArguments());
		if (args.size() >= 2) {
//			Triplet<String, String, List<Pair<BinaryExpression, String>> > tr = new Triplet<String, String, List<Pair<BinaryExpression, String>> >(mce.getMethodAsString(), args.get(1).getText(), cond);
			Triplet<String, String, List<Pair<Expression, String>> > tr = new Triplet<String, String, List<Pair<Expression, String>> >(mce.getMethodAsString(), args.get(1).getText(), cond);
			intraCallList.add(tr);
		}
	}
	
	/*
	 * attr should be treated as a method node, and an edge should be 
	 * created between this method and the parent method (caller)
	 * A tuple <cap,attr,value> should be created 
	 * I also need to update 
	 */
	private void handleBinaryExpr(String caller, BinaryExpression bex, List<Pair<Expression, String>> elseCondLst){
		String [] specialCap = new String[] {"state", "settings", "location"};
		List<String> listspecialCap = Arrays.asList(specialCap);
		String cap = ""; 
		String attr = ""; 
		String value = "";
		
//		System.out.println("BinExp: "+ bex.getText()+" __ "+bex.getLineNumber() + " __ "+ bex.getLeftExpression().getClass().getSimpleName());
		
		if (bex.getLeftExpression() instanceof PropertyExpression) {
			if (listspecialCap.contains(((PropertyExpression) bex.getLeftExpression()).getObjectExpression().getText())) {
				if (bex.getRightExpression() instanceof ConstantExpression) {
					cap = ((PropertyExpression) bex.getLeftExpression()).getObjectExpression().getText();
					attr = ((PropertyExpression) bex.getLeftExpression()).getPropertyAsString();
					value = bex.getRightExpression().getText();

//					Triplet<String, String, List<Pair<BinaryExpression, String>> > tr = new Triplet<String, String, List<Pair<BinaryExpression, String>> >(caller, attr, elseCondLst);
					Triplet<String, String, List<Pair<Expression, String>> > tr = new Triplet<String, String, List<Pair<Expression, String>> >(caller, attr, elseCondLst);
					intraCallList.add(tr);
					
					Triplet<String, String, String> tr2 = new Triplet<String, String, String>(cap, attr, value);
					specialCapTuple.add(tr2);
				} else if (bex.getRightExpression() instanceof MethodCallExpression && ((PropertyExpression) bex.getLeftExpression()).getPropertyAsString().contains("motionStopTime")) {
					cap = ((PropertyExpression) bex.getLeftExpression()).getObjectExpression().getText();
					attr = ((PropertyExpression) bex.getLeftExpression()).getPropertyAsString();
					value = "not_null";
					
					Triplet<String, String, String> tr2 = new Triplet<String, String, String>(cap, attr, value);
					specialCapTuple.add(tr2);
				} else if (bex.getRightExpression() instanceof BinaryExpression) {
					cap = ((PropertyExpression) bex.getLeftExpression()).getObjectExpression().getText();
					attr = ((PropertyExpression) bex.getLeftExpression()).getPropertyAsString();
					if (attr.equals("wasOn") && bex.getRightExpression() instanceof BinaryExpression) {
						String txt = bex.getRightExpression().getText();
						value = txt.substring(txt.indexOf("==")+2, txt.length()-1);
					}
					Triplet<String, String, String> tr2 = new Triplet<String, String, String>(cap, attr, value);
					specialCapTuple.add(tr2);
				}
			}
		}
	}

	public List<Triplet<String, String, String>> getSpecialCapTuple() {
		return specialCapTuple;
	}

	public List<Triplet<String, String, List<Pair<Expression, String>>>> getIntraCallList() {
		return intraCallList;
	}

	public List<Pair<Expression, String>> getFullPathCondition(String caller, String callee) {
		for (Triplet<String, String, List<Pair<Expression, String>>> icl : intraCallList) {
			if (caller.equals(icl.getValue0()) && callee.equals(icl.getValue1())) {
				return icl.getValue2();
			}
		}
		return null;
	}

	/*
	 * For constructing the call graph:
	 * 	1- Iterate all method handlers, 
	 * 	2- Iterate all intra-calles belong to the method handler (return cgLst)
	 * 	3- Get the method invocation from each method, and check if the method is in the commandAPI list
	 * 	   command API list. A seperate path should be created. Starts by the method handler 
	 */
	void findPathToCmd(HashSet<String> foundCmdAPIs2, Set<String> entryMethods) {
		//Obtain all caller methods from the intraCallList
		HashSet<String> callerMethods = new HashSet<String>();
		HashSet<String> allMethods = new HashSet<String>();
		for (Triplet<String, String, List<Pair<Expression, String>>> icl : intraCallList) {
			callerMethods.add(icl.getValue0());
			allMethods.add(icl.getValue0());
			allMethods.add(icl.getValue1());
		}

		for (String cmd : foundCmdAPIs2) {
			//			System.out.println("Command:: "+ cmd);
			for (String mh : entryMethods) {
				List<String> path = new ArrayList<>();
				path.add(mh);
				findNextNode(mh, path, cmd, callerMethods);
			}
		}
	}

	public void findNextNode(String node, List<String> path, String cmd, HashSet<String> methods) {
		//Add list of callers.
		if (methods.contains(node)) {
			for (Triplet<String, String, List<Pair<Expression, String>>> icl : intraCallList) {
				if (icl.getValue0().equals(node)) {
				}
			}

			for (Triplet<String, String, List<Pair<Expression, String>>> icl : intraCallList) {
				if (icl.getValue0().equals(node)) {
					if (! icl.getValue1().equals(cmd)) {
						path.add(icl.getValue1());
						findNextNode(icl.getValue1(), path, cmd, methods);
					}else {
						path.add(cmd);
						cgLst.add(path);
					}
				}
			}
		} else {
			path.remove(node);
		}
	}

	public HashSet<List<String>> getCgLst() {
		return cgLst;
	}

	void printPathToCmd() {
		System.out.println("\tTotal number of paths to sink= "+ cgLst.size());
		for (List<String> cg : cgLst) {
			for (String p : cg) {
				System.out.print(">>> "+ p);
			}
			System.out.print("\n");
		}
	}

	//This method is adopted from IoTSAN implementation
	private void handleABlock(Statement gStmt, String caller, String iftype, List<Pair<Expression, String>> ifCondLst, List<Pair<Expression, String>> elseCondLst, List<Statement> block){

		if(gStmt instanceof BlockStatement){
			List<Statement> gStmtList = ((BlockStatement) gStmt).getStatements();

			for(int i = 0; i < gStmtList.size(); i++) {
				Statement gSubStmt = gStmtList.get(i);

				if(gSubStmt instanceof ExpressionStatement){
					Expression exp = ((ExpressionStatement) gSubStmt).getExpression();
					if (exp instanceof MethodCallExpression) {
						MethodCallExpression mce = (MethodCallExpression)exp;
						if(mce.getMethodAsString() != null && mce.getMethodAsString().equals("debug")) {
							continue;
						}

						//To address else block that doesn't contain ifstatement
						Triplet<String, String, List<Pair<Expression, String>> > tr;
						if (iftype.equals("else")) 
							tr = new Triplet<String, String, List<Pair<Expression, String>> >(caller, mce.getMethodAsString(), elseCondLst);
						else
							tr = new Triplet<String, String, List<Pair<Expression, String>> >(caller, mce.getMethodAsString(), ifCondLst);

						intraCallList.add(tr);

						if (mce.getMethodAsString() != null)
							if (mce.getMethodAsString().equals("runIn")) {
								handleRunIn(mce, ifCondLst);
							} else if (mce.getMethodAsString().equals("schedule")) {
								handleSchedule(mce, ifCondLst);
							}
					} else if(exp instanceof BinaryExpression) {
						if (iftype.equals("else")) 
							handleBinaryExpr(caller, (BinaryExpression) exp, elseCondLst);
						else 
							handleBinaryExpr(caller, (BinaryExpression) exp, ifCondLst);
					}
				} else if(gSubStmt instanceof IfStatement){
					/* Handle ifBlock and elseBlock of an IfStatement */
					Expression expr = ((IfStatement) gSubStmt).getBooleanExpression().getExpression();
					
					if (iftype.equals("else")) {
						ifCondLst = new ArrayList<>();
						iftype = "elseif";
					} else if (iftype.equals("elseif")) {
						ifCondLst = new ArrayList<>();
					} else {
						elseCondLst = new ArrayList<>();
					}

					if (iftype.equals("NAN")) {
//						Pair<BinaryExpression, String> ifCond = new Pair<BinaryExpression, String>((BinaryExpression) expr, "if");
						Pair<Expression, String> ifCond = new Pair<Expression, String>(expr, "if");
						ifCondLst.add(ifCond);
					} else {
//						Pair<BinaryExpression, String> ifCond = new Pair<BinaryExpression, String>((BinaryExpression) expr, iftype);
						Pair<Expression, String> ifCond = new Pair<Expression, String>(expr, iftype);
						ifCondLst.add(ifCond);
					}

					this.handleABlock(((IfStatement) gSubStmt).getIfBlock(), caller, "if",ifCondLst,elseCondLst, block); 
					boolean t = ((IfStatement) gSubStmt).getElseBlock().getClass().getSimpleName().contains("IfStatement");
					if (t)
						this.handleABlock(((IfStatement) gSubStmt).getElseBlock(), caller, "elseif",ifCondLst,elseCondLst, block);
					else{
						/*
						 * For addressing the case when we have
						 * else {
						 * 	if(){
						 * 	}
						 * } 
						 * probably we need to check elseCondList if it contains any element, and remove the element
						 * also we need to modify the else to be elseif
						 */
//						Pair<BinaryExpression, String> ifCond = new Pair<BinaryExpression, String>((BinaryExpression) expr, iftype);
						Pair<Expression, String> ifCond = new Pair<Expression, String>( expr, iftype);
						elseCondLst.add(ifCond);
						this.handleABlock(((IfStatement) gSubStmt).getElseBlock(), caller, "else",ifCondLst,elseCondLst, block);
					}
				}
				else if(gSubStmt instanceof WhileStatement){
					/* Handle loopBlock of WhileStatement */
					//					this.handleABlock(((WhileStatement) gSubStmt).getLoopBlock());
				}
				else if(gSubStmt instanceof DoWhileStatement){
					/* Handle loopBlock of DoWhileStatement */
					//					this.handleABlock(((DoWhileStatement) gSubStmt).getLoopBlock());
				}
				else if(gSubStmt instanceof ForStatement){
					/* Handle loopBlock of ForStatement */
					//					this.handleABlock(((ForStatement) gSubStmt).getLoopBlock());
				} 
				else if(gSubStmt instanceof ReturnStatement){}
				else if(gSubStmt instanceof BreakStatement){}
				else if(gSubStmt instanceof BlockStatement){
					System.out.println("\tadd block statements");
					int insertPos;
					/* Remove current block statement */
					gStmtList.remove(i);

					/* Add sub-statements of gSubStmt to gStmtList*/
					insertPos = 0;
					for(Statement gSubSubStmt : ((BlockStatement)gSubStmt).getStatements()){
						gStmtList.add(i+insertPos, gSubSubStmt);
						insertPos++;
					}
				} else{
					System.out.println("[GBlockUnroller.handleABlock] unexpected statement type: " + gSubStmt);
				}
			}
		}
		else if(gStmt instanceof IfStatement)
		{
			Expression expr = ((IfStatement) gStmt).getBooleanExpression().getExpression();
			if (iftype.equals("else") || iftype.equals("elseif")) {
				ifCondLst = new ArrayList<>();
			}else {
				elseCondLst = new ArrayList<>();
			}
			if (iftype.equals("NAN")) {
//				Pair<BinaryExpression, String> ifCond = new Pair<BinaryExpression, String>((BinaryExpression) expr, "if");
				Pair<Expression, String> ifCond = new Pair<Expression, String>(expr, "if");
				ifCondLst.add(ifCond);
			} else {
//				Pair<BinaryExpression, String> ifCond = new Pair<BinaryExpression, String>((BinaryExpression) expr, iftype);
				Pair<Expression, String> ifCond = new Pair<Expression, String>(expr, iftype);
				ifCondLst.add(ifCond);
			}
			/* Handle ifBlock and elseBlock of an IfStatement */

			this.handleABlock(((IfStatement) gStmt).getIfBlock(), caller, "if", ifCondLst, elseCondLst, block); 
			boolean t = ((IfStatement) gStmt).getElseBlock().getClass().getSimpleName().contains("IfStatement");
			if (t)
				this.handleABlock(((IfStatement) gStmt).getElseBlock(), caller, "elseif", ifCondLst, elseCondLst, block);
			else {
//				Pair<BinaryExpression, String> ifCond = new Pair<BinaryExpression, String>((BinaryExpression) expr, "else");
				Pair<Expression, String> ifCond = new Pair<Expression, String>(expr, "else");
				elseCondLst.add(ifCond);
				this.handleABlock(((IfStatement) gStmt).getElseBlock(), caller, "else", ifCondLst, elseCondLst, block);
			}
		}
		else if(!(gStmt instanceof EmptyStatement))
		{
			System.out.println("[GBlockUnroller.handleABlock] a wrong call!!!" + gStmt);
		}
	}
}

