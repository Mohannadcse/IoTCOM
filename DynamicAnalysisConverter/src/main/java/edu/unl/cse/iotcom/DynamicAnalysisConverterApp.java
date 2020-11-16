package edu.unl.cse.iotcom;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jgrapht.Graph;
import org.jgrapht.GraphPath;
import org.jgrapht.alg.shortestpath.DijkstraShortestPath;
import org.jgrapht.graph.DefaultDirectedGraph;
import org.jgrapht.graph.DefaultEdge;
import org.w3c.dom.DOMException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;

import com.google.common.collect.Iterables;
import com.google.common.collect.Sets;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class DynamicAnalysisConverterApp {

	@SuppressWarnings("unused")
	private final class AppOutput {
		final Map<String, Object> config = new HashMap<>();
		final String name;

		private AppOutput(String name) {
			this.name = name;
		}
	}

	private final class DAV {
		final String attribute;
		final String[] capabilities;
		final String[] values;

		private DAV(String[] devices, String attribute, String[] values) {
			this.capabilities = devices;
			this.attribute = attribute;
			this.values = values;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (!(obj instanceof DAV))
				return false;
			DAV other = (DAV) obj;
			if (!getEnclosingInstance().equals(other.getEnclosingInstance()))
				return false;
			return Objects.equals(attribute, other.attribute) && Arrays.equals(capabilities, other.capabilities)
					&& Arrays.equals(values, other.values);
		}

		private DynamicAnalysisConverterApp getEnclosingInstance() {
			return DynamicAnalysisConverterApp.this;
		}

		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + getEnclosingInstance().hashCode();
			result = prime * result + Arrays.hashCode(capabilities);
			result = prime * result + Arrays.hashCode(values);
			result = prime * result + Objects.hash(attribute);
			return result;
		}
	}

	@SuppressWarnings("unused")
	private final class DeviceOutput {
		final String name;
		final List<String[]> settings = new ArrayList<>();

		private DeviceOutput(String name) {
			this.name = name;
		}
	}

	@SuppressWarnings("unused")
	private final class EventOutput {
		final String attribute;
		final String device;
		final String value;

		private EventOutput(String device, String attribute, String value) {
			this.device = device;
			this.attribute = attribute;
			this.value = value;
		}
	}

	@SuppressWarnings("unused")
	private final class Output {
		final List<AppOutput> apps = new ArrayList<>();
		final List<SetupOutput> setup = new ArrayList<>();
		final String threat;

		private Output(String threat) {
			this.threat = threat;
		}
	}

	private final class Rule {
		final DAV[] actions;
		final DAV[] conditions;
		final DAV[] triggers;

		private Rule(DAV[] triggers, DAV[] conditions, DAV[] actions) {
			this.triggers = triggers;
			this.conditions = conditions;
			this.actions = actions;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (!(obj instanceof Rule))
				return false;
			Rule other = (Rule) obj;
			if (!getEnclosingInstance().equals(other.getEnclosingInstance()))
				return false;
			return Arrays.equals(actions, other.actions) && Arrays.equals(conditions, other.conditions)
					&& Arrays.equals(triggers, other.triggers);
		}

		private DynamicAnalysisConverterApp getEnclosingInstance() {
			return DynamicAnalysisConverterApp.this;
		}

		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + getEnclosingInstance().hashCode();
			result = prime * result + Arrays.hashCode(actions);
			result = prime * result + Arrays.hashCode(conditions);
			result = prime * result + Arrays.hashCode(triggers);
			return result;
		}
	}

	@SuppressWarnings("unused")
	private final class SetupOutput {
		final List<DeviceOutput> devices = new ArrayList<>();
		final EventOutput event;

		private SetupOutput(EventOutput event) {
			this.event = event;
		}
	}

	private static final String AtrRE = ".*/cap_.*_attr_([^\\$]*)\\$\\d+";

	private static final String CapRE = ".*/cap_([^\\$]*)\\$(\\d+)";

	private static final Logger logger = LogManager.getFormatterLogger();

	private static final String SecondAtomLabel = "//field[@label='%s']/tuple[atom[1]/@label='%s']/atom[2]/@label";

	private static final String SkolemRule = "//skolem[@label=\"$%s_%s\"]/tuple/atom/@label";

	private static final String ValRE = ".*/cap_.*_attr_.*_val_([^\\$]*)\\$\\d+";

	public static void main(String[] args) {
		try {
			new DynamicAnalysisConverterApp(args[0]).run();
		} catch (Exception e) {
			logger.error("unexpected error", e);
		}
	}

	private final DocumentBuilder builder;

	private final Path filename;

	private final Path outfile;

	private final XPathHelper xPath;

	public DynamicAnalysisConverterApp(String filename) throws ParserConfigurationException {
		this.filename = Paths.get(filename);
		this.outfile = this.filename.resolveSibling(this.filename.getFileName() + ".json");
		this.builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		this.xPath = new XPathHelper();
	}

	private DAV[] getAct(Document xml, String rule) throws XPathExpressionException {
		List<DAV> retval = new ArrayList<>();
		for (Node a : xPath.findAll(String.format(SecondAtomLabel, "commands", rule), xml)) {
			String aname = a.getNodeValue();
			String[] caps = xPath.findAllStr(String.format(SecondAtomLabel, "capability", aname), xml);
			String attr = xPath.findStr(String.format(SecondAtomLabel, "attribute", aname), xml);
			String[] vals = xPath.findAllStr(String.format(SecondAtomLabel, "value", aname), xml);
			retval.add(new DAV(caps, attr, vals));
		}
		return retval.toArray(new DAV[0]);
	}

	private DAV[] getCnd(Document xml, String rule) throws XPathExpressionException, DOMException {
		List<DAV> retval = new ArrayList<>();
		for (Node a : xPath.findAll(String.format(SecondAtomLabel, "conditions", rule), xml)) {
			String aname = a.getNodeValue();
			String[] caps = xPath.findAllStr(String.format(SecondAtomLabel, "capabilities", aname), xml);
			String attr = xPath.findStr(String.format(SecondAtomLabel, "attribute", aname), xml);
			String[] vals = xPath.findAllStr(String.format(SecondAtomLabel, "value", aname), xml);
			retval.add(new DAV(caps, attr, vals));
		}
		return retval.toArray(new DAV[0]);
	}

	private Graph<Rule, DefaultEdge> getConnectedRuleGraph(final Document xml) throws XPathExpressionException {
		// for the connected nodes: //field[@label="connected"]/tuple
		final Graph<Rule, DefaultEdge> g = new DefaultDirectedGraph<>(DefaultEdge.class);
		for (Node t : xPath.findAll("//field[@label='connected']/tuple", xml)) {
			final Rule src = getRule(xml, xPath.findStr("atom[1]/@label", t));
			final Rule dst = getRule(xml, xPath.findStr("atom[2]/@label", t));
			g.addVertex(src);
			g.addVertex(dst);
			g.addEdge(src, dst);
		}
		return g;
	}

	private void getDevices(Document xml, Graph<Rule, DefaultEdge> g, SetupOutput out, Set<DAV> configs)
			throws XPathExpressionException {
		// find all the devices ("capabilities")
		String[] dnames = xPath.findAllStr("//sig[@parentID=//sig[@label='base/Capability']/@ID]/atom/@label", xml);
		for (String dname : dnames) {
			DeviceOutput dev = new DeviceOutput(dname.replaceAll(CapRE, "$1$2"));
			out.devices.add(dev);
			for (DAV config : Iterables.filter(configs, dav -> Sets.newHashSet(dav.capabilities).contains(dname))) {
				dev.settings.add(new String[] { config.attribute.replaceAll(AtrRE, "$1"),
						config.values[0].replaceAll(ValRE, "$1") });
			}
		}
	}

	private void getEnvAndTriggerT1(Document xml, Graph<Rule, DefaultEdge> g, Output out)
			throws XPathExpressionException {
	}

	private void getEnvAndTriggerT2(Document xml, Graph<Rule, DefaultEdge> g, Output out)
			throws XPathExpressionException {
	}

	private void getEnvAndTriggerT3(Document xml, Graph<Rule, DefaultEdge> g, Output out)
			throws XPathExpressionException {
	}

	private void getEnvAndTriggerT4(Document xml, Graph<Rule, DefaultEdge> g, Output out)
			throws XPathExpressionException {
	}

	private void getEnvAndTriggerT5(Document xml, Graph<Rule, DefaultEdge> g, Output out)
			throws XPathExpressionException {
		// get the triggering events for a
		String a = xPath.findStr(String.format(SkolemRule, "t5", "a"), xml);
		String r = xPath.findStr(String.format(SkolemRule, "t5", "r"), xml);
		Rule arule = getRule(xml, a);
		Rule rrule = getRule(xml, r);
		// get the triggering events for a'
		String aprime = xPath.findStr(String.format(SkolemRule, "t5", "a'"), xml);
		String rprime = xPath.findStr(String.format(SkolemRule, "t5", "r'"), xml);
		Rule aprimerule = getRule(xml, aprime);
		Rule rprimerule = getRule(xml, rprime);
		// find the trigger they share
		DAV trig = Iterables.getFirst(
				Sets.intersection(Sets.newHashSet(arule.triggers), Sets.newHashSet(aprimerule.triggers)), null);
		if (trig == null)
			logger.error("[T5] no shared trigger between a and a'");
		// create a new event for it in the output
		EventOutput event = new EventOutput(trig.capabilities[0].replaceAll(CapRE, "$1$2"),
				trig.attribute.replaceAll(AtrRE, "$1"), trig.values[0].replaceAll(ValRE, "$1"));
		// create a new setup for that event
		SetupOutput setup = new SetupOutput(event);
		out.setup.add(setup);
		// find all the nodes in the path from a to r and from a' to r'
		Set<DAV> configs = new HashSet<>();
		Set<DAV> altered = new HashSet<>();
		GraphPath<Rule, DefaultEdge> ator = DijkstraShortestPath.findPathBetween(g, arule, rrule);
		for (DAV tdav : arule.triggers) {
			configs.add(new DAV(tdav.capabilities, tdav.attribute.replaceAll(AtrRE, "$1"), Arrays.stream(tdav.values)
					.map(v -> v.replaceAll(ValRE, "$1")).map(v -> "not(" + v + ")").toArray(String[]::new)));
		}
		configs.addAll(Arrays.asList(arule.triggers));
		for (Rule current : ator.getVertexList()) {
			for (DAV cond : current.conditions) {
				if (!configs.contains(cond) && !altered.contains(cond)) {
					configs.add(cond);
				}
			}
			altered.addAll(Arrays.asList(current.actions));
		}
		GraphPath<Rule, DefaultEdge> aprimetorprime = DijkstraShortestPath.findPathBetween(g, aprimerule, rprimerule);
		for (DAV tdav : aprimerule.triggers) {
			configs.add(new DAV(tdav.capabilities, tdav.attribute.replaceAll(AtrRE, "$1"), Arrays.stream(tdav.values)
					.map(v -> v.replaceAll(ValRE, "$1")).map(v -> "not(" + v + ")").toArray(String[]::new)));
		}
		for (Rule current : aprimetorprime.getVertexList()) {
			for (DAV cond : current.conditions) {
				if (!configs.contains(cond) && !altered.contains(cond)) {
					configs.add(cond);
				}
			}
			altered.addAll(Arrays.asList(current.actions));
		}
		getDevices(xml, g, setup, configs);
	}

	private void getEnvAndTriggerT6(Document xml, Graph<Rule, DefaultEdge> g, Output out)
			throws XPathExpressionException {
	}

	private void getEnvAndTriggerT7(Document xml, Graph<Rule, DefaultEdge> g, Output out)
			throws XPathExpressionException {
	}

	private Rule getRule(final Document xml, String label) throws XPathExpressionException {
		return new Rule(getTrg(xml, label), getCnd(xml, label), getAct(xml, label));
	}

	private DAV[] getTrg(Document xml, String rule) throws XPathExpressionException, DOMException {
		List<DAV> retval = new ArrayList<>();
		for (Node a : xPath.findAll(String.format(SecondAtomLabel, "triggers", rule), xml)) {
			String aname = a.getNodeValue();
			String[] caps = xPath.findAllStr(String.format(SecondAtomLabel, "capabilities", aname), xml);
			String attr = xPath.findStr(String.format(SecondAtomLabel, "attribute", aname), xml);
			String[] vals = xPath.findAllStr(String.format(SecondAtomLabel, "value", aname), xml);
			retval.add(new DAV(caps, attr, vals));
		}
		return retval.toArray(new DAV[0]);
	}

	public void run() throws Exception {
		final Document xml = builder.parse(filename.toFile());
		// get the threat that we check for
		final String threat = xPath.findStr("//instance/@command", xml).replace("Check ", "");
		final Output output = new Output(threat);
		// get the apps and their configurations
		for (Node n : xPath.findAll("//sig[@parentID=//sig[@label='base/IoTApp']/@ID]", xml)) {
			final String id = xPath.findStr("@ID", n);
			final String lb = xPath.findStr("@label", n).replaceAll(".*/app_", "");
			final AppOutput ao = new AppOutput(lb);
			// for the fields for each app: //field[@parentID="%s"]
			for (Node f : xPath.findAll(String.format("//field[@parentID='%s']", id), xml)) {
				final String flbl = f.getAttributes().getNamedItem("label").getNodeValue();
				final String fval = xPath.findStr("tuple/atom[2]/@label", f).replaceAll(CapRE, "$1$2");
				ao.config.put(flbl, fval);
			}
			output.apps.add(ao);
		}

		final Graph<Rule, DefaultEdge> g = getConnectedRuleGraph(xml);
		switch (threat) {
		case "t1":
			this.getEnvAndTriggerT1(xml, g, output);
			break;
		case "t2":
			this.getEnvAndTriggerT2(xml, g, output);
			break;
		case "t3":
			this.getEnvAndTriggerT3(xml, g, output);
			break;
		case "t4":
			this.getEnvAndTriggerT4(xml, g, output);
			break;
		case "t5":
			this.getEnvAndTriggerT5(xml, g, output);
			break;
		case "t6":
			this.getEnvAndTriggerT6(xml, g, output);
			break;
		case "t7":
			this.getEnvAndTriggerT7(xml, g, output);
			break;
		}

		final Gson gson = new GsonBuilder().setPrettyPrinting().create();
		final String json = gson.toJson(output);
		Files.write(outfile, json.getBytes(), StandardOpenOption.CREATE);
	}
}
