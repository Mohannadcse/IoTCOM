package archExtractor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Stack;

import org.codehaus.groovy.ast.expr.BinaryExpression;
import org.codehaus.groovy.ast.expr.Expression;
import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.MultiGraph;
import org.javatuples.Pair;
import org.javatuples.Triplet;

public class CallGraph {
	private static ArrayList<Stack<Integer>> paths;
	private MultiGraph cg; 
	private List<String> entryMethods;
//	private List<Triplet<String, String, List<Pair<BinaryExpression, String>>>> intraCallList;
	private List<Triplet<String, String, List<Pair<Expression, String>>>> intraCallList;
	private HashSet<String> cmds;
	private List < Pair< Stack<Integer>, Stack<Integer> > > pathCond; //<Path, AllConditions>

	public List<Pair<Stack<Integer>, Stack<Integer>>> getPathCond() {
		return pathCond;
	}

	public CallGraph(Set<String> entryMethods, HashSet<String> foundCmdAPIs, List<Triplet<String, String, List<Pair<Expression, String>>>> intraPaths) {
		cg  = new MultiGraph("CG");
		entryMethods = entryMethods;
		intraCallList = intraPaths;
		paths = new ArrayList<>();
		cmds = foundCmdAPIs; 
		
		pathCond = new ArrayList<>();
	}

	public MultiGraph constructCG() {
		System.setProperty("org.graphstream.ui.renderer","org.graphstream.ui.j2dviewer.J2DGraphRenderer");
		//get all ICFG calls
		//Add all entry points
		for (String mth : entryMethods) {
			cg.addNode(mth);
		}

		//iterate CFG, start adding edges and non-existing nodes
		int edgeCount = 1;
//		for (Triplet<String, String, List<Pair<BinaryExpression, String>>> i : intraCallList) {
		for (Triplet<String, String, List<Pair<Expression, String>>> i : intraCallList) {
			//ignore debug/log/installed/updated/unsubscribe/subscribe nodes
			String [] unwantedMethods = new String[] {"unsubscribe", "subscribe", "installed", "updated", "log", "debug"};
			List<String> list = (List<String>) Arrays.asList(unwantedMethods);
			if (! list.contains(i.getValue0())) {
				if (cg.getNode(i.getValue0()) == null) {
					cg.addNode(i.getValue0());
				} 
				if (cg.getNode(i.getValue1()) == null) {
					cg.addNode(i.getValue1());
				}
				cg.addEdge(""+ edgeCount, i.getValue1(), i.getValue0(),true);
				cg.getEdge(""+ edgeCount).addAttribute("cond", i.getValue2());
				edgeCount++;
			}
		}

		for (Edge edge : cg.getEdgeSet()) {
			edge.addAttribute("ui.label", edge.getId());
		}

		for (Node node : cg) {
			node.addAttribute("ui.label", node.getId());
			node.addAttribute("ui.style", "text-alignment: under; text-size: 15px;");
			if (cmds.contains(node.getId())) {
				node.addAttribute("ui.style", "text-alignment: under; text-size: 15px;fill-color: rgb(0,100,255);");
			}
		}
		return cg;
	}

	////////////////////////////
	public void dfs(Integer source, Integer destination, MultiGraph g) {
		Stack<Integer> nodesStack = new Stack<>();
		Stack<Integer> edgesStack = new Stack<>();
		boolean visitedNodes[] = new boolean [g.getNodeCount()];
		boolean visitedEdges[] = new boolean [g.getEdgeCount()];

		for (int i= 0; i < visitedNodes.length; i++) {
			visitedNodes[i] = false;
		}

		for (int i= 0; i < visitedEdges.length; i++) {
			visitedEdges[i] = false;
		}

		dfsUtil(source, destination, g, nodesStack, edgesStack, visitedNodes, visitedEdges);
	}

	public void dfsUtil(Integer s, int destination, MultiGraph g, Stack<Integer> nodesStack, Stack<Integer> edgesStack, boolean[] visitedNodes, boolean[] visitedEdges) {
		nodesStack.push(s);
		visitedNodes[s] = true;

		if (s == destination) {		
			Stack<Integer> st = new Stack<>();
			Stack<Integer> ed = new Stack<>();
//			for (Integer i : nodesStack) {
//				System.out.print(g.getNode(i).getId()+ " >>> ");
//			}
//			System.out.println("");
			st = (Stack<Integer>) nodesStack.clone();
			ed = (Stack<Integer>) edgesStack.clone();
			
//			addPath(st);
			//			paths.add(stack);
			//			stack.pop();
			Pair< Stack<Integer>, Stack<Integer> > pc = new Pair<Stack<Integer>, Stack<Integer>>(st, ed);
			pathCond.add(pc);
		}

		Collection<Edge> ite = g.getNode(s).getLeavingEdgeSet();
		for (Edge e : ite) {
			int n = e.getNode1().getIndex();

			if (checkAllEdgesVisited(n, g, visitedEdges) && ! nodesStack.contains(n)) {
				Collection<Edge> it = g.getNode(n).getLeavingEdgeSet();
				for (Edge ed : it) {
					visitedEdges[ed.getIndex()] = false;
				}
			}

			if (! visitedEdges[e.getIndex()]) {
				visitedEdges[e.getIndex()] = true;
				edgesStack.push(e.getIndex());
				dfsUtil(n, destination, g, nodesStack, edgesStack, visitedNodes, visitedEdges);
				if (checkAllEdgesVisited(n, g, visitedEdges) || g.getNode(n).getLeavingEdgeSet().isEmpty()) {
					nodesStack.pop();
					edgesStack.pop();
				} 
			}
		}
	}

	ArrayList<ArrayList<Integer>> reversePaths() {
		ArrayList<ArrayList<Integer> > correctPaths = new ArrayList<>();
		for (Stack<Integer> s : paths) {
			ArrayList<Integer> path = new ArrayList<>();
			while (! s.isEmpty()) {
				path.add(s.pop());
			}
			correctPaths.add(path);
		}
		return correctPaths;
	}

	private boolean checkAllEdgesVisited(Integer s, MultiGraph g, boolean[] visitedEdges) {
		ArrayList<String> nodeEdges = new ArrayList<>();
		Collection<Edge> ite = g.getNode(s).getLeavingEdgeSet();
		for (Edge e : ite) {
			nodeEdges.add("" + visitedEdges[e.getIndex()]);
		}
		if (nodeEdges.contains("false"))
			return false;
		else 
			return true;
	}
}
