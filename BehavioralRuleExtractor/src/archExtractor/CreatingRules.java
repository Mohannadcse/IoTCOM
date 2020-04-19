package archExtractor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.codehaus.groovy.ast.expr.ArgumentListExpression;
import org.codehaus.groovy.ast.expr.BinaryExpression;
import org.codehaus.groovy.ast.expr.ClosureExpression;
import org.codehaus.groovy.ast.expr.ConstantExpression;
import org.codehaus.groovy.ast.expr.DeclarationExpression;
import org.codehaus.groovy.ast.expr.Expression;
import org.codehaus.groovy.ast.expr.MethodCallExpression;
import org.codehaus.groovy.ast.expr.NotExpression;
import org.codehaus.groovy.ast.expr.PropertyExpression;
import org.codehaus.groovy.ast.expr.VariableExpression;
import org.codehaus.groovy.ast.stmt.BlockStatement;
import org.codehaus.groovy.ast.stmt.ExpressionStatement;
import org.codehaus.groovy.ast.stmt.Statement;
import org.graphstream.graph.implementations.SingleGraph;
import org.javatuples.Pair;
import org.javatuples.Quartet;
import org.javatuples.Triplet;

import util.Helper;

public class CreatingRules {
	private HashSet<Triplet<String, String, String>> subscribeStmts;
	private List<Quartet<String, String, String, String>> deviceCap;
	private List<Triplet<String, String, String>> userCap;
	private Set<String> entryMethods;
	private Set<String> validMethods;
	private ArrayList<Pair<DeclarationExpression, String>> dexpressions;
	private HashMap<List<String>, List<Integer>> numRange;
	private ConstructCFG cfgGenerate;
	private List<Pair<Integer, Triplet<List<String>, List<List<String>>, List<List<String>>>>> rules;
	private Set<Triplet<List<List<String>>, Set<List<String>>, List<List<String>>>> rulesNew;
	int rulesCount;
	private ArrayList<Triplet<String, Set<String>, Set<String>>> capAttrCmdList;
	private List<Triplet<String, String, String>> specialCapLst;
	private Set<String> usedUserInputInPred;
	private String appTouch;
	private Set<String> runInMethods;
	private Set<String> nowValues;
	private boolean containsOR;

	public CreatingRules(Set<String> em, HashSet<String> foundCmdAPIs, HashSet<Triplet<String, String, String>> subSt,
			List<Quartet<String, String, String, String>> dc, List<Triplet<String, String, String>> uc,
			HashMap<List<String>, List<Integer>> range,
			List<Triplet<String, String, List<Pair<Expression, String>>>> intraPaths,
			ArrayList<Pair<DeclarationExpression, String>> decVars, ConstructCFG cfg, Set<String> vd, ArrayList<Triplet<String, Set<String>, Set<String>>> capRefLst, List<Triplet<String, String, String>> sCap) {
		entryMethods = em;
		deviceCap = dc;
		userCap = uc;
		subscribeStmts = subSt;
		dexpressions = decVars;
		validMethods = vd;
		numRange = range;
		cfgGenerate = cfg;
		rulesCount = 1;
		rulesNew = new HashSet<>();
		capAttrCmdList = capRefLst;
		specialCapLst = sCap;
		usedUserInputInPred = new HashSet<>();
		appTouch = "no";
		runInMethods = new HashSet<>();
		nowValues = new HashSet<>();
		containsOR = false;
	}
	
	public boolean containsOR() {
		return containsOR;
	}

	public List<Triplet<String, String, String>> getSpecialCapLst() {
		return specialCapLst;
	}

	public Set<Triplet<List<List<String>>, Set<List<String>>, List<List<String>>>> getRulesNew() {
		return rulesNew;
	}
	
	public String getAppTouch() {
		return appTouch;
	}
	
	public Set<String> getNowValues() {
		return nowValues;
	}

	public void generateRules() {
		cfgGenerate.buildCFG();
		Map<String, SingleGraph> allCFGs = cfgGenerate.getAllCFGs();
		//		cfgGenerate.buildCFGV2();
		//		Map<String, SingleGraph> allCFGs = cfgGenerate.getAllCFGsV2();
		cfgGenerate.extractAllPaths();
		List<Pair<String, ArrayList<Integer>>> allpaths = cfgGenerate.getAllpaths();

		for (String method : entryMethods) {
			System.out.println("Trigger: " + method);
			System.out.println("TriggerTuple: " + getTriggerTuple(method));

			SingleGraph cfg = allCFGs.get(method);
			processCFG(allpaths, method, cfg);
		}
		
		//I need to pass the condition 
		for (String method : runInMethods) {
			System.out.println("Trigger: " + method);
			System.out.println("TriggerTuple: " + getTriggerTuple(method));

			SingleGraph cfg = allCFGs.get(method);
			processCFG(allpaths, method, cfg);
		}
		
		
		System.out.println("\nRulesSummary: " + rulesNew.size());
		int r = 0;
		for (Triplet<List<List<String>>, Set<List<String>>, List<List<String>>> rl : rulesNew) {
			System.out.println("\tRule#: " + r);
			System.out.println("\t\t#Actions: " + rl.getValue2().size());
			System.out.println("\t\t\tActions: " + rl.getValue2());
			System.out.println("\t\t#Cond: " + rl.getValue1().size());
			System.out.println("\t\t\t#Cond: " + rl.getValue1());
			System.out.println("\t\tTrigr: " + rl.getValue0());
			r++;
		}
	}

	private void processCFG(List<Pair<String, ArrayList<Integer>>> allpaths, String method, SingleGraph cfg) {
		for (Pair<String, ArrayList<Integer>> p : allpaths) {
			if (p.getValue0().equals(method)) {
				System.out.println("Rule: " + rulesNew.size());
				System.out.println("\tPaths: " + p.getValue1());
				ArrayList<Integer> path = p.getValue1();
				System.out.print("\tPathNodeIDs: ");
				for (Integer n : path) {
					System.out.print(cfg.getNode(n).getId() + ", ");
				}
				System.out.println("");
				for (int n = 0; n < path.size(); n++) {
					if (path.get(n) == 0 || path.get(n) == 1) {
						continue;
					}
					List<List<String>> actionTuple = new ArrayList<>();
					Set<List<String>> condTuple = new HashSet<>();
					List<List<String>> trigTuple = new ArrayList<>();
					Set<List<String>> condLst = null;
					List<Statement> st = cfg.getNode(path.get(n)).getAttribute("statements");
					int c = 1;
					for (Statement s : st) {
						// System.out.println("\n\t\tmyST: "+ s.getClass().getSimpleName());
						if (s instanceof ExpressionStatement) {
							Expression exp = ((ExpressionStatement) s).getExpression();
							if (exp instanceof MethodCallExpression) {
								MethodCallExpression mce = (MethodCallExpression) exp;
								if (mce.getMethodAsString() != null && (mce.getMethodAsString().equals("debug") || mce.getMethodAsString().equals("trace"))) {
									continue;
								}
								System.out.println("\t\tST+ME: " + s.getText());
								System.out.println("\tCommand: " + c);
								condLst = getCondTuple(cfg, path.get(n), path, method, "");
								List<String> at = handleMethodCallStAction(mce, getTriggerTuple(method),
										condLst, method);
								if (at.size() != 0) {
									actionTuple.add(at);
								}
							} else if (exp instanceof BinaryExpression) {
								// System.out.println("\t\tST+BE: "+ s.getText());
								// Escape defination statements
								if (checkDecl(exp.getText())) {
									continue;
								}
								System.out.println("\t\tST+BE: " + s.getText());
								System.out.println("\tCommand: " + c);
								List<String> at = handleBinaryExpr((BinaryExpression) exp);
								if (at.size() != 0) {
									actionTuple.add(at);
									condLst = getCondTuple(cfg, path.get(n), path, method, "");
								}
							}
							c++;
						}
					}

					for (List<String> t : getTriggerTuple(method)) {
						trigTuple.add(t);
					}

					// If the statement has a valid command, then the predicate should be extracted
					if (!actionTuple.isEmpty() ) {//&& !getTriggerTuple(method).isEmpty()
						for (List<String> cnd : condLst) {
							condTuple.add(cnd);
						}
						
						if (runInMethods.contains(method)) {
							List<String> cnd = new ArrayList<>(); 
						
							cnd.add("state");
							cnd.add("runIn");
							cnd.add("on");
							cnd.add("state");
							condTuple.add(cnd);
						}

						Triplet<List<List<String>>, Set<List<String>>, List<List<String>>> rule = new Triplet<List<List<String>>, Set<List<String>>, List<List<String>>>(
								trigTuple, condTuple, actionTuple);
						rulesNew.add(rule);
					}
				}
			}
		}
	}

