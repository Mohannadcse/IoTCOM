package archExtractor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.codehaus.groovy.ast.ClassCodeVisitorSupport;
import org.codehaus.groovy.ast.MethodNode;
import org.codehaus.groovy.ast.expr.BinaryExpression;
import org.codehaus.groovy.ast.expr.Expression;
import org.codehaus.groovy.ast.expr.MethodCallExpression;
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
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.SingleGraph;
import org.javatuples.Pair;
import org.javatuples.Triplet;

public class ConstructCFG_OLD extends ClassCodeVisitorSupport{
	HashMap<String, List <List <Statement> >> BBLst;
	HashMap<String, List< Triplet< List <Statement>, BinaryExpression, String> > > BBs;
	List <BasicBlock>  bskBlks;
	public ConstructCFG_OLD() {
		BBLst = new LinkedHashMap<>();
		BBs = new LinkedHashMap<>();
		bskBlks = new ArrayList<>();
	}

	@Override
	protected SourceUnit getSourceUnit() {
		// TODO Auto-generated method stub
		return null;
	}

	//Visit all methods
	@Override
	public void  visitMethod(MethodNode node){
		System.out.println(node.getName());
		String [] unwantedMethods = new String[] {"run","main","unsubscribe", "subscribe", "installed", "updated", "log", "debug"};
		List<String> list = (List<String>) Arrays.asList(unwantedMethods);
		if (! list.contains(node.getName())) {
			List<Pair<BinaryExpression, String> > ifCondLst = new ArrayList<>();
			List<Pair<BinaryExpression, String>> elseCondLst = new ArrayList<>();
			List<List <Statement> >  blocks = new ArrayList<>();

			BinaryExpression cond = null;

			List< Triplet< List <Statement>, BinaryExpression, String > > blks = new ArrayList<>();
			int bbID = 0;
			boolean nested = false;

			handleABlock(node.getName(), node.getCode(), "NAN", cond, blks, bbID, nested);
			//			BBLst.put(node.getName(), blocks);
			BBs.put(node.getName(), blks);
		}
		super.visitMethod(node);
	}



	private void handleABlock(String mthdName, Statement gStmt, String iftype, BinaryExpression cond, List<Triplet<List<Statement>, BinaryExpression, String>> blks, int bbID, boolean nested){
		//iterate all statements
		//if add the statement to the BB list if it is a methodCallExp 
		//		List <Statement> block = new ArrayList<>();
		BasicBlock bsblk = new BasicBlock();
		//		bsblk.setPredecessor(cond);
		//		bsblk.setParent(mthdName);
		//		bsblk.setIftype(iftype);
		bsblk.setId(bbID++);
		//		bsblk.setNested(nested);
		//		if (cond == null) {
		//			bsblk.setFirst(true);
		//		}

		if(gStmt instanceof BlockStatement) {

			bsblk.setPredecessor(cond);
			bsblk.setParent(mthdName);
			bsblk.setIftype(iftype);
			bsblk.setNested(nested);
			if (cond == null) {
				bsblk.setFirst(true);
			}


			List<Statement> gStmtList = ((BlockStatement) gStmt).getStatements();

			for(int i = 0; i < gStmtList.size(); i++) {
				Statement gSubStmt = gStmtList.get(i);

				if(gSubStmt instanceof ExpressionStatement){
					Expression exp = ((ExpressionStatement) gSubStmt).getExpression();
					if (exp instanceof MethodCallExpression) {	
						MethodCallExpression mce = (MethodCallExpression)exp;
						bsblk.addStmtList(gSubStmt);
						System.out.println("ifType: "+ iftype);
						System.out.println("nested: "+ nested);
						System.out.println("\tSt: "+ exp.getText());
					} 
					else if (exp instanceof BinaryExpression) {						
						bsblk.addStmtList(gSubStmt);
						System.out.println("ifType: "+ iftype);
						System.out.println("nested: "+ nested);
						System.out.println("\tSt: "+ exp.getText());
					}
					bsblk.setSuccessors(null);
				} 
				else if(gSubStmt instanceof IfStatement){
					if (iftype.equals("else")) {
						iftype = "elseif";
					} 
					bsblk.setIftype(iftype);

					Expression expr = ((IfStatement) gSubStmt).getBooleanExpression().getExpression();

					cond = (BinaryExpression) expr;
					bsblk.setSuccessors(cond);

					boolean n = ((IfStatement) gSubStmt).getIfBlock().getClass().getSimpleName().contains("IfStatement");
					if (n) {
						nested = true;
					}
					this.handleABlock(mthdName,((IfStatement) gSubStmt).getIfBlock(), "if", cond,blks, bbID, nested);



					boolean t = ((IfStatement) gSubStmt).getElseBlock().getClass().getSimpleName().contains("IfStatement");

					if (t) {
						nested = true;
						this.handleABlock(mthdName,((IfStatement) gSubStmt).getElseBlock(), "elseif", cond, blks, bbID, nested);
					} else {
						cond = (BinaryExpression) expr;
						this.handleABlock(mthdName,((IfStatement) gSubStmt).getElseBlock(), "else", cond, blks, bbID, nested);
					}
				}
			}
			bskBlks.add(bsblk);
		} 
		else if(gStmt instanceof IfStatement) {
			bsblk.setIftype(iftype);

			Expression expr = ((IfStatement) gStmt).getBooleanExpression().getExpression();			
			cond = (BinaryExpression) expr;
			bsblk.setSuccessors(cond);

			boolean n = ((IfStatement) gStmt).getIfBlock().getClass().getSimpleName().contains("IfStatement");
			if (n) {
				nested = true;
			}
			this.handleABlock(mthdName, ((IfStatement) gStmt).getIfBlock(), iftype, cond, blks, bbID, nested);

			//			bsblk.setSuccessors(cond);
			boolean t = ((IfStatement) gStmt).getElseBlock().getClass().getSimpleName().contains("IfStatement");
			if (t) {
				nested = true;
				handleABlock(mthdName, ((IfStatement) gStmt).getElseBlock(), "elseif", cond, blks, bbID, nested);
			}else {
				cond = (BinaryExpression) expr;
				handleABlock(mthdName, ((IfStatement) gStmt).getElseBlock(), "else", cond, blks, bbID, nested);
			}

		}
	}

