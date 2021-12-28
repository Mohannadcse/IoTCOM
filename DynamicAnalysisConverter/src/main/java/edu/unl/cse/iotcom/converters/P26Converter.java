package edu.unl.cse.iotcom.converters;

import org.apache.commons.lang3.NotImplementedException;
import org.jgrapht.Graph;
import org.jgrapht.graph.DefaultEdge;
import org.w3c.dom.Node;

import edu.unl.cse.iotcom.ThreatConverter;

public class P26Converter extends ThreatConverter {

	@Override
	public String convert(Graph<String, DefaultEdge> connected, Node xml) throws Exception {
		throw new NotImplementedException("underlying threat def incorrect");
	}

}