	private Set<List<String>> getCondTuple(SingleGraph cfg, int n, List<Integer> path, String method, String caller) {
		Set<List<String>> condTuple = new HashSet<>();

		for (Pair<String, Expression> cond : getNodeCondition(cfg, n, path)) {
			if (cond != null) {
				//				System.out.println("ParseCond:: "+ cond.getValue0()+"__"+cond.getValue1().getText());
				for (List<String> pred : parsePredicateNew(cond.getValue1(), method, cond.getValue0(), caller)) {
					condTuple.add(pred);
				}
			}
		}
		for (List<String> ct : condTuple) {
			System.out.println("sub C: " + ct);
		}

		return condTuple;
	}

	private void processCFGInvokedMethod(List<Pair<String, ArrayList<Integer>>> allpaths, String method,
			SingleGraph cfg, List<List<String>> trig, Set<List<String>> cond, String caller) {
		// go over all statements in the CFG, find the actions,
		// if there are actions, then get trigger and condition, then append the
		// previous trigger and condition
		// and finally add a rule.
		for (Pair<String, ArrayList<Integer>> p : allpaths) {
			if (p.getValue0().equals(method)) {
				System.out.println("Rule: " + rulesNew.size());
				System.out.println("\tPaths: " + p.getValue1());
				ArrayList<Integer> path = p.getValue1();
				System.out.print("\tPathNodeIDs: ");
				for (Integer n : path) {
					System.out.print(cfg.getNode(n).getId() + ", ");
				}
				System.out.println("");
				for (int n = 0; n < path.size(); n++) {
					if (path.get(n) == 0 || path.get(n) == 1) {
						continue;
					}
					List<List<String>> actionTuple = new ArrayList<>();
					Set<List<String>> condTuple = new HashSet<>();
					List<List<String>> trigTuple = new ArrayList<>();

					List<Statement> st = cfg.getNode(path.get(n)).getAttribute("statements");
					int c = 1;
					for (Statement s : st) {
						// System.out.println("\n\t\tmyST: "+ s.getClass().getSimpleName());
						if (s instanceof ExpressionStatement) {
							Expression exp = ((ExpressionStatement) s).getExpression();
							if (exp instanceof MethodCallExpression) {
								MethodCallExpression mce = (MethodCallExpression) exp;
								if (mce.getMethodAsString() != null && mce.getMethodAsString().equals("debug")) {
									continue;
								}
								System.out.println("\t\tST+ME: " + s.getText());
								System.out.println("\tCommand: " + c);
//								List<String> at = handleMethodCallSt(mce, getTriggerTuple(method),
//										getCondTuple(cfg, path.get(n), path, method, caller), caller);
								List<String> at = handleMethodCallStAction(mce, trig,
										getCondTuple(cfg, path.get(n), path, method, caller), caller);
								if (at.size() != 0) {
									actionTuple.add(at);
								}
							} else if (exp instanceof BinaryExpression) {
								// System.out.println("\t\tST+BE: "+ s.getText());
								// Escape defination statements
								if (checkDecl(exp.getText())) {
									continue;
								}
								System.out.println("\tCommand: " + c);
								List<String> at = handleBinaryExpr((BinaryExpression) exp);
								if (at.size() != 0) {
									actionTuple.add(at);
								}
							}
							c++;
						}
					}

					for (List<String> t : trig) {
						trigTuple.add(t);
					}

					for (List<String> t : getTriggerTuple(method)) {
						trigTuple.add(t);
					}

					// If the statement has a valid command, then the predicate should be extracted
					if (!actionTuple.isEmpty() && !trigTuple.isEmpty()) {
						for (List<String> cnd : cond) {
							condTuple.add(cnd);
						}

						for (List<String> cnd : getCondTuple(cfg, path.get(n), path, method, caller)) {
							condTuple.add(cnd);
						}

						Triplet<List<List<String>>, Set<List<String>>, List<List<String>>> rule = new Triplet<List<List<String>>, Set<List<String>>, List<List<String>>>(
								trigTuple, condTuple, actionTuple);
						rulesNew.add(rule);
					}
				}
			}
		}
	}

	private List<String> handleMethodCallStAction(MethodCallExpression exp, List<List<String>> trig, Set<List<String>> cond, String method) {
		List<String> actionTuple = new ArrayList<>();
		String attr, obj, value;
		for (Quartet<String, String, String, String> d : deviceCap) {
			if (d.getValue0().equals(exp.getReceiver().getText())) {
				obj = d.getValue0();
				attr = d.getValue1().split("\\.")[1];
				//in general when the device is multiple, probably it will be used with find, each, we need to avoid such case
				if (d.getValue2().equals("false")) {
					value = exp.getMethodAsString();
				} else {
					value = "no_value";
					MethodCallExpression mce = (MethodCallExpression)exp;
//					System.out.println("Value:: "+ mce.getObjectExpression().getText());
					Expression objExpr = mce.getObjectExpression();
					if(objExpr instanceof VariableExpression) {
						List<Expression> gExprList = Helper.buildExprList(mce.getArguments());
//						System.out.println("args:: "+gExprList.size());
//						Parameter[] parms = ((ClosureExpression) gExprList.get(0)).getParameters();
//						System.out.println("Value:: "+ parms.length);
//						BlockStatement eachBlock = (BlockStatement)((ClosureExpression) gExprList.get(0)).getCode();
//						System.out.println("Value::: "+ eachBlock.getStatements());
						if (gExprList.size() == 0) {
							value = exp.getMethodAsString();
						}
						
					}
				}
				
				

				actionTuple.add(obj);
				actionTuple.add(attr);
				actionTuple.add(value);

				System.out.print("\t\t\tCap: " + obj + "\tAttr: " + attr + "\tValue: " + value);
			}
		}
		System.out.println("");
		//		System.out.println("actionTuple size:: "+ actionTuple.size());

		// If the size of actionTuple is zero, this means it's details can't be be found
		// among device capabilities
		// one of the possibilities is that this method call is invoking another method,
		// this means I need to check
		// the invoked method, and there are two possibilities:
		// 1- the invoked method is defined in the app, which means the CFG of the
		// invoked method needs to be parsed
		// 2- the invoked method is ST API, which means each API should be treated
		// separately. The method can be runIn OR schedule
		if (actionTuple.size() == 0 && exp.getMethodAsString() != null) {
			// Find the CFG
			if (exp.getMethodAsString().equals("runIn") || exp.getMethodAsString().equals("schedule")) {
				// Parse the cfg args.get(1).getText()
				List<Expression> args = Helper.buildExprList(exp.getArguments());
				String targetedMethod;
				if (args.size() >= 2) {
					targetedMethod = args.get(1).getText();
					//I need to set the flag cap_exp.getMethodAsString()_attr_true
//					processCFGInvokedMethod(cfgGenerate.getAllpaths(), targetedMethod,
//							cfgGenerate.getAllCFGs().get(targetedMethod), trig, cond, method);
					obj = "state";
					attr = "runIn";
					value = "on";
					runInMethods.add(targetedMethod);
					
					actionTuple.add(obj);
					actionTuple.add(attr);
					actionTuple.add(value);
					
					specialCapLst.add(new Triplet<String, String, String>(obj, attr, value));
				}
			} else if (validMethods.contains(exp.getMethodAsString())) {
				// Parse the cfg of exp.getMethodAsString()
				System.out.println("Parse the cfg of validMethods");
				System.out.println("Caller: "+ method);
				processCFGInvokedMethod(cfgGenerate.getAllpaths(), exp.getMethodAsString(),
						cfgGenerate.getAllCFGs().get(exp.getMethodAsString()), trig, cond, method);
			} else if (exp.getMethodAsString().equals("setLocationMode")) {
				obj = "location";
				attr = "mode";
				List<Expression> args = Helper.buildExprList(exp.getArguments());
				value = args.get(0).getText();
				

				actionTuple.add(obj);
				actionTuple.add(attr);
				actionTuple.add(value);
			}
		}
		return actionTuple;
	}

