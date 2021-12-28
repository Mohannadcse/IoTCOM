package edu.unl.cse.iotcom.converters;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jgrapht.Graph;
import org.jgrapht.alg.cycle.DirectedSimpleCycles;
import org.jgrapht.alg.cycle.HawickJamesSimpleCycles;
import org.jgrapht.graph.DefaultEdge;
import org.w3c.dom.Node;

import com.google.common.collect.Sets;

import edu.unl.cse.iotcom.ThreatConverter;

public class T4Converter extends ThreatConverter {

	@Override
	public String convert(Graph<String, DefaultEdge> connected, Node xml) throws Exception {
		// for T4, we have one skolems: r
		String r_ = xpath.findStr("//skolem[@label=\"$t4_r\"]/tuple/atom/@label", xml);
		// we have to find a cycle from r back to r
		DirectedSimpleCycles<String, DefaultEdge> hjsc = new HawickJamesSimpleCycles<>(connected);
		List<List<String>> cycles = hjsc.findSimpleCycles();
		List<String> cycle = cycles.stream().filter(c -> c.contains(r_)).findAny().get();
		List<Rule> cycleRules = new ArrayList<>();
		for (String lbl : cycle) {
			cycleRules.add(getRule(lbl, xml));
		}
		// find the triggering event
		Set<CavTriple> event = Sets.newHashSet(cycleRules.get(0).trgs.stream().findFirst().get());
		// walk the lists of rules and accumulate any conditions that need satisfied
		Set<CavTriple> configs = new HashSet<>();
		Set<CavTriple> altered = new HashSet<>();
		Set<String> apps = new HashSet<>();
		altered.addAll(event);
		cycleRules.stream().forEach(x -> {
			for (CavTriple cnd : x.cnds) {
				if (!configs.contains(cnd) && !altered.contains(cnd)) {
					configs.add(cnd);
				}
			}
			altered.addAll(x.acts);
			apps.add(x.app);
		});

		return build("t4", apps, configs, event, xml);
	}

}
