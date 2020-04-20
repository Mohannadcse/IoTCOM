package edu.unl.cse.iotcom;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jgrapht.Graph;
import org.jgrapht.GraphPath;
import org.jgrapht.alg.connectivity.KosarajuStrongConnectivityInspector;
import org.jgrapht.alg.interfaces.StrongConnectivityAlgorithm;
import org.jgrapht.alg.shortestpath.DijkstraShortestPath;
import org.jgrapht.graph.DefaultDirectedGraph;
import org.jgrapht.io.*;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import java.util.function.Consumer;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

/**
 * Generates Graphviz graphs for Alloy solution XML files output by IOTCOM
 *
 * @author Clay Stevens
 */
public class CounterExampleGrapher implements Runnable {

    /**
     * Generates Graphviz graphs from the solutions in the passed folder.
     * <p>
     * Usage: CounterExampleGrapher path/to/solutions
     */
    public static void main(String[] args) {
        try {
            if (args.length == 0)
                new CounterExampleGrapher(Paths.get(".", "out", "latest")).run();
            else
                new CounterExampleGrapher(Paths.get(args[0])).run();
        } catch (ParserConfigurationException e) {
            logger.error("parsing error while making graphs", e);
        }
    }

    /**
     * Logger for logging the logs
     */
    private static final Logger logger = LogManager.getFormatterLogger();

    /**
     * Map of vertex id Strings to vertices (for easy annotation later)
     */
    private static final HashMap<String, Vertex> vertices = new HashMap<>();

    /**
     * List of assertion names. Each skolem is named specifically for the assertion
     * checked in the Alloy output, so we need to loop through these names to match
     * the file to the skolem tag that we later examine to color the nodes in the
     * graphs.
     */
    private final List<String> assertions = Stream.concat(
            IntStream.rangeClosed(1, 7).mapToObj(i -> String.format("t%d", i)), // general
            IntStream.rangeClosed(1, 29).mapToObj(i -> String.format("P%d", i)) // specific
    ).collect(Collectors.toList());

    /**
     * XML document builder (for XPATH)
     */
    private final DocumentBuilder builder;
    /**
     * Output directory
     */
    private final Path outdir;
    /**
     * Shared XPATH object
     */
    private final XPath xPath;

    /**
     * Creates a new grapher instance
     */
    CounterExampleGrapher(Path outdir) throws ParserConfigurationException {
        this.outdir = outdir;
        this.builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        this.xPath = XPathFactory.newInstance().newXPath();
    }

    /**
     * Looks up a vertex by key string in the map of vertices, adding it if it
     * doesn't already exist.
     */
    private static Vertex getVertex(String key) {
        if (key == null || "".equals(key))
            return null;
        if (!vertices.containsKey(key))
            vertices.put(key, new Vertex(key));
        return vertices.get(key);
    }

    @Override
    public void run() {
        try {
            // a graphviz exporter, for later
            final GraphExporter<Vertex, Edge> exporter = new DOTExporter<>(new IntegerComponentNameProvider<>(),
                    new StringComponentNameProvider<>(), null, new VertexStyler(), new EdgeStyler());
            // loop through each of the assertions, both the general and the specific
            for (String a : assertions) {
                // read each XML file from the source dir in sequence based on the
                // name of the assertion
                final PathMatcher matcher = FileSystems.getDefault()
                        .getPathMatcher(String.format("glob:**/*%s*.xml", a));
                final List<Path> files = Files.list(outdir)
                        .filter(matcher::matches)
                        .collect(Collectors.toList());
                for (Path file : files) {
                    // make a new graph and clear the id->vertex map
                    final Graph<Vertex, Edge> graph = new DefaultDirectedGraph<>(Edge.class);
                    vertices.clear();
                    // read the Alloy XML output file (for XPATH parsing)
                    final Document xml = builder.parse(file.toFile());
                    // find all the Rule instances and add them as vertices
                    addRulesToGraph(graph, xml);
                    // update the specific skolems used in the general rules:
                    //   - r and r' are the free variables used to represent the rules that
                    //     exhibit each violation
                    //   - if they are linked by descent to the initiating event, a and a'
                    //     are the ancestors of r and r', respectively
                    // if other assertions have different skolems, then they will also need
                    // to be added here, too (or somewhere nearby) if the graph is to be
                    // annotated to display those rules any differently than the plain
                    // white ones.
                    final Vertex r0 = updateVertexes(a, "r", xml, v -> v.violator = true);
                    final Vertex a0 = updateVertexes(a, "a", xml, v -> v.ancestor = true);
                    final Vertex rp = updateVertexes(a, "r'", xml, v -> v.violated = true);
                    final Vertex ap = updateVertexes(a, "a'", xml, v -> v.ancestor = true);
                    // add edges representing connections, including scheduled, indirect and
                    // direct descent
                    addConnectionsToGraph(graph, xml);
                    // check to see if the violation itself involved any indirect connections,
                    // either between the violator and violated or between those two and either
                    // ancestor (just in case). adds "indirect" to the file name if so.
                    String marker = "";
                    if (checkIndirectViolation(graph, Pair.of(r0, rp), Pair.of(a0, r0), Pair.of(ap, rp), Pair.of(a0, rp), Pair.of(ap, r0)))
                        marker = "indirect.";
                    // output the resulting .dot file for graphviz
                    final String basename = FilenameUtils.removeExtension(file.getFileName().toString());
                    try (BufferedWriter writer = Files.newBufferedWriter(outdir.resolve(String.format("%s.%sdot", basename, marker)),
                            StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING)) {
                        exporter.exportGraph(graph, writer);
                    }
                }
            }
        } catch (IOException | ExportException | SAXException e) {
            logger.error("exception while generating graphs", e);
        }
    }

