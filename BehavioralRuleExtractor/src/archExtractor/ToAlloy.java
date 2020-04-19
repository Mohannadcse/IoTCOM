package archExtractor;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.codehaus.groovy.ast.ClassNode;
import org.codehaus.groovy.ast.MethodNode;
import org.codehaus.groovy.ast.expr.Expression;
import org.codehaus.groovy.classgen.GeneratorContext;
import org.codehaus.groovy.control.CompilationFailedException;
import org.codehaus.groovy.control.CompilePhase;
import org.codehaus.groovy.control.CompilerConfiguration;
import org.codehaus.groovy.control.SourceUnit;
import org.codehaus.groovy.control.customizers.CompilationCustomizer;
import org.javatuples.Pair;
import org.javatuples.Quartet;
import org.javatuples.Triplet;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.Version;
import groovy.lang.GroovyShell;
import groovy.lang.MissingMethodException;

public class ToAlloy extends CompilationCustomizer {
	private static List<String> allCommandsList;
	private static List<String> allPropsList;
	private static ArrayList<Triplet<String, Set<String>, Set<String>>> capAttrCmdList; // <capability, attribute,
	// command>
	private static Configuration confg;
	private static String appName;
	private static List<Triplet<String, String, String>> objToCmdToCap;
	static List<String> appsContainEnum;
	private static Set<String> inputTypes;
	private static Set<String> containOR;
	private String project_root;
	static PrintWriter rulesWriter ;
	/**
	 * @throws FileNotFoundException *********************************************/

	public ToAlloy() throws FileNotFoundException {
		super(CompilePhase.SEMANTIC_ANALYSIS);
		new HashMap<>();
		new HashMap<>();
		allCommandsList = new ArrayList<String>();
		new ArrayList<String>();
		allPropsList = new ArrayList<String>();
		capAttrCmdList = new ArrayList<>();
		appName = "";
		objToCmdToCap = new ArrayList<>();
		appsContainEnum = new ArrayList<>();
		inputTypes = new HashSet<>();
		containOR = new HashSet<>();
		project_root = System.getProperty("user.dir");
		rulesWriter = new PrintWriter(new File("rulePerApp.csv"));
	}

	public static void main(String[] args) throws IOException, ParseException {
		// String project_root = "/Users/think/eclipse-workspace/IoTCheck/";
		// String allCapsFile = project_root + "/" + "capfull.csv";
		// File allCapsAll = new File(allCapsFile);
		ToAlloy ta = new ToAlloy();
		ParseIFTTT p = new ParseIFTTT();
		System.out.println("Parse ST Capability Reference JSON file...");
		String project_root = System.getProperty("user.dir");
		System.out.println("project_root:: "+project_root);
		parseCapabilityRefJson(project_root);
//		p.generateIFTTT_Rules();
		// loadCapRefAll(allCapsAll, project_root);
		
		System.out.println("\nAnalyzing Apps...");
		final long start = System.nanoTime();
		loadIoTApp(ta, project_root);
		final long end = System.nanoTime();
		System.out.println("Took: " + ((end - start) / 1000000.0) + "ms");
		System.out.println("Took: " + (end - start)/ 1000000000.0 + " seconds");
		
		
		/*
		System.out.println("\nParsing IFTTT Applets...");
		final long startIFTTT = System.nanoTime();
		loadIFTTT(p, project_root);
		final long endIFTTT = System.nanoTime();
		System.out.println("Took: " + ((endIFTTT - startIFTTT) / 1000000.0) + "ms");
		System.out.println("Took: " + ((endIFTTT - startIFTTT)/ 1000000000.0) + " seconds");
		*/
	
	}
	