	private boolean checkDecl(String dex) {
		for (Pair<DeclarationExpression, String> f : dexpressions) {
			if (f.getValue0().getText().equals(dex)) {
				return true;
			}
		}
		return false;
	}

	private List<Pair<String, Expression>> getNodeCondition(SingleGraph cfg, int node, List<Integer> path) {
		List<Pair<String, Expression>> cond = new ArrayList<>();
		for (int n = 0; n < path.size() - 2; n++) {
			if (path.get(n) == 0 || path.get(n) == 1) {
				continue;
			}
			String e = cfg.getNode(path.get(n)).getEdgeToward(cfg.getNode(path.get(n + 1)).getId()).getId();
			//			Pair<String, BinaryExpression> p = cfg.getEdge(e).getAttribute("cond");
			Pair<String, Expression> p = cfg.getEdge(e).getAttribute("cond");
			if (p == null) {
				System.out.println("\t\t\tCond: " + " No Condition");
			} else {
				System.out.println("\t\t\tCond: " + p.getValue0() + "_" + p.getValue1().getText());
			}
			cond.add(p);
			if (path.get(n+1) == node) {
				break;
			}
		}
		return cond;
	}

	// binary operations: &&, ||, !=, <, >, >=
	// if the condition contains time APIs, then it will be ignored
	private List<List<String>> parsePredicate(BinaryExpression bex, String parentMethod, String predType, String caller) {
//	private Triplet<String, List<List<String>>, List<List<String>>> parsePredicate(BinaryExpression bex, String parentMethod, String predType, String caller) {
		List<List<String>> condTuple = new ArrayList<>();
		
		List<List<String>> leftCondTuple = new ArrayList<>();
		List<List<String>> rightCondTuple = new ArrayList<>();
		String orOp;
		Triplet<String, List<List<String>>, List<List<String>>> condtrip;
		
		Expression leftExpr = bex.getLeftExpression();
		Expression rightExpr = bex.getRightExpression();

		System.out.println("\t\t\tLeft: " + leftExpr.getText() + " Type: " + leftExpr.getClass().getSimpleName());
		System.out.println("\t\t\tRight: " + rightExpr.getText() + " Type: " + rightExpr.getClass().getSimpleName());
		System.out.println("\t\t\tOperation: " + bex.getOperation().getText() +" __pred: " + predType);

		String operation = bex.getOperation().getText();

		// I need to check the operation first
		// if the operation &&, || this means this is a compound predicate
		// in other words, for each sub predicate (left and right), I need to find <cap,
		// attr, value>
		//
//		if (operation.equals("&&") || operation.equals("||")) {
		if (operation.equals("&&") || operation.equals("||")) {
//			condTuple = processAndOperation(leftExpr, rightExpr, parentMethod, predType, caller, bex);
//			leftCondTuple = condTuple;
//			condtrip = new Triplet<String, List<List<String>>, List<List<String>>>("no", leftCondTuple, rightCondTuple);
			if (leftExpr instanceof BinaryExpression) {
				for (List<String> c : parsePredicate((BinaryExpression) leftExpr, parentMethod, predType, caller)) {
					condTuple.add(c);
				}
			}
			if (leftExpr instanceof VariableExpression) {
				condTuple.add(handleVariableExpression(bex, parentMethod, predType, false));
			}
			if (rightExpr instanceof VariableExpression) {
				condTuple.add(handleVariableExpression(bex, parentMethod, predType, true));
			}
			if (rightExpr instanceof BinaryExpression) {
				for (List<String> c : parsePredicate((BinaryExpression) rightExpr, parentMethod, predType, caller)) {
					condTuple.add(c);
				}
			}
			if (rightExpr instanceof NotExpression) {
				System.out.println("NotExpression: " + rightExpr.getText());
				condTuple.add(handleNotExpression(rightExpr, predType));
			}
//		} else if (operation.equals("||")){
//			condtrip = new Triplet<String, List<List<String>>, List<List<String>>>("yes", leftCondTuple, rightCondTuple);
//			processOrOperation(leftExpr, rightExpr);
		} else {
			//this predicate isn't consisting of a set of predicates 
			// Handle expression, usually the leftExpr yields the cap & attrb
			// while the rightExpr provides the value.
//			condTuple = (processSingleCond(leftExpr, rightExpr, parentMethod, predType, caller, operation, bex));
//			leftCondTuple = condTuple;
//			condtrip = new Triplet<String, List<List<String>>, List<List<String>>>("no", leftCondTuple, rightCondTuple);
			if (leftExpr instanceof VariableExpression) {
				condTuple.add(handleVariableExpression(bex, parentMethod, predType, true));
			} else if (leftExpr instanceof ConstantExpression) {
				condTuple.add(handleConstantExpression(bex, predType, parentMethod));
			} else if (leftExpr instanceof PropertyExpression) {
				//								System.out.println("condTuple.add(handlePropertyExpression");
				if (predType.equals("Else")) {
					if (operation.equals("!=")) {
						operation = "==";
					} else if (operation.equals("==")) {
						operation = "!=";
					} else if (operation.equals(">=")) {
						operation = "<";
					} else if (operation.equals("<=")) {
						operation = ">";
					} else if (operation.equals(">")) {
						operation = "<=";
					} else if (operation.equals("<")) {
						operation = ">=";
					}
				}
				condTuple.add(handlePropertyExpression((PropertyExpression) leftExpr, parentMethod, rightExpr,
						operation, predType, caller));
			} else if (leftExpr instanceof NotExpression) {

			} else if (leftExpr instanceof MethodCallExpression) {
				condTuple.add(handleMethodCallExpression(bex, predType));
			} else if (leftExpr instanceof BinaryExpression) {
				System.out.println("Binary Expr LEFT, need to be parsed....");
				System.out.println("\t:: "+ leftExpr.getText());
			}
			
		}
		/*
		 * no additional processing required when the statement is one of the following
		 * types: VariableExpression (i.e. lastStatus), ConstantExpression (i.e. 30, on,
		 * off, active) PropertyExpression (i.e. evt.value, evt.integerValue, )
		 * NotExpression
		 * 
		 * 
		 * but if the statement is one of the following types, then additional
		 * processing is required: MethodCallExpression BinaryExpression
		 * ElvisOperatorExpression
		 */
		//		System.out.println("# of tuples: "+ condTuple.size());
		return condTuple;
	}
	
