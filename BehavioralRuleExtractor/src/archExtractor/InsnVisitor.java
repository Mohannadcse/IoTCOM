package archExtractor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.codehaus.groovy.ast.ClassCodeVisitorSupport;
import org.codehaus.groovy.ast.expr.ConstantExpression;
import org.codehaus.groovy.ast.expr.Expression;
import org.codehaus.groovy.ast.expr.ListExpression;
import org.codehaus.groovy.ast.expr.MapEntryExpression;
import org.codehaus.groovy.ast.expr.MapExpression;
import org.codehaus.groovy.ast.expr.MethodCallExpression;
import org.codehaus.groovy.ast.expr.PropertyExpression;
import org.codehaus.groovy.ast.expr.TupleExpression;
import org.codehaus.groovy.control.SourceUnit;
import org.javatuples.Quartet;
import org.javatuples.Triplet;
import util.Helper;

public class InsnVisitor extends ClassCodeVisitorSupport{
	/***********************************************/
	Set<String> calledMethods;
	private static List< Quartet<String, String, String, String> > appVarToCapDev; // <obj,cap,isMultiple,isRequired>
	private static List< Triplet<String, String, String> > appVarToCapUsr; // <obj,inputType,isMultiple>
	private static List< Quartet<String, String, String, List<String>> > appVarToCapUsrFull;
	private static Map <String, String> appVarToAttr2Arg; // attr >> handler. i.e. subscribe(app, appTouch)
	private static Map <String, String> appVarToAttr3Arg; // obj >> attr
	HashSet<Triplet<String, String, String>> listTriggers; //Subscribe methods
	private List <Triplet<String, String, String> >  specialCapInInput; //some input stmts contain special cap i.e >> input "mode2", "mode", title: "To Mode..."
	/***********************************************/

	public InsnVisitor() {
		calledMethods = new HashSet<String>();
		appVarToCapDev = new ArrayList<>();
		appVarToCapUsr = new ArrayList<>();
		appVarToAttr2Arg = new HashMap<>();
		appVarToAttr3Arg = new HashMap<>();
		listTriggers = new HashSet<>(); //parse subscribe methods, which contain triggers
		appVarToCapUsrFull = new ArrayList<>();
		specialCapInInput = new ArrayList<>();
	}
	/**
	 * This method extracts several artifacts from the app
	 * - Attributes (Extracted from subscribe method)
	 * - Capability (Extracted from input method)
	 */
	@Override
	public void visitMethodCallExpression(MethodCallExpression mce) {
		String methText;

		if(mce.getMethodAsString() == null){
			//dynamic methods
			methText = mce.getText();
		}
		else{
			methText = mce.getMethodAsString();
		}

		//get input method arguments, specifically attribute and variable
		if(methText.equals("input") || methText.equals("ifSet")){
			calledMethods.add(mce.getMethodAsString().toLowerCase());

			String multiple = "";
			String required = "";

			if (isMultipleInput(mce.getArguments()))
				multiple = "true";
			else
				multiple = "false";

			if (isRequired(mce.getArguments())) 
				required = "true";
			else 
				required = "false";

			List<Expression> argList = buildExprList(mce.getArguments());
			if (argList.size() == 2) {
				if (argList.get(1) instanceof ConstantExpression) {
					String txt = argList.get(1).getText();//.toLowerCase();
					if (txt.contains("capability.")) {
						Quartet<String, String, String, String> tr = new Quartet<String, String, String, String>(argList.get(0).getText(), txt, multiple, required);
						appVarToCapDev.add(tr);
					} else {
						String[] specialLocCap = new String[] { "mode", "position", "sunset", "sunrise" , "sunriseTime" , "sunsetTime" };
						List<String> listspecialCap = Arrays.asList(specialLocCap);

						if (listspecialCap.contains(txt)) {
							specialCapInInput.add(new Triplet<String, String, String>("location", txt, argList.get(0).getText()));
						} else {
							Triplet<String, String, String> tr = new Triplet<String, String, String>(argList.get(0).getText(), txt, multiple);
							appVarToCapUsr.add(tr);
							String type = getInputType(mce.getArguments());
							List <String> options = new ArrayList<>();
							if (type.equals("enum")) {
								options = processEnumType(mce.getArguments());
							}
							Quartet<String, String, String, List<String>> q = new Quartet<String, String, String, List<String>>(argList.get(0).getText(), txt, multiple, options);
							appVarToCapUsrFull.add(q);
						}
					}
				}
			} else if (argList.size() > 2) {
				if (argList.get(2) instanceof ConstantExpression) {
					String txt = argList.get(2).getText();//.toLowerCase();
					if (txt.contains("capability.")) {
						Quartet<String, String, String, String> tr = new Quartet<String, String, String, String>(argList.get(1).getText(), txt, multiple, required);
						appVarToCapDev.add(tr);
					} else {
						String[] specialLocCap = new String[] { "mode", "position", "sunset", "sunrise" , "sunriseTime" , "sunsetTime" };
						List<String> listspecialCap = Arrays.asList(specialLocCap);

						if (listspecialCap.contains(txt)) {
							specialCapInInput.add(new Triplet<String, String, String>("location", txt, argList.get(1).getText()));
						} else {
						Triplet<String, String, String> tr = new Triplet<String, String, String>(argList.get(1).getText(), txt, multiple);
						appVarToCapUsr.add(tr);
						List <String> options = new ArrayList<>();
						String type = getInputType(mce.getArguments());;
						if (type != null && type.equals("enum")) {
							options = processEnumType(mce.getArguments());
						}
						Quartet<String, String, String, List<String>> q = new Quartet<String, String, String, List<String>>(argList.get(1).getText(), txt, multiple, options);
						appVarToCapUsrFull.add(q);
					}
					}
				}
			}
		}

		//subscribe can take 3 parameters or more 
		//subscribe(motionSensor, "motion", motionHandler)
		//subscribe(lightSensor, "illuminance", illuminanceHandler, [filterEvents: false])
		if(methText.equals("subscribe")) {
			List<Expression> args = buildExprList(mce.getArguments());
			if(args.size() >= 3){
				appVarToAttr3Arg.put(args.get(1).getText(), args.get(0).getText());
				Triplet<String, String, String> tuple = new Triplet<String, String, String>(args.get(0).getText(), args.get(1).getText(), args.get(2).getText());
				listTriggers.add(tuple);
			} else if(args.size() == 2){
				appVarToAttr2Arg.put(args.get(0).getText(), args.get(1).getText());
				Triplet<String, String, String> tuple = new Triplet<String, String, String>(null, args.get(0).getText(), args.get(1).getText());
				listTriggers.add(tuple);
			}
		}

		//schedule takes only two parameters. The trigger and method handler
		if(methText.equals("schedule")) {
			List<Expression> args = buildExprList(mce.getArguments());
			appVarToAttr2Arg.put(args.get(0).getText(), args.get(1).getText());
			Triplet<String, String, String> tuple = new Triplet<String, String, String>(null, args.get(0).getText(), args.get(1).getText());
			listTriggers.add(tuple);
		}

		if(methText.contains("$")){
			//possible reflection call
			System.out.println("Refelction Method");
		}
		super.visitMethodCallExpression(mce);
	}