	public static void loadIFTTT(ParseIFTTT pi, String project_root) {
		String outDirIFTTT = project_root + "/IFTTT_App_Instances";
		try {
			System.out.println("Create App Template...");
			confg = getConfigurationInstance(project_root + "/Input/templates");
			generateAppTemplateIFTTT(pi.generateIFTTT_Rules(), outDirIFTTT);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TemplateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void loadIoTApp(ToAlloy ta, String project_root) throws IOException {
		// String allCapsFile = project_root + "/" + "capfull.csv";
		String manualAnalysesReflection = project_root + "/" + "skip_apps_reflection_falsepos.txt";

		File iotApp;
		// File allCapsAll = new File(allCapsFile);

		String smartAppPath = project_root + "/Input/analyzedAndnotAnalyzed/";
		String motvApps = project_root + "/Input/MtvCode/"; //"/Input/dataset/Soteria/Bench/";
		String benchApps = project_root + "/Input/dataset/Soteria/";
		
		String newBenchApps = "/Users/think/eclipse-workspace/IoTSan/input/intersectionApps/25";
				//"/Users/think/Downloads/SmartThings/IoTAlloy/incremental-iot/MaliciousInteractionsIoTApps/GroupOfApps/G1";

		File smartAppFoler = new File(newBenchApps);

		List<String> reflectionSkip = new ArrayList<String>();

		BufferedReader br = new BufferedReader(new FileReader(manualAnalysesReflection));
		String line;
		while ((line = br.readLine()) != null) {
			reflectionSkip.add(line + ".txt");
		}

		List<String> fullList = new ArrayList<String>();
		for (File file : smartAppFoler.listFiles()) {
			if (file.isFile() && file.getName().endsWith(".groovy")) {
				String[] arrStr = file.getName().split("/");
				fullList.add(arrStr[arrStr.length - 1]);
			}
		}

		CompilerConfiguration CC = new CompilerConfiguration(CompilerConfiguration.DEFAULT);
		CC.addCompilationCustomizers(ta);
		GroovyShell gShell;
		gShell = new GroovyShell(CC);
		int appNo = 0;

//		appName = "TimeDependentDoors.txt.groovy";
		
		//iotApp = new File(project_root + "temp/" + appName);
		PrintWriter writer = new PrintWriter(new File("AnalysisTime_ST.csv"));
				
		for (String f : fullList) {
			appName = f;
			System.out.println("\n\n" + ++appNo + "__" + f);
			if (!reflectionSkip.contains(fullList)) {
				iotApp = new File(newBenchApps + "/" + f);
				final long start = System.nanoTime();
				try {
					gShell.evaluate(iotApp);
				      
				} catch (MissingMethodException mme) {
					String missingMethod = mme.toString();
					if (!missingMethod.contains("definition()") && !missingMethod.contains("main()")) {
						System.out.println(missingMethod);
					}
				}
				final long end = System.nanoTime();
				String s = String.format("%s,%.2f,%.2f", appName, ((end - start) / 1000000.0), ((end - start) / 1000000000.0));
				StringBuilder sb = new StringBuilder();
			    sb.append(s+"\n");
			    writer.write(sb.toString());
			}
		}
		writer.close();
		rulesWriter.close();
	}

	public static void parseCapabilityRefJson(String project_root) throws FileNotFoundException, IOException, ParseException {
		// String[] httpSinks =
		// {"httpDelete","httpGet","httpHead","httpPost","httpPostJson","httpPut","httpPutJson"};
		// String[] notificationSinks =
		// {"sendLocationEvent","sendNotification","sendNotificationEvent","sendNotificationContacts","sendPushMessage","sendSMS","sendSMSMessage","sendPush"};
		String[] changeSettingSinks = new String[] { "setLocationMode" }; // subscribeToCommand()
		JSONParser parser = new JSONParser();

		Object obj = parser.parse(new FileReader(project_root+"/Input/capabilities.json"));

		JSONArray jArray = (JSONArray) obj;

		for (String s : changeSettingSinks) {
			allCommandsList.add(s.toLowerCase());
		}
		
		for (Object capObj : jArray.toArray()) {
			String capability = ((JSONObject) capObj).get("name").toString().replaceAll("\\s+", "");
			Set attr = ((HashMap) ((JSONObject) capObj).get("attributes")).keySet();
			Set cmds = ((HashMap) ((JSONObject) capObj).get("commands")).keySet();
			Triplet<String, Set<String>, Set<String>> capAttrCmd = new Triplet<String, Set<String>, Set<String>>(
					capability, attr, cmds);

			capAttrCmdList.add(capAttrCmd);
			// Get all attributes
			for (Object a : attr) {
				allPropsList.add((String) a);
			}
			// Get all Commands
			for (Object c : cmds) {
				allCommandsList.add((String) c);
			}
		}
		System.out.println("\tTotal Capabilities: " + capAttrCmdList.size());
		System.out.println("\tTotal Attributes: " + allPropsList.size());
		System.out.println("\tTotal Commands: " + allCommandsList.size());
	}

	@Override
	public void call(SourceUnit source, GeneratorContext context, ClassNode classNode)
			throws CompilationFailedException {
		HashSet<String> foundCmdAPIs = new HashSet<>();
		List<Pair<String, String>> allFoundCmd = new ArrayList<>();
		Set<String> entryMethods = new HashSet<>();
		List<ICFGNode> nodes = new ArrayList<ICFGNode>();

		ConstructCFG cfg = new ConstructCFG();
		for (MethodNode mh : classNode.getMethods())
			cfg.visitMethod(mh);

		// Attributes and Capabilities
		System.out.println("\nExtracting Attributes and capabilities");
		System.out.println("****************************************");
		InsnVisitor iv = new InsnVisitor();
		classNode.visitContents(iv);

		System.out.println("Input List:");
		System.out.println("\tDevice Capabilities:");
		int i = 1;

		for (Quartet<String, String, String, String> it : iv.getDeviceCap()) {
			System.out.println("\t\t" + i++ + "- Object: " + it.getValue0() + " | Type: " + it.getValue1()
			+ " | isMultiple: " + it.getValue2());
		}

		System.out.println("\n\tUser Capabilities:");
		i = 1;

		for (Quartet<String, String, String, List<String>> it : iv.getAppVarToCapUsrFull()) {
			System.out.println("\t\t" + i++ + "- Object: " + it.getValue0() + " | Type: " + it.getValue1()
			+ " | isMultiple: " + it.getValue2() + " | Options: " + it.getValue3());

			if (it.getValue1().contains("boolean")) {
				appsContainEnum.add(appName);
			}
			inputTypes.add(it.getValue1());
		}
		
		//Print device capabilities and user input to excel file
		/*
		try {
			GenerateInputConfig.writeToExcell(project_root+"/IoTSAN_Input/", appName, iv.getDeviceCap(), iv.getAppVarToCapUsrFull());
		} catch (EncryptedDocumentException | InvalidFormatException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/

		System.out.println("\nSubscription List: ");
		i = 1;
		for (String attr : iv.getDetailsAttr().keySet()) {
			String obj = iv.getDetailsAttr().get(attr);
			String cap = "";
			for (Quartet<String, String, String, String> it : iv.getDeviceCap()) {
				if (it.getValue0().equals(obj))
					cap = it.getValue1();
			}
			System.out.println("\t" + i++ + "- attr: " + attr + " | Obj: " + obj + " | Cap: " + cap);
		}

		System.out.println("\nExtracting Entry points (Method Handlers)");
		System.out.println("****************************************");
		for (Triplet<String, String, String> t : iv.getAttributes()) {
			entryMethods.add(t.getValue2());
		}
		System.out.println("Number of entry points: " + entryMethods.size());
		System.out.println("\t" + entryMethods);

		System.out.println("****************************************");
		System.out.println();

		// Command APIs
		System.out.println("Extracting Command APIs and Special Capabilities");
		System.out.println("****************************************");
		ConstructVisitor cv = new ConstructVisitor(allCommandsList, iv.getAttributes(), iv.getDeviceCap(),
				iv.getSpecialCapInInput());
		classNode.visitContents(cv);
		
		nodes = cv.getNodes();

		for (ICFGNode node : nodes) {
			if (node.getTag() == "sink") {
				foundCmdAPIs.add(node.getMethodName());
				Pair<String, String> p = new Pair<String, String>(node.getMethodName(),
						node.getLineNumber().toString());
				allFoundCmd.add(p);
				Map<String, String> map = new HashMap<>();
				// sometimes the object contains ? to avoid null pointer exception.
				// so the ? should be removed
				String obj = node.getMetadata().split("\\.")[0];
				if (node.getMetadata().split("\\.")[0].contains("?"))
					obj = node.getMetadata().split("\\.")[0].replaceAll("\\?", "");
				// Constructing object/command/capability
				for (Quartet<String, String, String, String> it : iv.getDeviceCap()) {
					if (it.getValue0().equals(obj)) {
						Triplet<String, String, String> tr = new Triplet<String, String, String>(obj,
								node.getMethodName(), it.getValue1().split("\\.")[1]);
						objToCmdToCap.add(tr);
					}
				}
			}
		}

		System.out.println("Number Commands: " + allFoundCmd.size());
		System.out.println("\tCommands are: " + allFoundCmd.toString());

		System.out.println("\nNumber of Special Cap: " + cv.getSpecialCapTuple().size());
		for (Triplet<String, String, String> f : cv.getSpecialCapTuple()) {
			System.out.println("\t" + f.getValue0() + " __ " + f.getValue1() + " __ " + f.getValue2());
		}

		System.out.println("****************************************");
		System.out.println();

		// System.out.println("Constructing Intra CFG [Caller, Callee, [Predicate]]");
		// System.out.println("****************************************");
		List<Triplet<String, String, List<Pair<Expression, String>>>> intraPaths = cv.getIntraCallList();
		
		System.out.println("Identifying all paths to commands");
		System.out.println("****************************************");
		CreatingRules cr = new CreatingRules(entryMethods, foundCmdAPIs, iv.getAttributes(), iv.getDeviceCap(),
				iv.getUsrCap(), cv.generateNumericRange(), intraPaths, cv.getDexpressions(), cfg, cv.getValidMethods(),
				capAttrCmdList, cv.getSpecialCapTuple());

		System.out.println("\n****************************************");

		cr.generateRules();
		if (cr.containsOR()) {
			containOR.add(appName);
		}
		///////////////////////////////////////////
		/*
		i = 1;
		for (Triplet<String, String, String> t : iv.getAttributes()) {
			String conditions = null;
			String command = null;
			for (List<String> p : cv.getCgLst()) {
				List<List<Pair<Expression, String>>> fullPathCond = new ArrayList<>();
				int idx = p.indexOf(t.getValue2());
				if (idx != -1) {
					command = p.get(p.size() - 1);
					for (int s = 0; s < p.size() - 1; s++) {
						// System.out.println("\tPath: "+p.get(s)+"__"+p.get(s+1));
						// System.out.println("\t\tCond: "+ cv.getFullPathCondition(p.get(s),
						// p.get(s+1)));
						fullPathCond.add(cv.getFullPathCondition(p.get(s), p.get(s + 1)));
					}
					conditions = fullPathCond.toString();
				}
			}
		}
		*/

		// Generating template
		
		appName = appName.split("\\.")[0];
		String outDir = project_root+"/Output";
		String outDirMotv = project_root+"/MotivationSnip";
		String outDirBench = project_root + "/out_bench";
//		String outNewBenchApps = project_root + "/newBenchTemplates/";
		String outNewBenchApps = project_root + "/ALL_APPS/";
		try {
			System.out.println("Create App Template...");
			confg = getConfigurationInstance(project_root+"/Input/templates");
			//			System.out.println("Number of Rules:: "+ cr.getRulesNew().size());
			String s = String.format("%s,%d", appName,cr.getRulesNew().size());
			StringBuilder sb = new StringBuilder();
		    sb.append(s+"\n");
		    rulesWriter.write(sb.toString());
			if (cr.getRulesNew().size() != 0) {
				generateAppTemplate(appName, outNewBenchApps, iv.getDeviceCap(), cr.getSpecialCapLst(), cr.getRulesNew(),
						cv.generateNumericRange(), iv.getAppVarToCapUsrFull(), cr.getUsedUserInputInPred(),
						cr.getAppTouch(), cr.getNowValues()); //cv.getSpecialCapTuple()
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TemplateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	@SuppressWarnings({ "deprecation" })
	private static Configuration getConfigurationInstance(String destDir) throws IOException {
		if (confg == null) {
			confg = new Configuration();
			confg.setDirectoryForTemplateLoading(new File(destDir));
			confg.setObjectWrapper(new DefaultObjectWrapper());
			confg.setDefaultEncoding("UTF-8");
			confg.setTemplateExceptionHandler(TemplateExceptionHandler.HTML_DEBUG_HANDLER);
			confg.setIncompatibleImprovements(new Version(2, 3, 20));
		}
		return confg;
	}

	private static void generateAppTemplateIFTTT(HashMap<String, Pair<List<String>, List<String>>> rules, String outputFolder) throws IOException, TemplateException {
		Map<String, Object> root = new HashMap<String, Object>();
		Map<String, List<Object>> ruleToTrig = new HashMap<>();
		Map<String, List<Object>> ruleToComm = new HashMap<>();
		
		for (String r : rules.keySet()) {
			Set<Object> appCapabilities = new HashSet<>();
			List<Object> appProperties = new ArrayList<>();
			List<Object> ruleTrig = new ArrayList<>();
			//String allCap = "capabilities = ";
			
			Map<String, String> prop = new HashMap<String, String>();
			Map<String, String> trig = new HashMap<String, String>();
			if (!rules.get(r).getValue0().isEmpty()) {
				trig.put("obj", "trigObj");
				trig.put("capabilities", rules.get(r).getValue0().get(0));
				trig.put("attribute", rules.get(r).getValue0().get(1));
				trig.put("value", rules.get(r).getValue0().get(2));
				ruleTrig.add(trig);
				
				prop.put("name", "trigObj");
				prop.put("type", "cap_" + rules.get(r).getValue0().get(0));
				prop.put("cardinality", "one");
				appProperties.add(prop);
				appCapabilities.add(rules.get(r).getValue0().get(0));
			}
			ruleToTrig.put("1", ruleTrig);

			// ruleCommands subsection, 
			List<Object> ruleComm = new ArrayList<>();
			Map<String, String> comm = new HashMap<String, String>();
			Map<String, String> propComm = new HashMap<String, String>();
			if (!rules.get(r).getValue1().isEmpty()) {
				comm.put("capabilities", rules.get(r).getValue1().get(0));
				comm.put("attribute", rules.get(r).getValue1().get(1));
				comm.put("value", rules.get(r).getValue1().get(2));
				ruleComm.add(comm);
				propComm.put("name", rules.get(r).getValue1().get(0));
				propComm.put("type", "cap_" + rules.get(r).getValue1().get(0));
				propComm.put("cardinality", "one");
				appProperties.add(propComm);
				appCapabilities.add(rules.get(r).getValue1().get(0));
			}
			ruleToComm.put("1", ruleComm);	
			
			root.put("triggers", ruleToTrig);
			root.put("commands", ruleToComm);
			root.put("appCapabilities", appCapabilities);
			root.put("appProperties", appProperties);
			//root.put("allCap", allCap);
			root.put("appName", r.replace("-", "_"));
			
			System.out.println("Generating IFTTT Template...");
			writeOutput(root, outputFolder, "app", r, "IFTTT");
		}
	}

	private static void generateAppTemplate(String appName, String outputFolder,
			List<Quartet<String, String, String, String>> devCap, List<Triplet<String, String, String>> specCap,
			Set<Triplet<List<List<String>>, Set<List<String>>, List<List<String>>>> rules,
			HashMap<List<String>, List<Integer>> rangeMap,
			List<Quartet<String, String, String, List<String>>> userCapAll, Set<String> userInput, String appTouch, Set<String> nowValues)
					throws IOException, TemplateException {
		Map<String, Object> root = new HashMap<String, Object>();
		Set<Object> appCapabilities = new HashSet<>();
		Set<Object> appProperties = new HashSet<>();
		List<Object> appStateAttributes = new ArrayList<>();

		// AppName section
		root.put("appName", appName.replace("+", ""));

		// appCapabilities section & appProperties section
		String allCap = "capabilities = ";
		int c = 0;
		for (Quartet<String, String, String, String> it : devCap) {
			Map<String, String> cap = new HashMap<String, String>();
			Map<String, String> prop = new HashMap<String, String>();

			cap.put("id", it.getValue1().substring(11));
			
			prop.put("name", it.getValue0());
			prop.put("type", "cap_" + it.getValue1().substring(11));
			if (it.getValue2().equals("false") && it.getValue3().equals("false")) {
				prop.put("cardinality", "one");
			} else if (it.getValue2().equals("true") && it.getValue3().equals("true")) {
				prop.put("cardinality", "set");
			} else if (it.getValue2().equals("true") && it.getValue3().equals("false")) {
				prop.put("cardinality", "some");
			} else if (it.getValue2().equals("false") && it.getValue3().equals("true")) {
				prop.put("cardinality", "lone");
			}

			if (c < devCap.size() - 1) {
				allCap = allCap + it.getValue0() + " + ";
			} else {
				allCap = allCap + it.getValue0();
			}

			appCapabilities.add(cap);
			appProperties.add(prop);
			c++;
		}

		c = 0;

		for (String i : userInput) {
			for (Quartet<String, String, String, List<String>> it : userCapAll) {
				if (i.equals(it.getValue0())) {
					Map<String, String> prop = new HashMap<String, String>();

					prop.put("name", it.getValue0());
					prop.put("type", "cap_userInput");

					if (it.getValue2().equals("false")) {
						prop.put("cardinality", "one");
					} else if (it.getValue2().equals("true")) {
						prop.put("cardinality", "some");
					}

					if (allCap.length() > 16) {
						allCap = allCap + " + " + it.getValue0();
					} else {
						allCap = allCap + it.getValue0();
					}

					appProperties.add(prop);
					c++;
				}
			}
			Map<String, String> cap = new HashMap<String, String>();
			cap.put("id", "userInput");
			appCapabilities.add(cap);
		}
		// construct user's inputs used in the app
		List<String> userInputList = new ArrayList<>();
		String[] inputTypes = new String[] { "number", "phone", "contact", "time", "text", "decimal"};
		List<String> listInputTypes = Arrays.asList(inputTypes);

		for (String i : userInput) {
			for (Quartet<String, String, String, List<String>> it : userCapAll) {
				if (i.equals(it.getValue0())) {
					//userInputList.add("abstract sig cap_userInput_attr_" + i + "_val extends AttrValue {}");
					if (it.getValue1().equals("enum")) {
						//				System.out.println("abstract sig cap_UserInput_attr_"+it.getValue1()+"_val extends AttrValue {}");	
						for (String l : it.getValue3()) {
							//					System.out.println("one sig cap_UserInput_attr"+it.getValue1()+"_val_"+l+
							//							"extends cap_UserInput_attr_"+it.getValue1()+"_val {}");
							//userInputList.add("one sig cap_userInput_attr_" + i + "_val_" + l + " extends cap_userInput_attr_" + i + "_val {}");
						}
					} else if (it.getValue1().equals("bool") || it.getValue1().equals("boolean")) {
						userInputList.add("one sig cap_userInput_attr_" + i + "_val_yes extends cap_userInput_attr_" + i + "_val {}");
						userInputList.add("one sig cap_userInput_attr_" + i + "_val_no extends cap_userInput_attr_" + i + "_val {}");
					} else if (listInputTypes.contains(it.getValue1())) {
						System.out.println("Inside::: "+ it.getValue1());
						//userInputList.add("one sig cap_userInput_attr_" + i + "_val extends cap_userInput_attr_" + i + "_val {}");
					}
				}
			}
		}
		root.put("userCapSize", userInput.size()+"");
		root.put("userCapSet", userInput);

		//write the values of cap_now
		List<String> newValuesList = new ArrayList<>();
		for (String v : nowValues) {
			newValuesList.add("one sig cap_now_attr_now_val_"+ v + " extends cap_now_attr_now_val {}");
		}
		root.put("nowValues", newValuesList);

		//special capabilities
		//Map<String, String> specCapSz = new HashMap<String, String>();
		String specCapSize = "Empty";
//		System.out.println("state cap:: "+ specCap.size());
		if (!specCap.isEmpty()) {
			specCapSize = "NotEmpty";
			Map<String, String> prop = new HashMap<String, String>();
			prop.put("name", "state");
			prop.put("type", "cap_state");
			prop.put("cardinality", "one");

			if (allCap.length() > 16) {
				allCap = allCap + " + state";
			} else {
				allCap = allCap + "state";
			}
			appProperties.add(prop);
		}

		root.put("specCapSize", specCapSize);

		// check if app touch is used
		System.out.println("Touch:: "+ appTouch);
		root.put("appTouch", appTouch);
		if (appTouch.equals("yes")) {
			Map<String, String> prop = new HashMap<String, String>();
			prop.put("name", "app");
			prop.put("type", "cap_app");
			prop.put("cardinality", "one");
			appProperties.add(prop);
			if (allCap.length() > 16) {
				allCap = allCap + " + app";
			} else {
				allCap = allCap + "app";
			}
		}

		String ranges = "";
		Map<String, String> rangeProp = new HashMap<String, String>();
		List<Object> rangesLst = new ArrayList<>();
		for (List<String> r : rangeMap.keySet()) {
			for (int i = 0; i <= rangeMap.get(r).size(); i++) {
				if (i == 0) {
					ranges = ranges + "range_" + i;
				} else {
					ranges = ranges + ",range_" + i;
				}
			}

			for (Quartet<String, String, String, String> it : devCap) {
				if (r.get(0).equals(it.getValue0())) {
					rangeProp.put("capabilities", it.getValue1().split("\\.")[1]);
				}
			}
			rangeProp.put("range", ranges);
			rangeProp.put("attribute", r.get(1));
			rangesLst.add(rangeProp);
		}

		root.put("appCapabilities", appCapabilities);
		root.put("appProperties", appProperties);
		root.put("allCap", allCap);
		root.put("ranges", rangesLst);
		root.put("userInputList", userInputList);

		// appStateAttributes section & state_attrValues section
		Set<Triplet<String, String, String>> specCapSet = new HashSet<Triplet<String, String, String>>(specCap);
		Set<String> stProp = new HashSet<>();
		for (Triplet<String, String, String> it : specCapSet) {
			stProp.add(it.getValue1());
		}

		Map<String, List<String>> statePropValLst = new HashMap<>();
		for (String it : stProp) {
			Map<String, String> stateProp = new HashMap<String, String>();
			stateProp.put("name", it);
			appStateAttributes.add(stateProp);

			List<String> stValu = new ArrayList<>();
			for (Triplet<String, String, String> its : specCapSet) {
				if (it.equals(its.getValue1())) {
					stValu.add(its.getValue2());
				}
			}
			if (it.equals("runIn")) {
				stValu.add("off");
			}
			statePropValLst.put(it, stValu);
		}

		root.put("stateAttrValues", statePropValLst);
		root.put("appStateAttributes", appStateAttributes);

		// appRules section
		Map<String, List<Object>> ruleToTrig = new HashMap<>();
		Map<String, List<Object>> ruleToCond = new HashMap<>();
		Map<String, List<Object>> ruleToComm = new HashMap<>();
		
		String[] locModeVal = new String[] { "home", "away", "night" };
		List<String> listlocModeVal = Arrays.asList(locModeVal);
		
		int rID = 0;
		for (Triplet<List<List<String>>, Set<List<String>>, List<List<String>>> r : rules) {
			// ruleTriggers subsection, map: rule-->trigger
			List<Object> ruleTrig = new ArrayList<>();

			for (List<String> trg : r.getValue0()) {
				Map<String, String> trig = new HashMap<String, String>();
				if (!trg.isEmpty()) {
					if (trg.get(0).equals("location")) {
						Map<String, String> prop = new HashMap<String, String>();
						prop.put("name", "location");
						prop.put("type", "cap_location");
						prop.put("cardinality", "one");
						appProperties.add(prop);
						
						Map<String, String> cap = new HashMap<String, String>();
						cap.put("id", "location");
						appCapabilities.add(cap);
					}
					
					trig.put("obj", trg.get(0));
					trig.put("capabilities", trg.get(3));
					trig.put("attribute", trg.get(1));
					trig.put("value", trg.get(2));
					trig.put("app", "0");
					
					if (trg.get(2) != null && !listlocModeVal.contains(trg.get(2).toLowerCase()) && trg.get(0).equals("location")) {
						if (trg.get(2).equals("no_value")) {
							//continue;
						}
						Map<String, String> prop = new HashMap<String, String>();
						prop.put("name", trg.get(2));
						prop.put("type", "cap_location_attr_mode_val");
						prop.put("cardinality", "one");
						appProperties.add(prop);
						trig.put("app", "1");
					}
					ruleTrig.add(trig);
				}
			}
			ruleToTrig.put(Integer.toString(rID), ruleTrig);

			// ruleConditions subsection, map: rule-->condition
			List<Object> ruleCond = new ArrayList<>();
			for (List<String> cnd : r.getValue1()) {
				Map<String, String> cond = new HashMap<String, String>();
				if (!cnd.isEmpty()) {
					if (cnd.get(0).equals("runIn")) {
						Map<String, String> cap = new HashMap<String, String>();
						cap.put("id", "runIn");
						appCapabilities.add(cap);

						Map<String, String> prop = new HashMap<String, String>();
						prop.put("name", "runIn");
						prop.put("type", "cap_runIn");
						prop.put("cardinality", "one");
						appProperties.add(prop);
					}
					
					if (cnd.get(0).equals("location")) {
						Map<String, String> prop = new HashMap<String, String>();
						prop.put("name", "location");
						prop.put("type", "cap_location");
						prop.put("cardinality", "one");
						appProperties.add(prop);
						
						Map<String, String> cap = new HashMap<String, String>();
						cap.put("id", "location");
						appCapabilities.add(cap);
					}
					
					
					cond.put("obj", cnd.get(0));
					cond.put("capabilities", cnd.get(3));
					cond.put("attribute", cnd.get(1));
					cond.put("app", "0");
					String valueLoc = null;
					
					if (cnd.get(2).endsWith("_Not")) {
						cond.put("neg", "1");
						cond.put("value", cnd.get(2).split("_Not")[0].replace(" ", "_"));
						valueLoc = cnd.get(2).split("_Not")[0].replace(" ", "_");
					} else {
						cond.put("neg", "0");
						cond.put("value", cnd.get(2).replace(" ", "_"));
						valueLoc = cnd.get(2).replace(" ", "_");
					}
					
					if (cnd.get(2) != null && !listlocModeVal.contains(cnd.get(2).toLowerCase()) && cnd.get(0).equals("location")) {
						if (cnd.get(2).equals("no_value")) {
							continue;
						}
						Map<String, String> prop = new HashMap<String, String>();
						prop.put("name", valueLoc);
						prop.put("type", "cap_location_attr_mode_val");
						prop.put("cardinality", "one");
						appProperties.add(prop);
						cond.put("app", "1");
					}
					
					ruleCond.add(cond);
				}
			}
			ruleToCond.put(Integer.toString(rID), ruleCond);

			// ruleCommands subsection, map: rule-->command
			List<Object> ruleComm = new ArrayList<>();
			for (List<String> cnd : r.getValue2()) {
				Map<String, String> comm = new HashMap<String, String>();
				if (!cnd.isEmpty()) {
					if (cnd.get(0).equals("runIn")) {
						Map<String, String> cap = new HashMap<String, String>();
						cap.put("id", "runIn");
						appCapabilities.add(cap);
						
						Map<String, String> prop = new HashMap<String, String>();
						prop.put("name", "runIn");
						prop.put("type", "cap_runIn");
						prop.put("cardinality", "one");
						appProperties.add(prop);
					}
					
					comm.put("capabilities", cnd.get(0));
					comm.put("attribute", cnd.get(1));
					comm.put("value", cnd.get(2));
					comm.put("app", "0");
					comm.put("loc", "0");
					//comm.put("state", "0");
					
					if (cnd.get(0).equals("location")) {
						comm.put("loc", "1");
						Map<String, String> prop = new HashMap<String, String>();
						prop.put("name", "location");
						prop.put("type", "cap_location");
						prop.put("cardinality", "one");
						appProperties.add(prop);
						
						Map<String, String> cap = new HashMap<String, String>();
						cap.put("id", "location");
						appCapabilities.add(cap);
						
						if (cnd.get(2) != null && ! listlocModeVal.contains(cnd.get(2).toLowerCase())) {
							Map<String, String> propLoc = new HashMap<String, String>();
							propLoc.put("name", cnd.get(2));
							propLoc.put("type", "cap_location_attr_mode_val");
							propLoc.put("cardinality", "one");
							appProperties.add(propLoc);
							comm.put("app", "1");
						}
					}
					
					if (cnd.get(0).equals("state")) {
						comm.put("loc", "1");
					}
					
					ruleComm.add(comm);
				}
			}
			ruleToComm.put(Integer.toString(rID), ruleComm);
			rID++;
		}

		root.put("triggers", ruleToTrig);
		root.put("conditions", ruleToCond);
		root.put("commands", ruleToComm);

		System.out.println("Generating IoTApp Template...");
		writeOutput(root, outputFolder, "app", appName, "ST");

	}

	private static void appsCotainenum() {
		System.out.println("Size Enum:: " + appsContainEnum.size());
		for (String f : appsContainEnum) {
			System.out.println("_____" + f);
		}
	}

	private static void writeOutput(Map<String, Object> root, String outputDir, String templateFile, String outputFile, String type)
			throws IOException, TemplateException {
		if (type.equals("IFTTT")) {
			Template template = confg.getTemplate(templateFile + "_IFTTT.ftl");
			FileWriter writer = new FileWriter(new File(outputDir, outputFile + ".als"));
			template.process(root, writer);
		} else {
			Template template = confg.getTemplate(templateFile + ".ftl");
			FileWriter writer = new FileWriter(new File(outputDir, outputFile + ".als"));
			template.process(root, writer);
		}
	}
}