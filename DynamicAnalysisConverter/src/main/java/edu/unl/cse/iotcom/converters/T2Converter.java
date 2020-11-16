package edu.unl.cse.iotcom.converters;

import java.util.HashSet;
import java.util.Set;

import org.jgrapht.Graph;
import org.jgrapht.graph.DefaultEdge;
import org.w3c.dom.Node;

import com.google.common.collect.Sets;

import edu.unl.cse.iotcom.ThreatConverter;

public class T2Converter extends ThreatConverter {

	@Override
	public String convert(Graph<String, DefaultEdge> connected, Node xml) throws Exception {
		// for T2, we have two skolems: r and r'
		String r_ = xpath.findStr("//skolem[@label=\"$t2_r\"]/tuple/atom/@label", xml);
		String rp = xpath.findStr("//skolem[@label=\"$t2_r'\"]/tuple/atom/@label", xml);
		// they are connected by a single step, so no path necessary
		Rule r_rule = getRule(r_, xml);
		Rule rprule = getRule(rp, xml);
		// find the trigger that a and a' have in common (the triggering event)
		Set<CavTriple> event = Sets.newHashSet(r_rule.trgs.stream().findFirst().get());
		// walk the lists of rules and accumulate any conditions that need satisfied
		Set<CavTriple> configs = new HashSet<>();
		Set<String> apps = new HashSet<>();

		configs.addAll(r_rule.cnds);
		apps.add(r_rule.app);
		apps.add(rprule.app);

		return build("t2", apps, configs, event, xml);
	}

}