	private List<List<String>> processAndOperation(Expression leftExpr, Expression rightExpr, String parentMethod, String predType, 
			String caller, BinaryExpression bex) {
		//			System.out.println("Found compound predicate");
		List<List<String>> condTuple = new ArrayList<>();
		if (leftExpr instanceof BinaryExpression) {
			for (List<String> c : parsePredicate((BinaryExpression) leftExpr, parentMethod, predType, caller)) {
				condTuple.add(c);
			}
		}
		if (leftExpr instanceof VariableExpression) {
			condTuple.add(handleVariableExpression(bex, parentMethod, predType, false));
		}
		if (rightExpr instanceof VariableExpression) {
			condTuple.add(handleVariableExpression(bex, parentMethod, predType, true));
		}
		if (rightExpr instanceof BinaryExpression) {
			for (List<String> c : parsePredicate((BinaryExpression) rightExpr, parentMethod, predType, caller)) {
				condTuple.add(c);
			}
		}
		if (rightExpr instanceof NotExpression) {
			System.out.println("NotExpression: " + rightExpr.getText());
			condTuple.add(handleNotExpression(rightExpr, predType));
		}
		return condTuple;
	}
	
	private List<List<String>> processSingleCond(Expression leftExpr, Expression rightExpr, String parentMethod, String predType, 
			String caller, String operation, BinaryExpression bex){
		
		List<List<String>> condTuple = new ArrayList<>();
		if (leftExpr instanceof VariableExpression) {
			condTuple.add(handleVariableExpression(bex, parentMethod, predType, true));
		} else if (leftExpr instanceof ConstantExpression) {
			condTuple.add(handleConstantExpression(bex, predType, parentMethod));
		} else if (leftExpr instanceof PropertyExpression) {
			//								System.out.println("condTuple.add(handlePropertyExpression");
			if (predType.equals("Else")) {
				if (operation.equals("!=")) {
					operation = "==";
				} else if (operation.equals("==")) {
					operation = "!=";
				} else if (operation.equals(">=")) {
					operation = "<";
				} else if (operation.equals("<=")) {
					operation = ">";
				} else if (operation.equals(">")) {
					operation = "<=";
				} else if (operation.equals("<")) {
					operation = ">=";
				}
			}
			condTuple.add(handlePropertyExpression((PropertyExpression) leftExpr, parentMethod, rightExpr,
					operation, predType, caller));
		} else if (leftExpr instanceof NotExpression) {

		} else if (leftExpr instanceof MethodCallExpression) {
			condTuple.add(handleMethodCallExpression(bex, predType));
		} else if (leftExpr instanceof BinaryExpression) {
			System.out.println("Binary Expr LEFT, need to be parsed....");
			System.out.println("\t:: "+ leftExpr.getText());
		}
		return condTuple;
	}
	
	//if there is ||, then a separate rule will be generated for each condition
	//for doing that I need to capture the left side, and right side of the condition
	//then I a dedicated rule should be generated for all conditions in the leftside and another 
	//rule should be generated for the rightside
	//there is a possibility that the left side and/or right side consists of more than one condition
	//therefore, a set should be created for each side
	private void processOrOperation(Expression leftExpr, Expression rightExpr) {
		System.out.println("OR Operation");
		containsOR = true;
	}
	
	private List<String> handleConstantExpression(BinaryExpression bex, String predType, String parentMethod){
		String cap, attr, obj;
		List<String> condTuple = new ArrayList<>();
		Expression leftExpr = bex.getLeftExpression();
		Expression rightExpr = bex.getRightExpression();
		String value = leftExpr.getText();
		
		if (rightExpr instanceof PropertyExpression) {
			for (Quartet<String, String, String, String> d : deviceCap) {
				if (((PropertyExpression) rightExpr).getObjectExpression().getText().equals(d.getValue0())) {
					obj = d.getValue0();
					cap = d.getValue1().split("\\.")[1];
					attr = d.getValue0();
					
					condTuple.add(obj);
					condTuple.add(attr);
					if (predType.equals("If")) {
						condTuple.add(value);
					} else {
						condTuple.add(value+"_Not");
					}
					condTuple.add(cap);
				}
			}
		}

		return condTuple;
	}

	private List<List<String>> parsePredicateNew(Expression exp, String parentMethod, String predType, String caller) {
		List<List<String>> condTuple = new ArrayList<>();
		System.out.println("parsePredicateNew:: "+ exp.getClass().getSimpleName()+ "___"+exp.getText());
		if (exp instanceof BinaryExpression) {
			System.out.println("parsePred in new");
			for (List<String> c : parsePredicate((BinaryExpression) exp, parentMethod, predType, caller)) {
				condTuple.add(c);
			}
		} else if (exp instanceof PropertyExpression) {
			condTuple.add(handlePropertyCond((PropertyExpression) exp, parentMethod, predType, caller));
		} else if (exp instanceof VariableExpression) {
			condTuple.add(handleVariablePred((VariableExpression) exp, parentMethod, predType));
		} else if (exp instanceof MethodCallExpression) {
			condTuple.add(handleMethodCallExpressionCond((MethodCallExpression)exp, parentMethod, predType));
		}
		return condTuple;
	}

	//this method handles predicates that contain only one variable expression
	private List<String> handleVariablePred(VariableExpression exp, String parentMethod, String predType) {
		List<String> condTuple = new ArrayList<>();
		String attr = "", obj, cap, value = "no_value";
		for (Pair<DeclarationExpression, String> f : dexpressions) {
			if (f.getValue0().getLeftExpression().getText().equals(exp.getText())
					&& f.getValue1().equals(parentMethod)) {
				System.out.println("getRightExpression:: "+ f.getValue0().getRightExpression().getClass().getSimpleName());
				if (f.getValue0().getRightExpression() instanceof BinaryExpression) {
					BinaryExpression bex = (BinaryExpression) f.getValue0().getRightExpression();
					for (Quartet<String, String, String, String> d : deviceCap) {
						if (d.getValue0().equals(((MethodCallExpression) bex.getLeftExpression()).getReceiver().getText())) {
							obj = d.getValue0();
							cap = d.getValue1().split("\\.")[1];
							System.out.println("Found Exp::: "+ bex.getLeftExpression().getClass().getSimpleName());
							if (bex.getLeftExpression() instanceof MethodCallExpression) {
								String mh = ((MethodCallExpression) bex.getLeftExpression()).getMethodAsString();
								if (mh.equals("find") || mh.equals("count")) {
									//the value is the string after the sign ==, but the attribute 
									ArgumentListExpression arglistexp = (ArgumentListExpression) ((MethodCallExpression) bex.getLeftExpression()).getArguments();
									BlockStatement eachBlock = (BlockStatement)((ClosureExpression) arglistexp.getExpression(0)).getCode();
									System.out.println("eachBlock.getText():: "+eachBlock.getText());
//									value = eachBlock.getText().substring(eachBlock.getText().indexOf("== ")+3, eachBlock.getText().indexOf(")"));
									value = bex.getRightExpression().getText();
									//To find attribute there are two ways, search in the subscribe list, if nothing found, then
									//I need to check the JSON capability list
									for (Triplet<String, String, String> s : subscribeStmts) {
										if (d.getValue0().equals(s.getValue0()))
											attr = s.getValue1();
									} 
									if (attr.length() == 0) {
										for (Triplet<String, Set<String>, Set<String>> ctc : capAttrCmdList) {
											if (ctc.getValue0().toLowerCase().equals(cap.toLowerCase())) {
												for (Object v : ctc.getValue1()) {
													attr = (String) v;
												}
											}	
										}
									}
								}
							}
							condTuple.add(obj);
							condTuple.add(attr);
							if (predType.equals("If")) {
								condTuple.add(value);
							} else {
								condTuple.add(value+"_Not");
							}
							
							condTuple.add(cap);
						}
					}
				} else if (f.getValue0().getRightExpression() instanceof MethodCallExpression) {
					condTuple = handleMethodCallExpressionCond((MethodCallExpression) f.getValue0().getRightExpression(), parentMethod, predType);
				} else if (f.getValue0().getRightExpression() instanceof ConstantExpression) {
					
				} else if (f.getValue0().getRightExpression() instanceof VariableExpression) {
					condTuple = handleVariablePred((VariableExpression) f.getValue0().getRightExpression(), parentMethod, predType);
				}
			}
		}
		//in case the variable isn't in the local variables, we need to check if the variable is user's input
		if (condTuple.isEmpty()) {
			for (Triplet<String, String, String> u : userCap) {
				if (u.getValue0().equals(exp.getText())) {
					obj = "user";
					cap = "user";
					attr = u.getValue0();
					
					condTuple.add(obj);
					condTuple.add(attr);
					if (predType.equals("If")) {
						condTuple.add(value);
					} else {
						condTuple.add(value+"_Not");
					}
					condTuple.add(cap);
				}
			}
		}
		
		//in case the variable isn't in the user inputs, we need to check if the variable is devices
		if (condTuple.isEmpty()) {
			for (Quartet<String, String, String, String> d : deviceCap) {
				if (d.getValue0().equals(exp.getText())) {
					obj = d.getValue0();
					cap = d.getValue1().split("\\.")[1];
					String att = "notFound";
					for (Triplet<String, String, String> s : subscribeStmts) {
						if (s.getValue0().equals(d.getValue0())) {
							attr = s.getValue1();
						}
					}
					if (att.equals("notFound")) {
						attr = "any";
					}
					value = "no_value";
					condTuple.add(obj);
					condTuple.add(attr);
					if (predType.equals("If")) {
						condTuple.add(value);
					} else {
						condTuple.add(value+"_Not");
					}
					condTuple.add(cap);
				}
			}
		}
		return condTuple;
	}

