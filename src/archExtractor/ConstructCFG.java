package archExtractor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.codehaus.groovy.ast.ClassCodeVisitorSupport;
import org.codehaus.groovy.ast.MethodNode;
import org.codehaus.groovy.ast.expr.BinaryExpression;
import org.codehaus.groovy.ast.expr.Expression;
import org.codehaus.groovy.ast.stmt.BlockStatement;
import org.codehaus.groovy.ast.stmt.IfStatement;
import org.codehaus.groovy.ast.stmt.Statement;
import org.codehaus.groovy.control.SourceUnit;
import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.SingleGraph;
import org.javatuples.Pair;

public class ConstructCFG extends ClassCodeVisitorSupport{
	Map<String, List<BasicBlock> > allBasicBlocks;
	Map<String, SingleGraph> allCFGs;
	List<Pair<String, ArrayList<Integer>>> allpaths;

	public ConstructCFG() {
		allBasicBlocks = new HashMap<>();
		allCFGs = new HashMap<>();
		allpaths = new ArrayList<>();
	}

	@Override
	public void  visitMethod(MethodNode node) {
		String [] unwantedMethods = new String[] {"run","main","unsubscribe", "subscribe", "installed", "updated", "log", "debug", "initialize"};
		List<String> list = (List<String>) Arrays.asList(unwantedMethods);
		if (! list.contains(node.getName())) {
			System.out.println("\n"+node.getName());
			int bbID = 1;
			List<BasicBlock> basicBlocks = new ArrayList<>();
			BinaryExpression predecessor = null;
			handleAblock(node.getName(), node.getCode(), "NAN", bbID, basicBlocks, predecessor);

			allBasicBlocks.put(node.getName(), basicBlocks);
		}
		super.visitMethod(node);
	}

	private void handleAblock(String mthdName, Statement gStmt, String iftype, int bbID, List<BasicBlock> basicBlocks, Expression predecessor) {
		System.out.println("\nBasic Block No.: " + ++bbID + " __ " + iftype + " __ ParentBlk: ");
		BasicBlock bsblk = new BasicBlock();
		bsblk.setId(bbID);
		bsblk.setParent(mthdName);
		bsblk.setIftype(iftype);
		if (predecessor == null) {
			System.out.println("\tNo Pred");
		} else {
			System.out.println("\tPred:"+ predecessor.getText());
		}

		bsblk.setPredecessor(predecessor);

		if(gStmt instanceof BlockStatement) {
			List<Statement> gStmtList = ((BlockStatement) gStmt).getStatements();

			for(int i = 0; i < gStmtList.size(); i++) {
				Statement gSubStmt = gStmtList.get(i);
				//This means a new BB should be created
				if (gSubStmt instanceof IfStatement) {
					bsblk.addStmtList(gSubStmt);
					Expression expr = ((IfStatement) gSubStmt).getBooleanExpression().getExpression();
					predecessor = expr;
					System.out.println("\tIf_St: "+ ((IfStatement) gSubStmt).getBooleanExpression().getExpression().getText() + " __LineNo.: "+ gSubStmt.getLineNumber());
					handleAblock(mthdName, ((IfStatement) gSubStmt).getIfBlock(), "If", bbID, basicBlocks, predecessor);

					boolean t = ((IfStatement) gSubStmt).getElseBlock().getClass().getSimpleName().contains("EmptyStatement");
					if (!t) {
						handleAblock(mthdName, ((IfStatement) gSubStmt).getElseBlock(), "Else", bbID, basicBlocks, predecessor);
					}
				} else {
					bsblk.addStmtList(gSubStmt);
					System.out.println("\tSt: "+ gSubStmt.getText() +" __LineNo.: "+ gSubStmt.getLineNumber());
				}
			}
		} else if (gStmt instanceof IfStatement) {

			bsblk.addStmtList(gStmt);
			Expression expr = ((IfStatement) gStmt).getBooleanExpression().getExpression();
			predecessor =  expr;
			System.out.println("\tIf_St: "+ ((IfStatement) gStmt).getBooleanExpression().getExpression().getText()+" __LineNo.: "+ gStmt.getLineNumber());

			handleAblock(mthdName, ((IfStatement) gStmt).getIfBlock(), "If", bbID, basicBlocks, predecessor);

			boolean t = ((IfStatement) gStmt).getElseBlock().getClass().getSimpleName().contains("EmptyStatement");
			if (!t) {
				handleAblock(mthdName, ((IfStatement) gStmt).getElseBlock(), "Else", bbID, basicBlocks, predecessor);
			}
		} else {
			bsblk.addStmtList(gStmt);
			System.out.println("\tSt: "+ gStmt.getText() +" __LineNo.: "+ gStmt.getLineNumber());
		}
		basicBlocks.add(bsblk);
	}