    /**
     * Looks up the Rule atoms in the passed Alloy XML output and adds each
     * as a vertex to the passed graph.
     */
    private void addRulesToGraph(final Graph<Vertex, Edge> graph, final Document xml) {
        try {
            final NodeList rules = (NodeList) xPath.compile("//field[@label='rules']/tuple/atom[2]/@label")
                    .evaluate(xml, XPathConstants.NODESET);
            for (int i = 0; i < rules.getLength(); ++i) {
                final Vertex v = getVertex(rules.item(i).getNodeValue());
                if (v != null) graph.addVertex(v);
            }
        } catch (XPathExpressionException e) {
            logger.error("XPATH error while adding rules", e);
        }
    }

    /**
     * Invokes the passed lambda function on the vertex corresponding to the Rule atom
     * matching the passed free variable name (Skolem) in the passed assertion, if
     * such an atom can be found in the passed Alloy XML output. Also returns that
     * vertex, or null if not found.
     */
    private Vertex updateVertexes(final String assertion, final String skolem, final Document xml,
                                  final Consumer<Vertex> lambda) {
        try {
            final String expression = String.format("//skolem[@label=\"$%s_%s\"]/tuple/atom/@label", assertion, skolem);
            final Vertex x = getVertex((String) xPath.compile(expression)
                    .evaluate(xml, XPathConstants.STRING));
            if (x != null) {
                lambda.accept(x);
                return x;
            }
        } catch (XPathExpressionException e) {
            logger.error("XPATH error while updating vertices", e);
        }
        return null;
    }

    /**
     * Adds all the scheduled, direct and indirect descent relations in the passed
     * Alloy XML output as edges in the passed graph. Assumes all the Rule atoms
     * from the XML are already present as vertices in the graph.
     */
    private void addConnectionsToGraph(final Graph<Vertex, Edge> graph, final Document xml) {
        try {
            // add an edge for each connection, be it scheduled, direct, or indirect
            final NodeList tuples = (NodeList) xPath.compile("//field[@label='connected']/tuple")
                    .evaluate(xml, XPathConstants.NODESET);
            for (int i = 0; i < tuples.getLength(); ++i) {
                final Pair<Vertex, Vertex> tuple = getVertexes(tuples.item(i));
                final Vertex src = tuple.getLeft();
                final Vertex dst = tuple.getRight();
                // don't add edges for any self loops, that makes it look messy
                if (!Objects.equals(src.key, dst.key)) {
                    // don't add any duplicates
                    if (!graph.containsEdge(src, dst)) {
                        graph.addEdge(src, dst, new Edge());
                    }
                }
            }
            // for the indirect connections, find the edge (added above) and set
            // the indirect flag on it
            final NodeList indirect = (NodeList) xPath.compile("//field[@label='indirect']/tuple")
                    .evaluate(xml, XPathConstants.NODESET);
            for (int j = 0; j < indirect.getLength(); ++j) {
                final Edge e = lookupEdge(graph, indirect.item(j));
                if (e != null) e.indirect = true;
            }
            // for the scheduled connections, find the edge (added above) and set
            // the scheduled flag on it
            final NodeList scheduled = (NodeList) xPath.compile("//field[@label='scheduled']/tuple")
                    .evaluate(xml, XPathConstants.NODESET);
            for (int k = 0; k < scheduled.getLength(); ++k) {
                final Edge e = lookupEdge(graph, scheduled.item(k));
                if (e != null) e.scheduled = true;
            }
            // if there are any strongly connected sets (cycles) mark those as well,
            // just for fun
            final StrongConnectivityAlgorithm<Vertex, Edge> sca = new KosarajuStrongConnectivityInspector<>(graph);
            for (Set<Vertex> scc : sca.stronglyConnectedSets()) {
                if (scc.size() > 1) {
                    for (Vertex v : scc)
                        v.scc = true;
                }
            }
        } catch (XPathExpressionException e) {
            logger.error("XPATH error while adding connections", e);
        }
    }