	private List<String> handlePropertyCond(PropertyExpression exp, String parentMethod, String predType, String caller) {
		List<String> condTuple = new ArrayList<>();
		String[] specialCap = new String[] { "state", "settings", "location" };
		List<String> listspecialCap = Arrays.asList(specialCap);
		String attr, obj, value = "", cap;
		if (listspecialCap.contains(exp.getObjectExpression().getText())) {
			obj = exp.getObjectExpression().getText();// "state";
			cap = exp.getObjectExpression().getText();
			attr = exp.getPropertyAsString();

			if (attr.equals("wasOn")) {
				for (Triplet<String, String, String> c : specialCapLst) {
					if (attr.equals(c.getValue1())) {
						value = c.getValue2();
					}
				}
			} else {
				value = "no_value";
			}

			condTuple.add(obj);
			condTuple.add(attr);
			condTuple.add(value);
			condTuple.add(cap);

		} else if (exp.getObjectExpression().getText().equals("evt")) {
			System.out.println("Activate this part when it's needed");
			/*
			 * for (Triplet<String, String, String> s : subscribeStmts) { if
			 * (s.getValue2().equals(parentMethod)) { attr = s.getValue1(); //find cap for
			 * (Quartet<String, String, String, String> d : deviceCap) { if
			 * (s.getValue0().equals(d.getValue0())) { obj = d.getValue0(); cap =
			 * d.getValue1().split("\\.")[1]; if (rightExpr instanceof ConstantExpression &&
			 * Helper.isNumeric(rightExpr.getText())) { // //this array to compare the
			 * cap/attr pair with the cap/attr pair of each range to find the matching range
			 * List<String> capAttrPr = new ArrayList<>(); capAttrPr.add(obj);
			 * capAttrPr.add(attr); if (identifyRelatedRange(rightExpr,capAttrPr,operation)
			 * != null) value = identifyRelatedRange(rightExpr,capAttrPr,operation); } else
			 * { if (predType.equals("Else")) { value = rightExpr.getText()+"_Not"; } else {
			 * value = rightExpr.getText(); } }
			 * 
			 * System.out.print("\t\tCap: "+ obj + "\tAttr: "+ attr + "\tValue: "+ value);
			 * condTuple.add(obj); condTuple.add(attr); condTuple.add(value);
			 * condTuple.add(cap); } } } }
			 */
		}

		return condTuple;
	}

	private List<String> handleNotExpression(Expression rightExpr, String predType) {
		String obj, attr, value, cap;
		List<String> condTuple = new ArrayList<>();
		
		for (Triplet<String, String, String> s : subscribeStmts) {
			if (s.getValue0().equals(rightExpr.getText())) {
				obj = s.getValue0();
				attr = s.getValue1();
				// find cap
				for (Quartet<String, String, String, String> d : deviceCap) {
					if (s.getValue0().equals(d.getValue0())) {
						cap = d.getValue1().split("\\.")[1];
						// The assumption since not
						value = "no_value";
						System.out.print("\t\tCap: " + obj + "\tAttr: " + attr + "\tValue: " + value);
						condTuple.add(obj);
						condTuple.add(attr);
						condTuple.add(value);
						condTuple.add(cap);
					}
				}
			}
		} 
		//there is a possibility the predicate is 
		if (condTuple.isEmpty()) {
			if (rightExpr.getText().contains("state")) {
				String stAttr = rightExpr.getText().split("\\.")[1];
				for (Triplet<String, String, String> sc : specialCapLst) {
					if (sc.getValue1().equals(stAttr)) {
						if (predType.equals("If")) {
							value = "true";
						} else {
							value = "false";
						}
						
						obj = "state";
						attr = stAttr;
						cap = "state";
						
						condTuple.add(obj);
						condTuple.add(attr);
						condTuple.add(value);
						condTuple.add(cap);
						break;
					}
				}
			}
		}
		System.out.println("");
		return condTuple;
	}

	public List<Pair<Integer, Triplet<List<String>, List<List<String>>, List<List<String>>>>> getRules() {
		return rules;
	}

