package edu.unl.cse.iotcom;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.AbstractMap;
import java.util.AbstractMap.SimpleEntry;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jgrapht.Graph;
import org.jgrapht.graph.DefaultDirectedGraph;
import org.jgrapht.graph.DefaultEdge;
import org.w3c.dom.Document;
import org.w3c.dom.Node;

import com.google.common.io.Files;

import edu.unl.cse.iotcom.converters.*;

public class ConverterApp {

	private static final Map<String, ? extends ThreatConverter> converters = Stream
			.of(new AbstractMap.SimpleEntry<>("t1", new T1Converter()),
					new AbstractMap.SimpleEntry<>("t2", new T2Converter()),
					new AbstractMap.SimpleEntry<>("t3", new T3Converter()),
					new AbstractMap.SimpleEntry<>("t4", new T4Converter()),
					new AbstractMap.SimpleEntry<>("t5", new T5Converter()),
					new AbstractMap.SimpleEntry<>("t6", new T6Converter()),
					new AbstractMap.SimpleEntry<>("t7", new T7Converter()),
					new AbstractMap.SimpleEntry<>("P1", new P1Converter()),
					new AbstractMap.SimpleEntry<>("P2", new P2Converter()),
					new AbstractMap.SimpleEntry<>("P3", new P3Converter()),
					new AbstractMap.SimpleEntry<>("P4", new P4Converter()),
					new AbstractMap.SimpleEntry<>("P5", new P5Converter()),
					new AbstractMap.SimpleEntry<>("P6", new P6Converter()),
					new AbstractMap.SimpleEntry<>("P7", new P7Converter()),
					new AbstractMap.SimpleEntry<>("P8", new P8Converter()),
					new AbstractMap.SimpleEntry<>("P9", new P9Converter()),
					new AbstractMap.SimpleEntry<>("P10", new P10Converter()),
					new AbstractMap.SimpleEntry<>("P11", new P11Converter()),
					new AbstractMap.SimpleEntry<>("P12", new P12Converter()),
					new AbstractMap.SimpleEntry<>("P13", new P13Converter()),
					new AbstractMap.SimpleEntry<>("P14", new P14Converter()),
					new AbstractMap.SimpleEntry<>("P15", new P15Converter()),
					new AbstractMap.SimpleEntry<>("P16", new P16Converter()),
					new AbstractMap.SimpleEntry<>("P17", new P17Converter()),
					new AbstractMap.SimpleEntry<>("P18", new P18Converter()),
					new AbstractMap.SimpleEntry<>("P19", new P19Converter()),
					new AbstractMap.SimpleEntry<>("P20", new P20Converter()),
					new AbstractMap.SimpleEntry<>("P21", new P21Converter()),
					new AbstractMap.SimpleEntry<>("P22", new P22Converter()),
					new AbstractMap.SimpleEntry<>("P23", new P23Converter()),
					new AbstractMap.SimpleEntry<>("P24", new P24Converter()),
					new AbstractMap.SimpleEntry<>("P25", new P25Converter()),
					new AbstractMap.SimpleEntry<>("P26", new P26Converter()),
					new AbstractMap.SimpleEntry<>("P27", new P27Converter()),
					new AbstractMap.SimpleEntry<>("P28", new P28Converter()),
					new AbstractMap.SimpleEntry<>("P29", new P29Converter()))
			.collect(Collectors.toMap(SimpleEntry::getKey, SimpleEntry::getValue));

	private static final Logger logger = LogManager.getFormatterLogger();

	public static void main(String[] args) {
		try {
			Path filepath = Paths.get(args[0]);
			ConverterApp conv = new ConverterApp(filepath);
			// convert it
			String json = conv.convertToJson();
			// write to output file
			Files.write(json.getBytes(), filepath.resolveSibling(filepath.getFileName() + ".json").toFile());
		} catch (Exception e) {
			logger.error("unexpected error", e);
		}
	}

	private final Path filename;
	private final XPathHelper xpath;

	public ConverterApp(Path filename) {
		this.filename = filename;
		this.xpath = new XPathHelper();
	}

	public String convertToJson() throws Exception {
		logger.info("beginning conversion for dynamic analysis: %s", this.filename);
		// open the file as an xml document
		Document xml = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(this.filename.toFile());
		// start by getting the command, which will drive all the rest of the conversion
		String cmd = xpath.findStr("//instance/@command", xml).replaceAll("Check (\\S*)", "$1");
		logger.info("threat found: %s", cmd);
		// build a graph of the connected rules
		Graph<String, DefaultEdge> connected = new DefaultDirectedGraph<String, DefaultEdge>(DefaultEdge.class);
		for (Node tuple : xpath.findAll("//field[@label='connected']/tuple", xml)) {
			String r0 = xpath.findStr("atom[1]/@label", tuple);
			String r1 = xpath.findStr("atom[2]/@label", tuple);
			connected.addVertex(r0);
			connected.addVertex(r1);
			logger.debug("adding edge: %s -> %s", r0, r1);
			connected.addEdge(r0, r1);
		}
		// dispatch based on the command
		String json = converters.get(cmd).convert(connected, xml);
		logger.info("finishing conversion: %s", json);
		return json;
	}
}
