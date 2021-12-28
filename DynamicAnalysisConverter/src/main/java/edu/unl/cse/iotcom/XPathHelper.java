package edu.unl.cse.iotcom;

import java.util.Iterator;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.google.common.collect.Streams;

public final class XPathHelper {

	private final XPath xpath = XPathFactory.newInstance().newXPath();

	public String findStr(String query, Node context) throws XPathExpressionException {
		return (String) xpath.compile(query).evaluate(context, XPathConstants.STRING);
	}
	
	public String[] findAllStr(String query, Node context) throws XPathExpressionException {
		return Streams.stream(findAll(query, context)).map(Node::getNodeValue).toArray(String[]::new);
	}

	public Iterable<Node> findAll(String query, Node context) throws XPathExpressionException {
		NodeList result = (NodeList) xpath.compile(query).evaluate(context, XPathConstants.NODESET);
		return new Iterable<Node>() {
			@Override
			public Iterator<Node> iterator() {
				return new Iterator<Node>() {

					private int i = 0;

					@Override
					public boolean hasNext() {
						return i < result.getLength();
					}

					@Override
					public Node next() {
						return result.item(i++);
					}
				};
			}
		};
	}

	public Node findOne(String query, Node context) throws XPathExpressionException {
		return (Node) xpath.compile(query).evaluate(context, XPathConstants.NODE);
	}
}