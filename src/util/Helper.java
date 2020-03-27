package util;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.groovy.ast.expr.Expression;
import org.codehaus.groovy.ast.expr.TupleExpression;

public class Helper {
	
	public Helper() {
		
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
	
	public static boolean isNumeric(String str)
	{
	    for (char c : str.toCharArray())
	    {
	        if (!Character.isDigit(c)) return false;
	    }
	    return true;
	}
}