	public List<Triplet<String, String, String>> getSpecialCapInInput() {
		return specialCapInInput;
	}
	public List<Quartet<String, String, String, List<String>>> getAppVarToCapUsrFull() {
		return appVarToCapUsrFull;
	}
	public static List<Expression> buildExprList(Expression args)
	{
		List<Expression> exprList = new ArrayList<Expression>();

		/* Build the list of argument expressions */
		if(args instanceof TupleExpression)
		{
			exprList = ((TupleExpression) args).getExpressions();
		}
		else
		{
			exprList.add(args);
		}

		return exprList;
	}

	@Override
	public void visitPropertyExpression(PropertyExpression pe) {
		//		System.out.println("pe.getPropertyAsString().toLowerCase():: "+ pe.getText());
		super.visitPropertyExpression(pe);
	}


	@Override
	protected SourceUnit getSourceUnit() {
		return null;
	}

	List<Quartet<String, String, String, String>> getDeviceCap(){
		return appVarToCapDev;

	}

	List<Triplet<String, String, String>> getUsrCap(){
		return appVarToCapUsr;
	}

	Map <String, String> getDetailsAttr(){
		HashMap<String, String> allAttr = new HashMap<>();
		allAttr.putAll(appVarToAttr2Arg);
		allAttr.putAll(appVarToAttr3Arg);
		return allAttr;
	}

	HashSet<Triplet<String, String, String>> getAttributes(){
		return listTriggers;
	}

	//If the input statement contains multiple, and its value: true or false
	private boolean isMultipleInput(Expression args) {
		List<Expression> exprList = Helper.buildExprList(args);
		Iterator<Expression> argIt;

		argIt = exprList.iterator();
		while(argIt.hasNext()) 
		{
			Expression arg = argIt.next();

			if (arg instanceof MapExpression)
			{
				MapExpression mex = (MapExpression)arg;
				Iterator<MapEntryExpression> entryExprIt;

				entryExprIt = mex.getMapEntryExpressions().iterator();
				while(entryExprIt.hasNext())
				{
					MapEntryExpression entryExpr = entryExprIt.next();
					Expression keyExpr = entryExpr.getKeyExpression();
					Expression valExpr = entryExpr.getValueExpression();

					if(keyExpr instanceof ConstantExpression && valExpr instanceof ConstantExpression)
					{
						String keyExprTxt = keyExpr.getText().toLowerCase();
						String valExprTxt = valExpr.getText().toLowerCase();

						if (keyExprTxt.equals("multiple") && valExprTxt.equals("true"))
						{
							return true;
						}
					}
				}
			}
		}
		return false;
	}