	public void iterateBasicBlocks() {
		System.out.println("");
		System.out.println("iterateBasicBlocks:: ");
		for (String mh : allBasicBlocks.keySet()) {
			System.out.println("Method: "+ mh);
			for (BasicBlock b : allBasicBlocks.get(mh)) {
				System.out.println("\tBasicBlock: "+ b.getId() + " _ID: "+ b.getNodeID());
				System.out.println("\t\tBranchType: "+ b.getIftype());
				if (b.getPredecessor() == null) {
					System.out.println("\t\tPred: No Pred");
				} else {
					System.out.println("\t\tPred: "+ b.getPredecessor().getText());
				}
				if (b.getStmtList().get(b.getStmtList().size() -1) instanceof IfStatement) {
					System.out.println("\t\tI should creat new branches");
				}

				System.out.println("\t\tStatements: ");
				for (Statement s : b.getStmtList()) {
					if (s instanceof IfStatement) {
						System.out.println("\t\t\tSt: "+ ((IfStatement) s).getBooleanExpression().getExpression().getText());
					} else {
						System.out.println("\t\t\tSt: "+ s.getText());
					}
				}
			}
		}
		System.out.println("");
	}

	/*The main idea used for constructing CFG 
	 * 1) adding entry and exit nodes 
	 * 2) the last statement in each BB should be ifstatement, but this doesn't apply to all cases
	 * like the last BB in the CFG
	 * 
	 */
	public void buildCFG() {
		for (String f : allBasicBlocks.keySet()) {

			SingleGraph cfg = new SingleGraph("CFG_"+f);
			//Create Entry and Exit nodes
			Node entry = cfg.addNode("Entry");
			Node exit = cfg.addNode("Exit");

			int nodeID = 0;
			int edgeID = 0;

			List<Pair<Integer, List<BasicBlock>>> sortedBB = new ArrayList<>();

			//Here I'm sorting BBs based on BB ID, maintaining the sequence is important
			for (BasicBlock b : allBasicBlocks.get(f)) {
				boolean flag = false;
				for (Pair<Integer, List<BasicBlock>> s : sortedBB) {
					if (b.getId() == s.getValue0()) {
						s.getValue1().add(b);
						flag = true;
					}
				}
				if (! flag) {
					List<BasicBlock> lBB = new ArrayList<>();
					lBB.add(b);
					sortedBB.add(new Pair<Integer, List<BasicBlock>>(b.getId(), lBB));
				}
			}

			List<Pair<Integer, List<BasicBlock>>> sortedBBRef = new ArrayList<>();
			int size = 0;
			int t = 2;
			while(size < sortedBB.size()) {
				for (int r = 0; r < sortedBB.size(); r++) {
					if (sortedBB.get(r).getValue0() == t) {
						sortedBBRef.add(sortedBB.get(r));
						t++;
						size++;
					}
				}
			}


			for (Pair<Integer, List<BasicBlock>> m: sortedBBRef) {
				for (BasicBlock b : m.getValue1()) {
					List<BasicBlock> removeBB = new ArrayList<>();
					List<BasicBlock> added = new ArrayList<>();
					int splitFlag = shouldBeSplitted(b);
					if (splitFlag == 1 || splitFlag == 2) {
						removeBB.add(b);
						added = splitBB(b, cfg, nodeID, edgeID, splitFlag);
					}
					for (BasicBlock r : removeBB) {
						allBasicBlocks.get(r.getParent()).remove(r);
					}
					for (BasicBlock r : added) {
						allBasicBlocks.get(r.getParent()).add(r);
					}
				}
			}




			//			for (BasicBlock b : allBasicBlocks.get(f)) {
			//				if (shouldBeSplitted(b)) {
			//					removeBB.add(b);
			//					added = splitBB(b, cfg, nodeID, edgeID);
			//				}
			//			}

			//			for (BasicBlock r : removeBB) {
			//				allBasicBlocks.get(r.getParent()).remove(r);
			//			}
			//			for (BasicBlock r : added) {
			//				allBasicBlocks.get(r.getParent()).add(r);
			//			}

			//iterate all BBs, and check the predecessor for each BB 
			//if the predecessor is null, then:
			//	check the is the nodeID is null, then create a new node, and then add a new edge
			//  from entry to this node. 

			//if the predecessor isn't null, this means this node should be connected to a parent node
			//so we need to check:
			// 1- if the parent node exists, 
			// 2- if the node of the current BB exists
			//			System.out.println("CFG Method: "+ f);

			//+2 because we add entry and exit nodes,
			while (cfg.getNodeCount() != allBasicBlocks.get(f).size()+2) {
				for (BasicBlock b : allBasicBlocks.get(f)) {
					if (b.getPredecessor() == null && ! b.isNodeAdded()) {
						Node n;
						if(b.getNodeID().length() == 0) {
							b.setNodeID("BB_"+nodeID+"_"+b.getId());
							n = cfg.addNode("BB_"+nodeID+"_"+b.getId());
							n.setAttribute("statements", b.getStmtList());
							//							System.out.println("Statement Attribute: "+ b.getNodeID() + " _index: "+  n.getIndex());
							//							for (Statement s :b.getStmtList()) {
							//								System.out.println("\tS: "+ s.getText());
							//							}
							nodeID++;
						} else {
							n = cfg.getNode(b.getNodeID());
						}

						//add edge to entry
						cfg.addEdge(b.getIftype()+"_"+edgeID, entry , n, true);
						edgeID++;

						if (b.getStmtList().size() != 0 && !(b.getStmtList().get(b.getStmtList().size() -1) instanceof IfStatement)) {
							cfg.addEdge(b.getIftype()+"_"+edgeID, n, exit, true);
							edgeID++;
						}
						b.setNodeAdded(true);
					} else if (! b.isSplitted()){
						String predecessor = b.getPredecessor().getText();
						Node n;
						if(b.getNodeID().length() == 0) {
							b.setNodeID("BB_"+nodeID+"_"+b.getId());
							n = cfg.addNode("BB_"+nodeID+"_"+b.getId());
							n.setAttribute("statements", b.getStmtList());
							//							System.out.println("Statement Attribute: "+ b.getNodeID() + " _index: "+  n.getIndex());
							//							for (Statement s :b.getStmtList()) {
							//								System.out.println("\tS: "+ s.getText());
							//							}
							nodeID++;
						} else {
							n = cfg.getNode(b.getNodeID());
						}
						for (BasicBlock parent : allBasicBlocks.get(f)) {
							if (parent.getStmtList().size() != 0) {
								if (parent.getStmtList().get(parent.getStmtList().size() -1) instanceof IfStatement) {
									if (predecessor.equals(((IfStatement) parent.getStmtList().get(parent.getStmtList().size() -1)).getBooleanExpression().getExpression().getText())) {
										Node parentNode;
										if(parent.getNodeID().length() == 0) {
											parent.setNodeID("BB_"+nodeID+"_"+parent.getId());
											parentNode = cfg.addNode("BB_"+nodeID+"_"+parent.getId());
											parentNode.setAttribute("statements", parent.getStmtList());
											//										System.out.println("Statement Attribute: "+ parent.getNodeID() + " _index: "+  parentNode.getIndex());
											//										for (Statement s :parent.getStmtList()) {
											//											System.out.println("\tS: "+ s.getText());
											//										}
											nodeID++;
										} else {
											parentNode = cfg.getNode(parent.getNodeID());
										}
										if (! b.getIftype().equals("NAN")) {
											Edge e = cfg.addEdge(b.getIftype()+"_"+b.getPredecessor().getText()+"_"+edgeID, parentNode , n, true);
											e.setAttribute("cond", new Pair<String, Expression>(b.getIftype(), b.getPredecessor()));
										} else {
											cfg.addEdge(b.getIftype()+"_"+edgeID, parentNode , n, true);
										}
										edgeID++;

										if (b.getStmtList().size() != 0 && !(b.getStmtList().get(b.getStmtList().size() -1) instanceof IfStatement)) {
											if (! n.hasEdgeToward(exit)) {
												//											System.out.println("New edge should be added");
												cfg.addEdge("NAN_"+edgeID, n, exit, true);
												edgeID++;
											}
										}
										b.setNodeAdded(true);
									}
								}							
							}
						}
					}
				}
			}
			for (Edge edge : cfg.getEdgeSet()) {
				edge.addAttribute("ui.label", edge.getId());
			}
			for (Node node : cfg) {
				node.addAttribute("ui.label", node.getId());
				node.addAttribute("ui.style", "text-alignment: under; text-size: 15px;");
			}
			allCFGs.put(f, cfg);
		}
//				for (String g: allCFGs.keySet()) {
//					if (g.equals("WaterPlants"))
//						allCFGs.get(g).display();
//				}
	}