	public void iterMap() {
		System.out.println("");
		for ( String f : BBLst.keySet()) {
			System.out.println("Method: "+ f);
			System.out.println("Num BBs: " + BBLst.get(f).size());
			for (List<Statement> bb : BBLst.get(f)) {
				System.out.println("\tBasic Block");
				for (Statement b : bb) {
					System.out.println("\t\tSt: "+ b.getText() + " __ " + b.getLastLineNumber());
				}
			}
			System.out.println("");
		}
	}

	public void iterMapPair() {
		System.out.println("");
		for ( String f : BBs.keySet()) {
			System.out.println("Method: "+ f);
			System.out.println("Num BBs: " + BBs.get(f).size());

			for (Triplet< List <Statement>, BinaryExpression, String>  bb : BBs.get(f)) {
				System.out.println("\tBasic Block");
				System.out.println("\tBasic Block Cond: "+ bb.getValue1().getText());
				System.out.println("\tBasic Block Cond Type: " + bb.getValue2());
				for (Statement b : bb.getValue0()) {
					System.out.println("\t\tSt: "+ b.getText() + " __ " + b.getLastLineNumber());
				}
			}
			System.out.println("");
		}
	}

	public void iterBB() {
		System.out.println();
		System.out.println();
		for ( String f : BBs.keySet()) {
			System.out.println("Method: "+ f);
			for (BasicBlock b : bskBlks) {
				if (b.getParent().equals(f)){

					System.out.println("\tBasic Block: " + b.getId());
					if (b.getPredecessor() == null) {
						System.out.println("\tNo Predecessor");
					} else {
						System.out.println("\tBasic Block pred: "+ b.getPredecessor().getText() + " __ ifType: "+ b.getIftype()+ " __ Nested: "+ b.isNested());
					}
					if (b.getSuccessors() != null) {
						System.out.println("\tBasic Block succ: "+ b.getSuccessors().getText());
					} else {
						System.out.println("\tNo Successors");
					}

					for (Statement s : b.getStmtList()) {
						System.out.println("\t\tSt: " + s.getText());
					}
				}
			}
		}
	}

	/*
	public void generateCFG() {
		for (String f : BBs.keySet()) {
			SingleGraph cfg = new SingleGraph("CFG_"+f);
			Node entry = cfg.addNode("Entry");
			Node exit = cfg.addNode("Exit");
			List <BasicBlock> mthdBB = new ArrayList<>();
			for (BasicBlock b : bskBlks) {
				mthdBB.add(b);
			}
			BinaryExpression next = null;

			for (int t = 0; t < mthdBB.size(); t++) {
			if (mthdBB.get(t).getParent().equals(f)){
				if (mthdBB.get(t).getPredecessor() == null) {
					Node first = cfg.addNode(""+ mthdBB.get(t).getId());
					cfg.addEdge("Entry", entry, first, true);
					next = mthdBB.get(t).getSuccessors();
					if (next == null) {
						cfg.addEdge("e"+mthdBB.get(t).getId(), first, exit, true);
						return;
					}
					mthdBB.remove(t);

					int i = 0;
					while (! mthdBB.isEmpty()){
						if (next != null) {
							if (mthdBB.get(i).getSuccessors().getText().equals(next.getText())){
								Node n = cfg.addNode(""+ mthdBB.get(i).getId());
								next = mthdBB.get(t).getSuccessors();
								if (next == null) {
									cfg.addEdge("e"+mthdBB.get(i).getId(), first, exit, true);
									return;
								}
							}
						}else {

						}
						i++;
					}
				}
			}
			}


		}
	}
	 */

	public void createCFG() {
		for (String f : BBs.keySet()) {
			SingleGraph cfg = new SingleGraph("CFG_"+f);
			Node entry = cfg.addNode("Entry");
			Node exit = cfg.addNode("Exit");
			List <BasicBlock> mthdBB = new ArrayList<>();
			for (BasicBlock b : bskBlks) {
				mthdBB.add(b);
			}
			
			BinaryExpression next = null;
			
			//Add 1st BB
			Node first;
			for (int t = 0; t < mthdBB.size(); t++) {
				if (mthdBB.get(t).getId() == 0) {
					first = cfg.addNode("" + t);
					cfg.addEdge("NAN", entry, first);
					mthdBB.remove(t);
				}
			}
			
			int currentBB = 1;
			for (BasicBlock b : mthdBB) {
				if (b.getId() == currentBB) {
					
				}
				currentBB++;
			}
		}
	}

}