	private List<String> handleVariableExpression(BinaryExpression bex, String parentMethod, String predType, boolean chkRight) {
		String operation = bex.getOperation().getText();

		if (predType.equals("Else")) {
			if (operation.equals("!=")) {
				operation = "==";
			} else if (operation.equals("==")) {
				operation = "!=";
			} else if (operation.equals(">=")) {
				operation = "<";
			} else if (operation.equals("<=")) {
				operation = ">";
			} else if (operation.equals(">")) {
				operation = "<=";
			} else if (operation.equals("<")) {
				operation = ">=";
			}
		}

		List<String> tuple = new ArrayList<>();
		Expression leftExpr = bex.getLeftExpression();
		Expression rightExpr = bex.getRightExpression();

		for (Pair<DeclarationExpression, String> f : dexpressions) {
			// find the val0 is the dexExp, val1 is the parentMthd
			// check if leftexpr matches the exp.getText(), if yes, then we can specify cap
			if (f.getValue0().getLeftExpression().getText().equals(leftExpr.getText())
					&& f.getValue1().equals(parentMethod)) {
//								System.out.println("DeclarationExpression: "+ f.getValue0().getText() + " __ " + f.getValue1());
//								System.out.println("f.getValue0().getRightExpression(): "+f.getValue0().getRightExpression().getClass().getSimpleName());
				if (f.getValue0().getRightExpression() instanceof PropertyExpression) {
					tuple = handlePropertyExpression((PropertyExpression) f.getValue0().getRightExpression(),
							parentMethod, rightExpr, operation, predType, "");
				} else if (f.getValue0().getRightExpression() instanceof BinaryExpression) {
					if (!f.getValue0().getRightExpression().getText().contains("now()")) {
						tuple = handleBinaryExpr((BinaryExpression) f.getValue0().getRightExpression());
					} else if (f.getValue0().getRightExpression().getText().contains("now()")){
						// the assumption here is that since now() is in the condition and
						// this means
						tuple.add("state");
						if (f.getValue0().getRightExpression().getText().contains("state")) {
							String str = f.getValue0().getRightExpression().getText();
//							tuple.add(str.substring(str.indexOf("state.")+6));//split("\\.")[2]
							String attr = str.substring(str.indexOf("state.")+6);
							while (! attr.matches("[a-zA-Z]+")) {
								attr = attr.substring(0, attr.length() - 1);
							}
							tuple.add(attr);
						} else {
							tuple.add("motionStopTime");
						}
						
						if (!rightExpr.getText().contains("null"))
							tuple.add("not_null");
						else
							tuple.add("null");

						tuple.add("state");
						chkRight = false;
					} 
				} else if (f.getValue0().getText().contains("evt")) {
					String cap,obj, attr, value ="";
					for (Triplet<String, String, String> s : subscribeStmts) {
						if (s.getValue2().equals(parentMethod)) {
							attr = s.getValue1();
							// find cap
							for (Quartet<String, String, String, String> d : deviceCap) {
								if (s.getValue0().equals(d.getValue0())) {
									obj = d.getValue0();
									cap = d.getValue1().split("\\.")[1];
									if (rightExpr instanceof ConstantExpression && Helper.isNumeric(rightExpr.getText())) {
										//										//this array to compare the cap/attr pair with the cap/attr pair of each range to find the matching range
										List<String> capAttrPr = new ArrayList<>();
										capAttrPr.add(obj);
										capAttrPr.add(attr);
										if (identifyRelatedRange(rightExpr, capAttrPr, operation) != null)
											value = identifyRelatedRange(rightExpr, capAttrPr, operation);
									} else {
										System.out.println("Operation:: "+ operation +" __ifType:: "+ predType);
//										if (operation.equals("!=") ) {
//											value = rightExpr.getText() + "_Not";
//										} else {
//											value = rightExpr.getText();
//										}
										value = getValueCond(operation, rightExpr.getText());
									}
									tuple.add(obj);
									tuple.add(attr);
									tuple.add(value);
									tuple.add(cap);
								}
							}
						}
					}
				}
			}

			//Handle rightexpr
			if (chkRight) {
				if (f.getValue0().getLeftExpression().getText().equals(rightExpr.getText())
						&& f.getValue1().equals(parentMethod)) {
					if (f.getValue0().getRightExpression() instanceof BinaryExpression) {
						if (!f.getValue0().getRightExpression().getText().contains("now()")) {
							tuple = handleBinaryExpr((BinaryExpression) f.getValue0().getRightExpression());
						}
					}
				}
			}
		}
		
		if (tuple.isEmpty()) {
			String cap,obj, attr, value ="";
			for (Triplet<String, String, String> sp : specialCapLst) {
				if (sp.getValue2().equals(leftExpr.getText())) {
					obj = sp.getValue0();
					cap = sp.getValue0();
					attr = sp.getValue1();
					
					if (chkRight) {
						if (rightExpr instanceof ConstantExpression) {
							value = rightExpr.getText();
						}
					}
					tuple.add(obj);
					tuple.add(attr);
					tuple.add(value);
					tuple.add(cap);
				}
			}
		}
		
		if (tuple.isEmpty()) {
			String cap,obj, attr, value ="";
			for (Triplet<String, String, String> u : userCap) {
				if (u.getValue0().equals(leftExpr.getText())) {
					obj = "user";
					cap = "user";
					attr = u.getValue0();
					
					if (chkRight) {
						if (rightExpr instanceof ConstantExpression) {
//							if (operation.equals("!=") ) {
//								value = rightExpr.getText() + "_Not";
//							} else {
//								value = rightExpr.getText();
//							}
							value = getValueCond(operation, rightExpr.getText());
						}
					}
					
					tuple.add(obj);
					tuple.add(attr);
					tuple.add(value);
					tuple.add(cap);
					usedUserInputInPred.add(u.getValue0());
				}
			}
		}
		return tuple;
	}

	public Set<String> getUsedUserInputInPred() {
		return usedUserInputInPred;
	}

	// i.e. state.motionStopTime, evt.integerValue
	private List<String> handlePropertyExpression(PropertyExpression exp, String parentMethod, Expression rightExpr,
			String operation, String predType, String caller) {
		String[] specialCap = new String[] { "state", "settings", "location" };
		List<String> listspecialCap = Arrays.asList(specialCap);
		List<String> condTuple = new ArrayList<>();

		String attr, obj, value = "", cap;
		if (exp.getObjectExpression().getText().equals("evt")) {
			// I need to find the method handler that uses this evt, then I can identify the
			// capability, attribute of this exp
			// cap: the value corresponding to the attribute obtained obtained after
			// identifying the methodhandler in the subscribe method
			// attr:
			// value: the right side of the expression
			for (Triplet<String, String, String> s : subscribeStmts) {
				if (s.getValue2().equals(parentMethod) || s.getValue2().equals(caller)) {
					attr = s.getValue1();
					// find cap
					for (Quartet<String, String, String, String> d : deviceCap) {
						if (s.getValue0().equals(d.getValue0())) {
							obj = d.getValue0();
							cap = d.getValue1().split("\\.")[1];
							if (rightExpr instanceof ConstantExpression && Helper.isNumeric(rightExpr.getText())) {
								//								//this array to compare the cap/attr pair with the cap/attr pair of each range to find the matching range
								List<String> capAttrPr = new ArrayList<>();
								capAttrPr.add(obj);
								capAttrPr.add(attr);
								if (identifyRelatedRange(rightExpr, capAttrPr, operation) != null)
									value = identifyRelatedRange(rightExpr, capAttrPr, operation);

								//								} else if (rightExpr instanceof ConstantExpression){
								//									if (operation.equals("!=") ) {
								//										value = rightExpr.getText() + "_Not";
								//									} else {
								//										value = rightExpr.getText();
								//									}
							}else {
								System.out.println("Operation:: "+ operation +" __ifType:: "+ predType);
//								if (operation.equals("!=") ) {
//									value = rightExpr.getText() + "_Not";
//								} else {
//									value = rightExpr.getText();
//								}
								value = getValueCond(operation, rightExpr.getText());
							}

							System.out.print("\t\tCap: " + obj + "\tAttr: " + attr + "\tValue: " + value);
							condTuple.add(obj);
							condTuple.add(attr);
							condTuple.add(value);
							condTuple.add(cap);
						}
					} 

					if (condTuple.isEmpty()) {
						if (rightExpr instanceof ConstantExpression){
//							value = rightExpr.getText();
							value = getValueCond(operation, rightExpr.getText());
						}

						if (listspecialCap.contains(s.getValue0())) {
							obj = s.getValue0();// "state";
							cap = s.getValue0();
							attr = "";
							if (s.getValue0().equals("location"))
								attr = "mode";
//							value = "no_value";
							value = getValueCond(operation, "no_value");

							condTuple.add(obj);
							condTuple.add(attr);
							condTuple.add(value);
							condTuple.add(cap);
						}
					}
				}
			}
		} else if (listspecialCap.contains(exp.getObjectExpression().getText())) {
			obj = exp.getObjectExpression().getText();// "state";
			attr = exp.getPropertyAsString();
//			if (operation.equals("!=")) {
//				value = rightExpr.getText() + "_Not";
//			} else {
//				value = rightExpr.getText();
//			}
			value = getValueCond(operation, rightExpr.getText());
			cap = exp.getObjectExpression().getText();// "state";

			System.out.print("\t\tCap: " + obj + "\tAttr: " + attr + "\tValue: " + value);
			condTuple.add(obj);
			condTuple.add(attr);
			condTuple.add(value);
			condTuple.add(cap);
		} else if (condTuple.isEmpty()) {
			//there is a possibility the variable is in the devCap but doesn't use evt
//			System.out.println("ProPPPP "+ exp.getPropertyAsString());
//			System.out.println("ProPPPP "+ exp.getObjectExpression().getText());
			for (Quartet<String, String, String, String> d : deviceCap) {
				if (d.getValue0().equals(exp.getObjectExpression().getText())) {
					obj = d.getValue0();
					cap = d.getValue1().split("\\.")[1];
					attr = exp.getPropertyAsString();
					
					if (rightExpr instanceof ConstantExpression) {
//						value = rightExpr.getText();
						value = getValueCond(operation, rightExpr.getText());
					}
					condTuple.add(obj);
					condTuple.add(attr);
					condTuple.add(value);
					condTuple.add(cap);
				}
			}
		}
		
		System.out.println("");
		return condTuple;
	}

	