	private boolean isRequired(Expression args) {
		List<Expression> exprList = Helper.buildExprList(args);
		Iterator<Expression> argIt;

		argIt = exprList.iterator();
		while(argIt.hasNext()) 
		{
			Expression arg = argIt.next();

			if (arg instanceof MapExpression)
			{
				MapExpression mex = (MapExpression)arg;
				Iterator<MapEntryExpression> entryExprIt;
				entryExprIt = mex.getMapEntryExpressions().iterator();
				while(entryExprIt.hasNext())
				{
					MapEntryExpression entryExpr = entryExprIt.next();
					Expression keyExpr = entryExpr.getKeyExpression();
					Expression valExpr = entryExpr.getValueExpression();

					if(keyExpr instanceof ConstantExpression && valExpr instanceof ConstantExpression)
					{
						String keyExprTxt = keyExpr.getText().toLowerCase();
						String valExprTxt = valExpr.getText().toLowerCase();

						if (keyExprTxt.equals("required") && valExprTxt.equals("true"))
						{
							return true;
						}
					}
				}
			}
		}
		return false;
	}


	private List<String> processEnumType(Expression args)
	{
		List<Expression> exprList = Helper.buildExprList(args);
		Iterator<Expression> argIt;
		List<String>  enumList = new ArrayList<String>();
		/* Search for a map with key equals "options" */
		argIt = exprList.iterator();
		while(argIt.hasNext()) 
		{
			Expression arg = argIt.next();

			if (arg instanceof MapExpression)
			{
				MapExpression mex = (MapExpression)arg;
				Iterator<MapEntryExpression> entryExprIt = mex.getMapEntryExpressions().iterator();

				while(entryExprIt.hasNext())
				{
					MapEntryExpression entryExpr = entryExprIt.next();
					Expression keyExpr = entryExpr.getKeyExpression();
					Expression valExpr = entryExpr.getValueExpression();

					if(keyExpr instanceof ConstantExpression && valExpr instanceof ListExpression)
					{
						String keyExprTxt = keyExpr.getText().toLowerCase();

						if (keyExprTxt.equals("options") || keyExprTxt.equals("values"))
						{
							for(Expression enumExpr : ((ListExpression) valExpr).getExpressions())
							{
								if(enumExpr instanceof ConstantExpression)
								{
									String enumVal = enumExpr.getText();

									if(!enumList.contains(enumVal))
									{
										enumList.add(enumVal);
//										System.out.println("Option:: "+ enumVal);
									}
								}
							}
						}
						//there are cases where the metadata is used i.e. metadata: [values: ["heat","cool"]]
					} else if (keyExpr instanceof ConstantExpression && valExpr instanceof MapExpression) {
						enumList = processEnumType(valExpr);
					}
				}
			}
		}
		return enumList;
	}

	private String getInputType(Expression args)
	{
		List<Expression> exprList = Helper.buildExprList(args);
		Iterator<Expression> argIt;
		boolean isNamePresent = false;
		int index, typeIndex;

		/* Search for a map with key equals "name" */
		argIt = exprList.iterator();
		while(argIt.hasNext()) 
		{
			Expression arg = argIt.next();

			if (arg instanceof MapExpression)
			{
				MapExpression mex = (MapExpression)arg;
				Iterator<MapEntryExpression> entryExprIt = mex.getMapEntryExpressions().iterator();

				while(entryExprIt.hasNext())
				{
					MapEntryExpression entryExpr = entryExprIt.next();
					Expression keyExpr = entryExpr.getKeyExpression();
					Expression valExpr = entryExpr.getValueExpression();

					if(keyExpr instanceof ConstantExpression && valExpr instanceof ConstantExpression)
					{
						String keyExprTxt = keyExpr.getText().toLowerCase();
						String valExprTxt = valExpr.getText();

						if (keyExprTxt.equals("type"))
						{
							return valExprTxt;
						} else if(keyExprTxt.equals("name"))
						{
							isNamePresent = true;
						}
					}
				}
			}
		}

		/* type should be the second ConstantExpression */
		argIt = exprList.iterator();
		index = 1;
		typeIndex = isNamePresent? 1 : 2;
		while(argIt.hasNext()) 
		{
			Expression arg = argIt.next();

			if (arg instanceof ConstantExpression)
			{
				if (index == typeIndex)
				{
//					System.out.println("arg.getText():: "+ arg.getText());
					return arg.getText();
				}
				index++;
			}
		}
		return null;
	}

}