    /**
     * Returns the edge in the passed graph between the two Rule atoms in the
     * passed XPATH node, if there is one and returns null if not.
     */
    private Edge lookupEdge(final Graph<Vertex, Edge> graph, Node node) throws XPathExpressionException {
        final Pair<Vertex, Vertex> tuple = getVertexes(node);
        final Vertex src = tuple.getLeft();
        final Vertex dst = tuple.getRight();
        return graph.getEdge(src, dst);
    }

    /**
     * Returns the pair of vertices corresponding to the Rule atoms in
     * the passed XPATH node.
     */
    private Pair<Vertex, Vertex> getVertexes(final Node tuple) throws XPathExpressionException {
        final Vertex src = getVertex((String) xPath.compile("atom[1]/@label")
                .evaluate(tuple, XPathConstants.STRING));
        final Vertex dst = getVertex((String) xPath.compile("atom[2]/@label")
                .evaluate(tuple, XPathConstants.STRING));
        return Pair.of(src, dst);
    }

    /**
     * Checks to see if any of the passed pair are connected (left to right)
     * by a path passing through an indirect edge.
     */
    @SafeVarargs
    private final boolean checkIndirectViolation(final Graph<Vertex, Edge> graph, final Pair<Vertex, Vertex>... pairs) {
        for (Pair<Vertex, Vertex> p : pairs) {
            if (p.getLeft() == null || p.getRight() == null)
                continue;
            final GraphPath<Vertex, Edge> path = DijkstraShortestPath.findPathBetween(graph, p.getLeft(), p.getRight());
            if (path == null)
                continue;
            for (Edge e : path.getEdgeList())
                if (!e.scheduled && e.indirect) return true;
        }
        return false;
    }

    /**
     * Custom vertex class, containing our annotations for ancestry and
     * marking the violating Rules. If you need any extra colors or
     * annotations, add the markers/data for them here.
     */
    final static class Vertex {
        private final String key;
        private boolean scc;
        private boolean ancestor;
        private boolean violator;
        private boolean violated;

        private Vertex(String key) {
            this.key = key;
        }

        @Override
        public int hashCode() {
            return key.hashCode();
        }

        @Override
        public boolean equals(Object obj) {
            return (obj instanceof Vertex) && (key.equals(((Vertex) obj).key));
        }

        @Override
        public String toString() {
            return key;
        }
    }

    /**
     * Vertex styler for the graphviz graph that interprets the markers/data
     * in the custom vertex class and converts them to graphviz attributes.
     * This is where the colors, shapes, etc. would go.
     */
    final class VertexStyler implements ComponentAttributeProvider<Vertex> {
        @Override
        public Map<String, Attribute> getComponentAttributes(Vertex component) {
            final Map<String, Attribute> map = new LinkedHashMap<>();
            if (component.scc) {
                map.put("style", DefaultAttribute.createAttribute("filled"));
                map.put("fillcolor", DefaultAttribute.createAttribute("Wheat"));
            }
            if (component.ancestor) {
                map.put("style", DefaultAttribute.createAttribute("filled"));
                map.put("fillcolor", DefaultAttribute.createAttribute("Gray"));
            }
            if (component.violator) {
                map.put("style", DefaultAttribute.createAttribute("filled"));
                map.put("fillcolor", DefaultAttribute.createAttribute("LightSkyBlue"));
            }
            if (component.violated) {
                map.put("style", DefaultAttribute.createAttribute("filled"));
                map.put("fillcolor", DefaultAttribute.createAttribute("SeaGreen1"));
            }
            return map;
        }
    }

    /**
     * Custom edge class, containing markers for how to style the edges.
     */
    final class Edge {
        private boolean indirect;
        private boolean scheduled;
    }

    /**
     * Edge styler for the graphviz graph that interprets the markers/data
     * in the custom edge class and converts them to graphviz attributes.
     * This is where the colors, shapes, etc. would go.
     */
    final class EdgeStyler implements ComponentAttributeProvider<Edge> {
        @Override
        public Map<String, Attribute> getComponentAttributes(Edge component) {
            final Map<String, Attribute> map = new LinkedHashMap<>();
            if (component.scheduled) {
                map.put("penwidth", DefaultAttribute.createAttribute(3.0));
                map.put("color", DefaultAttribute.createAttribute("Red"));
            } else if (component.indirect) {
                map.put("style", DefaultAttribute.createAttribute("dashed"));
            }
            return map;
        }
    }
}