	private List<String> handleBinaryExpr(BinaryExpression bex) {
		List<String> tuple = new ArrayList<>();
		String[] specialCap = new String[] { "state", "settings", "location" };
		List<String> listspecialCap = Arrays.asList(specialCap);
		String obj = "";
		String attr = "";
		String value = "";
		String cap = "";
		if (bex.getLeftExpression() instanceof PropertyExpression) {
			String operation = bex.getOperation().getText();
			if (listspecialCap
					.contains(((PropertyExpression) bex.getLeftExpression()).getObjectExpression().getText())) {

				if (bex.getRightExpression() instanceof ConstantExpression) {
					obj = ((PropertyExpression) bex.getLeftExpression()).getObjectExpression().getText();
					cap = ((PropertyExpression) bex.getLeftExpression()).getObjectExpression().getText();
					attr = ((PropertyExpression) bex.getLeftExpression()).getPropertyAsString();
					if (bex.getRightExpression().getText().equals("null")) {
//						value = "null";
						value = getValueCond(operation, "null");
					} else {
//						if (operation.equals("!=")) {
//							value = bex.getRightExpression().getText() + "_Not";
//						} else {
//							value = bex.getRightExpression().getText();
//						}
						value = getValueCond(operation, bex.getRightExpression().getText());
					}

					System.out.println("\t\t\tCap: " + obj + "\tAttr: " + attr + "\tValue: " + value);
				} else {
					obj = ((PropertyExpression) bex.getLeftExpression()).getObjectExpression().getText();
					cap = ((PropertyExpression) bex.getLeftExpression()).getObjectExpression().getText();
					attr = ((PropertyExpression) bex.getLeftExpression()).getPropertyAsString();
//					value = "not_null";
					value = getValueCond(operation, "not_null");
					System.out.println("\t\t\tCap: " + obj + "\tAttr: " + attr + "\tValue: " + value);
				}
			}
		} else if(bex.getLeftExpression() instanceof MethodCallExpression) {
			for (Quartet<String, String, String, String> d : deviceCap) {
				if (d.getValue0().equals(((MethodCallExpression) bex.getLeftExpression()).getReceiver().getText())) {
					obj = d.getValue0();
					cap = d.getValue1().split("\\.")[1];

					String mh = ((MethodCallExpression) bex.getLeftExpression()).getMethodAsString();
					if (mh.equals("find") || mh.equals("count")) {
						//the value is the string after the sign ==, but the attribute 
						ArgumentListExpression arglistexp = (ArgumentListExpression) ((MethodCallExpression) bex.getLeftExpression()).getArguments();
						BlockStatement eachBlock = (BlockStatement)((ClosureExpression) arglistexp.getExpression(0)).getCode();
						value = eachBlock.getText().substring(eachBlock.getText().indexOf("== ")+3, eachBlock.getText().indexOf(")"));

						//To find attribute there are two ways, search in the subscribe list, if nothing found, then
						//I need to check the JSON capability list
						for (Triplet<String, String, String> s : subscribeStmts) {
							if (d.getValue0().equals(s.getValue0()))
								attr = s.getValue1();
						} 
						if (attr.length() == 0) {
							for (Triplet<String, Set<String>, Set<String>> ctc : capAttrCmdList) {
								if (ctc.getValue0().toLowerCase().equals(cap.toLowerCase())) {
									for (Object v : ctc.getValue1()) {
										attr = (String) v;
									}
								}	
							}
						}
					}
				}
			}
		}
		
		if (obj.length() !=0) {
			tuple.add(obj);
			tuple.add(attr);
			tuple.add(value);
			tuple.add(cap);
		}
		
		return tuple;
	}

	/*
	 * check if the right expression is constant and its value is numeric, then: -
	 * identify the range that belongs to this value by comparing the cap/attr pair
	 * - update the range by adding 0 to the beginning and 100000 to the end -
	 * identify the index of the value in the range array then identify the
	 * operation - the range can be identified based on the operation, - if the
	 * operation >, >= this means the range value should be between the current
	 * index and the next index - if the operation <, <= this means the range value
	 * should be between the current index and the previous index - check the size
	 * of the range (range is a sorted array) -
	 */
	private String identifyRelatedRange(Expression rightExpr, List<String> capAttrPr, String operation) {
		List<Integer> ran = new ArrayList<>();
		for (List<String> ca : numRange.keySet()) {
			if (ca.hashCode() == capAttrPr.hashCode()) {
				for (Integer n : numRange.get(ca)) {
					ran.add(n);
				}
			}
		}
		ran.add(0, -1000000);
		ran.add(1000000);
		int idx = ran.indexOf(Integer.parseInt(rightExpr.getText()));
		if (operation.equals("<") || operation.equals("<=")) {
			//				System.out.println("Range"+ (idx-1));
			return "Range" + (idx - 1);
		} else if (operation.equals(">") || operation.equals(">=")) {
			//				System.out.println("Range"+ (idx+1));
			//				return "Range"+ (idx+1);
			return "Range" + (idx);
		}
		return null;
	}
	
	//Handle predicates that contain only method invocation i.e.setTime.before(now)
	//in this case, the method invocation consists of two parts, the object and the called method
	//there are 3 possibilities for the object, it can be 1) user input 2) local variable 3) device object
	//for the invoked method there are two options: 1) ST method 2) local method
	private List<String> handleMethodCallExpressionCond(MethodCallExpression mce, String parentMethod, String predType){
		List<String> condTuple = new ArrayList<>();
		String attr = "", obj, value, cap;
//		System.out.println("mce.getMethodAsString(): "+ mce.getReceiver().getText());
//		System.out.println("mce.getMethod().getText(): "+ mce.getMethod().getText());
		//the variable is device obj , then the method is the value
		for (Quartet<String, String, String, String> d : deviceCap) {
			if (d.getValue0().equals(mce.getReceiver().getText())) {
				obj = d.getValue0();
				cap = d.getValue1().split("\\.")[1];
				value = mce.getMethod().getText();
				for (Triplet<String, String, String> s : subscribeStmts) {
					if (d.getValue0().equals(s.getValue0()))
						attr = s.getValue1();
				}
				if (attr.length() == 0) {
					for (Triplet<String, Set<String>, Set<String>> ctc : capAttrCmdList) {
						if (ctc.getValue0().toLowerCase().equals(cap.toLowerCase())) {
							for (Object v : ctc.getValue1()) {
								attr = (String) v;
							}
						}	
					}
				}
				String mh = mce.getMethod().getText();
				if (mh.equals("find") || mh.equals("count")) {
					//the value is the string after the sign ==, but the attribute 
					ArgumentListExpression arglistexp = (ArgumentListExpression) (mce).getArguments();
					BlockStatement eachBlock = (BlockStatement)((ClosureExpression) arglistexp.getExpression(0)).getCode();
//					System.out.println("eachBlock.getText():: "+eachBlock.getText());
					if (predType.equals("If")) {
						value = eachBlock.getText().substring(eachBlock.getText().indexOf("== ")+3, eachBlock.getText().indexOf(")"));
					} else {
						value = eachBlock.getText().substring(eachBlock.getText().indexOf("== ")+3, eachBlock.getText().indexOf(")"))+"_Not";
					}
				}
				
				condTuple.add(obj);
				condTuple.add(attr);
				condTuple.add(value);
				condTuple.add(cap);
			}
		}
		
		//this means the variable is either local variable or user input
		String[] locAttr = new String[] { "mode", "position", "sunset", "sunrise" , "sunriseTime" , "sunsetTime" };
		List<String> listLocAttr = Arrays.asList(locAttr);
		if (condTuple.isEmpty()) {
			for (Pair<DeclarationExpression, String> f : dexpressions) {
				if (f.getValue0().getLeftExpression().getText().equals(mce.getReceiver().getText())
						&& f.getValue1().equals(parentMethod)) {
//					System.out.println("Found local variable");
					System.out.println("___"+ f.getValue0().getRightExpression().getClass().getSimpleName());
					if (f.getValue0().getRightExpression() instanceof PropertyExpression) {
						if (listLocAttr.contains(((PropertyExpression) f.getValue0().getRightExpression()).getPropertyAsString())) {
							System.out.println("___"+((PropertyExpression) f.getValue0().getRightExpression()).getPropertyAsString());//getObjectExpression().getText()
							cap = "location";
							obj = "location";
							attr = ((PropertyExpression) f.getValue0().getRightExpression()).getPropertyAsString();
							if (predType.equals("If")) {
								value = "no_value";
							}else {
								value = "no_value_Not";
							}
							
							condTuple.add(obj);
							condTuple.add(attr);
							condTuple.add(value);
							condTuple.add(cap);
						}
					}
				}
			}
		}
		
		if (condTuple.isEmpty()) {
			if (mce.getReceiver().getText().contains("evt") || mce.getReceiver().getText().contains("event")) {
				for (Triplet<String, String, String> s : subscribeStmts) {
					if (s.getValue2().equals(parentMethod)) {
						if (s.getValue1().contains(".")) {
							attr = s.getValue1().split("\\.")[1];
						} else {
							attr = s.getValue1();
						}
						
						// find cap
						for (Quartet<String, String, String, String> d : deviceCap) {
							if (s.getValue0().equals(d.getValue0())) {
								obj = d.getValue0();
								cap = d.getValue1().split("\\.")[1];
								if (predType.equals("If")) {
									value = "no_value";
								} else {
									value = "no_value_Not";
								}
								
								condTuple.add(obj);
								condTuple.add(attr);
								condTuple.add(value);
								condTuple.add(cap);
							}
						}
					}
				}
			}
		}
		return condTuple;
	}