	public Map<String, SingleGraph> getAllCFGs() {
		return allCFGs;
	}

	//this method checks if a BB should be splitted into two BBs. 
	//2 conditions should be verified:
	//a) the 1st statement in the BB is an ifstatement
	//b) the BB contains more than one statement
	//There is another possibility where there are 2 consecitive ifstatements
	private int shouldBeSplitted(BasicBlock b) {
		boolean c1 = b.getStmtList().size() > 2 && (b.getStmtList().get(b.getStmtList().size()-1) instanceof IfStatement) 
				&& (b.getStmtList().get(b.getStmtList().size()-2) instanceof IfStatement);
		boolean c2 = b.getStmtList().size() > 1 && (b.getStmtList().get(0) instanceof IfStatement);
		if (c1) {
			return 1;
		} else if (c2) {
			return 2;
		} else {
			return 0;
		}
		//		if (c2 || c1) {
		//			return true;
		//		}
		//		return false;
	}



	private List<BasicBlock> splitBB(BasicBlock b, SingleGraph cfg, int nodeID, int edgeID, int splitFlag) {
		List<BasicBlock> addedBBs = new ArrayList<>();
		BasicBlock b1 = new BasicBlock();
		BasicBlock b2 = new BasicBlock();
		Random rand = new Random();
		int n = rand.nextInt(50) + 50;

		b1.setId(b.getId());
		b1.setParent(b.getParent());
		b1.setIftype(b.getIftype());
		if (splitFlag == 1) {
			for (int s = 0; s < b.getStmtList().size()-1; s++ ) {
				b1.addStmtList(b.getStmtList().get(s));
			}
		} else if (splitFlag == 2) {
			b1.addStmtList(b.getStmtList().get(0));
		}

		b1.setPredecessor(b.getPredecessor());
		b1.setSplitted(true);
		//		System.out.println("B1 pred: "+ b1.getPredecessor().getText() + "ifType: "+ b1.getIftype());

		addedBBs.add(b1);

		b1.setNodeID("BB_sub_1_"+n+"_"+b1.getId());
		Node nB1 = cfg.addNode("BB_sub_1_"+n+"_"+b1.getId());
		nB1.setAttribute("statements", b1.getStmtList());
		//		System.out.println("Statement Attribute: "+ b1.getNodeID() + " _index: "+  nB1.getIndex());
		//		for (Statement s :b1.getStmtList()) {
		//			System.out.println("\tS: "+ s.getText());
		//		}
		nodeID++;

		String predecessor;
		if (b1.getPredecessor() != null) {
			//			b2.setIftype(b.getIftype());

			if (splitFlag == 1) {
				b2.setIftype(b.getIftype());
			} else if (splitFlag == 2) {
				b2.setIftype("If");
			}

			predecessor = b1.getPredecessor().getText();
			for (BasicBlock parent : allBasicBlocks.get(b.getParent())) {
				if (parent.getStmtList().get(parent.getStmtList().size() -1) instanceof IfStatement) {
					if (predecessor.equals(((IfStatement) parent.getStmtList().get(parent.getStmtList().size() -1)).getBooleanExpression().getExpression().getText())) {
						Node parentNode;
						if(parent.getNodeID().length() == 0) {
							parent.setNodeID("BB_"+ nodeID +"_"+parent.getId());
							parentNode = cfg.addNode("BB_"+ nodeID + "_"+ parent.getId());
							parentNode.setAttribute("statements", parent.getStmtList());
							//						System.out.println("Statement Attribute: "+ parent.getNodeID() + " _index: "+  parentNode.getIndex());
							//						for (Statement s :parent.getStmtList()) {
							//							System.out.println("\tS: "+ s.getText());
							//						}
							nodeID++;
						} else {
							parentNode = cfg.getNode(parent.getNodeID());
						}

						if (! b1.getIftype().equals("NAN")) {
							Edge e = cfg.addEdge(b1.getIftype()+"_"+ predecessor +"_sub_"+edgeID+"_", parentNode , nB1, true);
							e.setAttribute("cond", new Pair<String, Expression>(b1.getIftype(), b1.getPredecessor()));
						} else {
							cfg.addEdge(b.getIftype()+"_sub_"+edgeID, parentNode , nB1, true);
						}

						edgeID++;

						if (!(b1.getStmtList().get(b1.getStmtList().size() -1) instanceof IfStatement)) {
							//							cfg.addEdge(b1.getIftype()+"_sub_"+edgeID, nB1, cfg.getNode("Exit"), true);
							cfg.addEdge("NAN"+"_sub_"+edgeID, nB1, cfg.getNode("Exit"), true);
							edgeID++;
						}
						b1.setNodeAdded(true);
					}
				}							
			}
		}else { 
			predecessor = null;
			cfg.addEdge(b.getIftype()+"_sub_"+edgeID, cfg.getNode("Entry") , nB1, true);
			edgeID++;
			b1.setNodeAdded(true);
			if (splitFlag == 1) {
				b2.setIftype(b.getIftype());
			} else if (splitFlag == 2) {
				b2.setIftype("If");
			}
		}

		b2.setId(b.getId());
		b2.setParent(b.getParent());
		//		b2.setIftype("NAN");
		//		b2.setIftype(b.getIftype());

		if (splitFlag == 1) {
			b2.addStmtList( b.getStmtList().get(b.getStmtList().size()-1));
			b2.setPredecessor((Expression) ((IfStatement) b1.getStmtList().get(b1.getStmtList().size()-1)).getBooleanExpression().getExpression());
		} else if (splitFlag == 2) {
			for (int i = 1; i < b.getStmtList().size(); i++) {
				b2.addStmtList( b.getStmtList().get(i));
			}
			b2.setPredecessor((Expression) ((IfStatement) b.getStmtList().get(0)).getBooleanExpression().getExpression());
		}

		b2.setSplitted(true);

		b2.setNodeID("BB_sub_2_"+n+"_"+b2.getId());
		Node nB2 = cfg.addNode("BB_sub_2_"+n+"_"+b2.getId());
		nB2.setAttribute("statements", b2.getStmtList());

		nodeID++;

		if (!(b2.getStmtList().get(b2.getStmtList().size() -1) instanceof IfStatement)) {
			cfg.addEdge("NAN"+"_sub_"+edgeID, nB2, cfg.getNode("Exit"), true);
			edgeID++;
			b2.setNodeAdded(true);
		}

		addedBBs.add(b2);

		if (! b2.getIftype().equals("NAN")) {
			Edge e = cfg.addEdge(b2.getIftype()+"_sub_"+ edgeID +" _ "+ b2.getPredecessor().getText() , nB1, nB2, true);
			e.setAttribute("cond", new Pair<String, Expression>(b2.getIftype(), b2.getPredecessor()));
		} else {
			cfg.addEdge(b2.getIftype()+"_sub_"+ edgeID , nB1, nB2, true);
		}

		edgeID++;

		return addedBBs;
	}

