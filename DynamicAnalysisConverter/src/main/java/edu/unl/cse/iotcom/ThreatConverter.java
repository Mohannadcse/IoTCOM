package edu.unl.cse.iotcom;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.xml.xpath.XPathExpressionException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jgrapht.Graph;
import org.jgrapht.graph.DefaultEdge;
import org.w3c.dom.Node;

import com.google.common.collect.Streams;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public abstract class ThreatConverter {

	public static class CavTriple {

		public final String atr;
		public final String cap;
		public final String val;

		public CavTriple(String cap, String atr, String val) {
			this.cap = cap.replaceAll(".*cap_([^\\$]+)\\$(\\d+)", "$1$2");
			this.atr = atr.replaceAll(".*attr_([^\\$]+)\\$\\d+", "$1");
			this.val = val.replaceAll(".*val_([^\\$]+)\\$\\d+", "$1");
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (!(obj instanceof CavTriple))
				return false;
			CavTriple other = (CavTriple) obj;
			return Objects.equals(atr, other.atr) && Objects.equals(cap, other.cap) && Objects.equals(val, other.val);
		}

		@Override
		public int hashCode() {
			return Objects.hash(atr, cap, val);
		}

		@Override
		public String toString() {
			return "CavTriple [cap=" + cap + ", atr=" + atr + ", val=" + val + "]";
		}
	}

	protected static class Output {

		public static class App {
			public final Map<String, Object> config = new HashMap<>();
			public final String name;

			public App(String name) {
				this.name = name;
			}
		}
		public final List<Output.App> apps = new ArrayList<>();
		public final List<CavTriple> config = new ArrayList<>();
		public final List<CavTriple> events = new ArrayList<>();

		public final String threat;

		public Output(String threat) {
			this.threat = threat;
		}
	}

	public static class Rule {

		public final Set<CavTriple> acts = new HashSet<>();
		public final String app;
		public final Set<CavTriple> cnds = new HashSet<>();
		public final String name;
		public final Set<CavTriple> trgs = new HashSet<>();

		public Rule(String app, String name) {
			this.app = app;
			this.name = name;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (!(obj instanceof Rule))
				return false;
			Rule other = (Rule) obj;
			return Objects.equals(app, other.app) && Objects.equals(name, other.name);
		}

		@Override
		public int hashCode() {
			return Objects.hash(app, name);
		}

		@Override
		public String toString() {
			return "Rule [app=" + app + ", name=" + name + "]";
		}
	}

	private static final Logger logger = LogManager.getFormatterLogger();

	protected final XPathHelper xpath = new XPathHelper();

	protected String build(String threat, Set<String> apps, Set<CavTriple> configs, Set<CavTriple> event, Node xml)
			throws XPathExpressionException {
		Output out = new Output(threat);
		for (String aname : apps) {
			Output.App a = new Output.App(aname);
			a.config.putAll(getAppConfig(aname, xml));
			out.apps.add(a);
		}
		out.events.addAll(event);
		out.config.addAll(configs);

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		return gson.toJson(out);
	}

	public abstract String convert(Graph<String, DefaultEdge> connected, Node xml) throws Exception;

	protected Map<String, Object> getAppConfig(String label, Node xml) throws XPathExpressionException {
		return Streams.stream(xpath.findAll(String.format(
				"//field[@parentID=//sig[contains(atom/@label,'%s') and @parentID=//sig[@label='base/IoTApp']/@ID]/@ID]",
				label), xml)).collect(Collectors.toMap(this::getLabel, this::getValue));
	}

	protected final String[] getAtomLabel2(String lbl1, String lbl2, Node xml) throws XPathExpressionException {
		return xpath.findAllStr(
				String.format("//field[@label='%s']/tuple[atom[1]/@label='%s']/atom[2]/@label", lbl1, lbl2), xml);
	}

	private String getLabel(Node f) {
		return f.getAttributes().getNamedItem("label").getNodeValue();
	}

	protected final Rule getRule(String label, Node xml) throws Exception {
		// get the name of the app and the rule from the label
		Matcher m = Pattern.compile("app_([^\\/]+)\\/(r\\d+)\\$\\d+").matcher(label);
		if (!m.matches())
			throw new Exception("rule label does not match expected pattern: " + label);
		Rule r = new Rule(m.group(1), m.group(2));
		// get the triggers for the rule
		for (String trg : getAtomLabel2("triggers", label, xml)) {
			logger.debug("loading trg: rule=%s, trig=%s", label, trg);
			// get the CAV triple for the trigger
			String[] caps = getAtomLabel2("capabilities", trg, xml);
			logger.debug("found caps: %s", String.join(", ", caps));
			String[] atrs = getAtomLabel2("attribute", trg, xml);
			logger.debug("found atrs: %s", String.join(", ", atrs));
			String[] vals = getAtomLabel2("value", trg, xml);
			logger.debug("found vals: %s", String.join(", ", vals));
			r.trgs.add(new CavTriple(caps[0], atrs[0], vals[0]));
		}
		// get the conditions for the rule
		for (String cnd : getAtomLabel2("conditions", label, xml)) {
			logger.debug("loading cnd: rule=%s, trig=%s", label, cnd);
			// get the CAV triple for the condition
			String[] caps = getAtomLabel2("capabilities", cnd, xml);
			logger.debug("found caps: %s", String.join(", ", caps));
			String[] atrs = getAtomLabel2("attribute", cnd, xml);
			logger.debug("found atrs: %s", String.join(", ", atrs));
			String[] vals = getAtomLabel2("value", cnd, xml);
			logger.debug("found vals: %s", String.join(", ", vals));
			r.cnds.add(new CavTriple(caps[0], atrs[0], vals[0]));
		}
		// get the actions for the rule
		for (String act : getAtomLabel2("commands", label, xml)) {
			logger.debug("loading act: rule=%s, trig=%s", label, act);
			// get the CAV triple for the action
			String[] caps = getAtomLabel2("capability", act, xml);
			logger.debug("found caps: %s", String.join(", ", caps));
			String[] atrs = getAtomLabel2("attribute", act, xml);
			logger.debug("found atrs: %s", String.join(", ", atrs));
			String[] vals = getAtomLabel2("value", act, xml);
			logger.debug("found vals: %s", String.join(", ", vals));
			r.acts.add(new CavTriple(caps[0], atrs[0], vals[0]));
		}
		return r;
	}

	private String getValue(Node f) {
		try {
			return xpath.findStr("tuple/atom[2]/@label", f).replaceAll(".*cap_([^\\$]+)\\$(\\d+)", "$1$2")
					.replaceAll(".*attr_([^\\$]+)\\$\\d+", "$1").replaceAll(".*val_([^\\$]+)\\$\\d+", "$1");
		} catch (XPathExpressionException e) {
			logger.error("bad xpath expression", e);
			return "";
		}
	}

}