	private List<String> handleMethodCallExpression(BinaryExpression bex, String predType) {
		String operation = bex.getOperation().getText();

		if (predType.equals("Else")) {
			if (operation.equals("!=")) {
				operation = "==";
			} else if (operation.equals("==")) {
				operation = "!=";
			} else if (operation.equals(">=")) {
				operation = "<";
			} else if (operation.equals("<=")) {
				operation = ">";
			} else if (operation.equals(">")) {
				operation = "<=";
			} else if (operation.equals("<")) {
				operation = ">=";
			}
		}

		List<String> condTuple = new ArrayList<>();
		Expression leftExpr = bex.getLeftExpression();
		Expression rightExpr = bex.getRightExpression();
		String attr = null, obj, value = "", cap;
		for (Quartet<String, String, String, String> d : deviceCap) {
			if (d.getValue0().equals(((MethodCallExpression) leftExpr).getReceiver().getText())) {
				obj = d.getValue0();
				cap = d.getValue1().split("\\.")[1];
				for (Triplet<String, String, String> s : subscribeStmts) {
					if (d.getValue0().equals(s.getValue0()))
						attr = s.getValue1();
				}

				if (rightExpr instanceof ConstantExpression && Helper.isNumeric(rightExpr.getText())) {
					//this array to compare the cap/attr pair with the cap/attr pair of each range to find the matching range
					List<String> capAttrPr = new ArrayList<>();
					capAttrPr.add(obj);
					capAttrPr.add(attr);
					if (identifyRelatedRange(rightExpr, capAttrPr, operation) != null)
						value = identifyRelatedRange(rightExpr, capAttrPr, operation);
				} else {
					if (operation.equals("!=")) {
						value = rightExpr.getText() + "_Not";
					} else {
						value = rightExpr.getText();
					}
				}
				System.out.print("\t\t\tCap: " + obj + "\tAttr: " + attr + "\tValue: " + value);
				condTuple.add(obj);
				condTuple.add(attr);
				condTuple.add(value);
				condTuple.add(cap);
			}
		} 
		
		if (condTuple.isEmpty()) {
			if (((MethodCallExpression)leftExpr).getMethodAsString().equals("now")) {
				obj = "now";
				cap = "now";
				attr = "now";
				value = getValueCond(operation, "noValue");
				nowValues.add(value);
			if (rightExpr instanceof PropertyExpression) {
				System.out.println("mmm:: "+((PropertyExpression) rightExpr).getObjectExpression().getClass().getSimpleName());
				System.out.println("mmmP:: "+((PropertyExpression) rightExpr).getProperty().getClass().getSimpleName());
			}
			condTuple.add(obj);
			condTuple.add(attr);
			condTuple.add(value);
			condTuple.add(cap);
			}
		}
		
		System.out.println("");
		return condTuple;
	}
	
	private String getValueCond(String operation, String value) {
		String newValue = null;
		
		if (operation.equals("!=")) {
			newValue = value+"_Not";
		} else if (operation.equals("==")) {
			newValue = value;
		} else if (operation.equals(">=")) {
			newValue = "gte_"+value;
		} else if (operation.equals("<=")) {
			newValue = "lte_"+value;
		} else if (operation.equals(">")) {
			newValue = "gt_"+value;
		} else if (operation.equals("<")) {
			newValue = "lt_"+value;
		} else if (operation.equals("=")) {
			newValue = value;
		} else {
			newValue = value;
		}
		return newValue;
	}

	private List<List<String>> getTriggerTuple(String mh) {
		String obj, attr, value, cap;
		List<List<String>> triggerTupleLst = new ArrayList<>();

		String atr = "";
		for (Triplet<String, String, String> s : subscribeStmts) {
			if (s.getValue2().equals(mh)) {
				atr = s.getValue1();
				break;
			}
		}
		if (atr.equals("app")) {
			obj = "app";
			attr = "app";
			value = "appTouch";
			cap = "app";
			appTouch = "yes";
			List<String> triggerTuple = new ArrayList<>();
			triggerTuple.add(obj);
			triggerTuple.add(attr);
			triggerTuple.add(value);
			triggerTuple.add(cap);
			triggerTupleLst.add(triggerTuple);
			//return triggerTupleLst;
		}

		for (Triplet<String, String, String> s : subscribeStmts) {
			List<String> triggerTuple = new ArrayList<>();
			if (s.getValue2().equals(mh)) {
				if (s.getValue1().contains(".")) {
					String[] split = s.getValue1().split("\\.");
					attr = split[0];
					value = split[1];
				} else {
					attr = s.getValue1();
					value = "no_value";
				}

				String subscVal;
				if (s.getValue0() == null)
					subscVal = s.getValue1();
				else
					subscVal = s.getValue0();

				for (Quartet<String, String, String, String> d : deviceCap) {
					// when the subscribe statement contains 2 arguments, then s.getValue0() will be
					// null
					// to avoid null exception s.getValue1() should be used instead

					if (subscVal.equals(d.getValue0())) {
						obj = d.getValue0();
						cap = d.getValue1().split("\\.")[1];
						triggerTuple.add(obj);
						triggerTuple.add(attr);
						triggerTuple.add(value);
						triggerTuple.add(cap);
						triggerTupleLst.add(triggerTuple);
					}
				}
				if (triggerTuple.isEmpty()) {
					String[] specialCap = new String[] { "state", "settings", "location" };
					List<String> listspecialCap = Arrays.asList(specialCap);

					if (listspecialCap.contains(subscVal)) {
						obj = subscVal;// "state";
						cap = subscVal;
						attr = "";
						if (subscVal.equals("location"))
							attr = "mode";
						value = "no_value";
						triggerTuple.add(obj);
						triggerTuple.add(attr);
						triggerTuple.add(value);
						triggerTuple.add(cap);
						triggerTupleLst.add(triggerTuple);
					}
				}
			}
		}
		return triggerTupleLst;
	}
}