	public void extractAllPaths() {	

		for (String method : allCFGs.keySet()) {
			SingleGraph cfg = allCFGs.get(method);
			int s = allCFGs.get(method).getNode("Entry").getIndex(); 
			int d = allCFGs.get(method).getNode("Exit").getIndex();
			printAllPaths(s, d, cfg, method, allpaths);
		}
	}

	/*
	public void extractAllPathsV2() {	

		for (String method : allCFGsV2.keySet()) {
			SingleGraph cfg = allCFGsV2.get(method);
			int s = allCFGsV2.get(method).getNode("Entry").getIndex(); 
			int d = allCFGsV2.get(method).getNode("Exit").getIndex();
			printAllPaths(s, d, cfg, method, allpaths);
		}
	}
	 */

	public List<Pair<String, ArrayList<Integer>>> getAllpaths() {
		return allpaths;
	}

	public void printAllPaths(int s, int d, SingleGraph cfg, String method, List<Pair<String, ArrayList<Integer>>> allpaths)  
	{ 
		boolean[] isVisited = new boolean[cfg.getNodeCount()]; 
		ArrayList<Integer> pathList = new ArrayList<>(); 
		//add source to path[] 
		pathList.add(s); 

		//Call recursive utility 
		printAllPathsUtil(s, d, isVisited, pathList, cfg, method, allpaths); 
	} 

