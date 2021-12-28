package edu.unl.cse.iotcom.converters;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;

import org.jgrapht.Graph;
import org.jgrapht.GraphPath;
import org.jgrapht.alg.shortestpath.DijkstraShortestPath;
import org.jgrapht.graph.DefaultEdge;
import org.w3c.dom.Node;

import com.google.common.collect.Streams;

import edu.unl.cse.iotcom.ThreatConverter;

public class T7Converter extends ThreatConverter {

	@Override
	public String convert(Graph<String, DefaultEdge> connected, Node xml) throws Exception {
		// for T7, we want to find four skolems: a, a', r, and r'
		String a_ = xpath.findStr("//skolem[@label=\"$t7_a\"]/tuple/atom/@label", xml);
		String r_ = xpath.findStr("//skolem[@label=\"$t7_r\"]/tuple/atom/@label", xml);
		String ap = xpath.findStr("//skolem[@label=\"$t7_a'\"]/tuple/atom/@label", xml);
		String rp = xpath.findStr("//skolem[@label=\"$t7_r'\"]/tuple/atom/@label", xml);
		// find the paths between a and r and between a' and r'
		GraphPath<String, DefaultEdge> a_TOr_ = DijkstraShortestPath.findPathBetween(connected, a_, r_);
		List<Rule> a_TOr_Rules = new ArrayList<>();
		for (String lbl : a_TOr_.getVertexList()) {
			a_TOr_Rules.add(getRule(lbl, xml));
		}
		GraphPath<String, DefaultEdge> apTOrp = DijkstraShortestPath.findPathBetween(connected, ap, rp);
		List<Rule> apTOrpRules = new ArrayList<>();
		for (String lbl : apTOrp.getVertexList()) {
			apTOrpRules.add(getRule(lbl, xml));
		}
		// find the conflicting triggers from a and a'
		Set<CavTriple> conflict = new HashSet<>();
		outer: for (CavTriple a_trig : a_TOr_Rules.get(0).trgs) {
			for (CavTriple aptrig : apTOrpRules.get(0).trgs) {
				if (Objects.equals(a_trig.cap, aptrig.cap) && Objects.equals(a_trig.atr, aptrig.atr)
						&& !Objects.equals(a_trig.val, aptrig.val)) {
					conflict.add(a_trig);
					conflict.add(aptrig);
					break outer;
				}
			}
		}
		// walk the lists of rules and accumulate any conditions that need satisfied
		Set<CavTriple> configs = new HashSet<>();
		Set<CavTriple> altered = new HashSet<>();
		Set<String> apps = new HashSet<>();
		altered.addAll(conflict);
		Streams.concat(a_TOr_Rules.stream(), apTOrpRules.stream()).forEach(x -> {
			for (CavTriple cnd : x.cnds) {
				if (!configs.contains(cnd) && !altered.contains(cnd)) {
					configs.add(cnd);
				}
			}
			altered.addAll(x.acts);
			apps.add(x.app);
		});

		return build("t7", apps, configs, conflict, xml);
	}

}