	private void printAllPathsUtil(Integer u, Integer d, boolean[] isVisited, ArrayList<Integer> localPathList, SingleGraph cfg, String method, List<Pair<String, ArrayList<Integer>>> allpaths) { 
		// Mark the current node 
		isVisited[u] = true; 

		if (u.equals(d))  
		{ 
			//			System.out.println(localPathList);
			ArrayList<Integer> p = new ArrayList<>(localPathList);
			allpaths.add(new Pair<String, ArrayList<Integer> >(method, p));

			// if match found then no need to traverse more till depth 
			isVisited[u]= false; 
			return ; 
		} 

		// Recur for all the vertices 
		// adjacent to current vertex 
		Collection<Edge> ite = cfg.getNode(u).getLeavingEdgeSet();
		for (Edge e : ite)  
		{ 
			int i = e.getNode1().getIndex();
			if (!isVisited[i]) 
			{ 
				// store current node  
				// in path[] 
				localPathList.add(i); 
				printAllPathsUtil(i, d, isVisited, localPathList, cfg, method, allpaths); 

				// remove current node 
				// in path[] 
				localPathList.remove(localPathList.indexOf(i)); 
			} 
		} 

		// Mark the current node 
		isVisited[u] = false; 
	} 

	@Override
	protected SourceUnit getSourceUnit() {
		// TODO Auto-generated method stub
		return null;
	}

}
