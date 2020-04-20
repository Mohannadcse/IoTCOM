package edu.unl.cse.iotcom;

import edu.mit.csail.sdg.alloy4.Err;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.xml.parsers.ParserConfigurationException;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * Formal analyzer component of IOTCOM.
 *
 * @author Clay Stevens
 */
public final class FormalAnalyzer implements Runnable {

    /**
     * Performs the formal analysis component of IOTCOM.
     *
     * @param args Optional arguments, each requiring a value as the next positional argument:
     *             <p>
     *             --seed [num]             Random seed to use for the random ordering (default: System.currentTimeMillis())
     *             --bundlesizes [num,...]  List of integers specifying the sizes of bundles to analyze (default: 1-20)
     *             --maxsundlesize [num]    Maximum bundle size (default: 20)
     *             --bundle [string,...]    List of app names specifying the bundle. Overrides bundleSizes and maxBundleSize (default: null)
     *             --graph [boolean]        Flag for whether or not to generate graphs (default: false)
     *             --appsdir [path]         Input directory containing the app .als files (default: ./models/apps)
     *             --metadir [path]         Input directory containing the metamodel .als files (default: ./models/meta)
     *             --prplist [string,...]   List of commands to check. If null, checks all commands (default: null)
     *             --template [string]      Name of the template file to use for bundles. See the resources (default: graph_model_template.ftl)
     *             --limit [num]            Maximum number of counterexamples to enumerate (default: 10)
     *             --outdir [path]          Output folder. If null, will generate a timestamped folder in ./out (default: null)
     *             <p>
     *             Example: FormalAnalyzer --seed 293748203 --maxbundlesize 6 --appsdir ./models/apps --prplist t1 --limit 1
     */
    public static void main(String[] args) {
        List<String> arglist = Arrays.asList(args);
        Arguments opts = new Arguments();

        int seedArg = arglist.indexOf("--seed");
        if (seedArg > -1) {
            opts.seed(Long.parseLong(arglist.get(seedArg + 1)));
        }

        int bundleSizesArg = arglist.indexOf("--bundlesizes");
        if (bundleSizesArg > -1) {
            opts.bundleSizes(Arrays.stream(arglist.get(bundleSizesArg + 1).split(",")).map(Integer::parseInt)
                    .collect(Collectors.toList()));
        }

        int maxBundleSizeArg = arglist.indexOf("--maxbundlesize");
        if (maxBundleSizeArg > -1) {
            opts.bundleSizes(IntStream.rangeClosed(1, Integer.parseInt(arglist.get(maxBundleSizeArg + 1))).boxed()
                    .collect(Collectors.toList()));
        }

        int bundleArg = arglist.indexOf("--bundle");
        if (bundleArg > -1) {
            opts.bundle(arglist.get(bundleArg + 1).split(","));
        }

        opts.graph(arglist.indexOf("--graph") > -1);

        int appsDirArg = arglist.indexOf("--appsdir");
        if (appsDirArg > -1) {
            opts.appsDir(Paths.get(arglist.get(appsDirArg + 1)));
        }

        int metaDirArg = arglist.indexOf("--metadir");
        if (metaDirArg > -1) {
            opts.metaDir(Paths.get(arglist.get(metaDirArg + 1)));
        }

        int prpListArg = arglist.indexOf("--prplist");
        if (prpListArg > -1) {
            opts.prplist(arglist.get(prpListArg + 1).split(","));
        }

        int templateArg = arglist.indexOf("--template");
        if (templateArg > -1) {
            opts.template(arglist.get(templateArg + 1));
        }

        int p = arglist.indexOf("--limit");
        if (p > -1) {
            opts.limit(Integer.parseInt(arglist.get(p + 1)));
        }

        int t = arglist.indexOf("--outdir");
        if (t > -1) {
            opts.outdir(Paths.get(arglist.get(t + 1)));
        }

        // run the analyzer with those arguments
        new FormalAnalyzer(opts).run();
    }

    // logger for logging the logs
    private static final Logger logger = LogManager.getFormatterLogger();
    // header format for the output file (not currently used, but kept for reference)
    @SuppressWarnings("unused")
    private static final String LOG_HEADER = "bundle,apps,rules,command,ctrex,solvems%n";
    // entry format for the output file
    private static final String LOG_PATTERN = "%s,%2d,%3d,%6s,%8d,%8d%n";

    // the passed arguments
    private final Arguments arguments;
    // output destination folder (if null in the arguments, will use a timestamped folder)
    private Path outdir;

    /**
     * Creates a new analyzer instance that
     *
     * @param args Analyzer arguments (see the arguments class for a full description)
     */
    public FormalAnalyzer(Arguments args) {
        this.arguments = args;
        this.outdir = this.arguments.getOutdir();
    }

    /**
     * Creates a new, overwriting buffered writer for the path
     */
    private static BufferedWriter createWriter(Path path) throws IOException {
        return Files.newBufferedWriter(path, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
    }

    /**
     * Creates a new appending buffered writer for the path
     */
    private static BufferedWriter appendWriter(Path path) throws IOException {
        return Files.newBufferedWriter(path, StandardOpenOption.CREATE, StandardOpenOption.APPEND);
    }

    /**
     * Inspects the Alloy models in the bundle and counts the "Rule" sigs
     */
    private static int getRuleCountFromBundle(Path tmp, List<String> bundle) {
        int retval = 0;
        // create a regex for the rules
        Pattern regexp = Pattern.compile("^one sig r\\d+ extends r .*$");
        Matcher matcher = regexp.matcher("");
        // open each file in the bundle
        for (String model : bundle) {
            Path file = tmp.resolve("app_" + model + ".als");
            try (BufferedReader reader = Files.newBufferedReader(file)) {
                String line;
                while ((line = reader.readLine()) != null) {
                    matcher.reset(line);
                    if (matcher.find())
                        retval++;
                }
            } catch (IOException e) {
                logger.error("error getting rule count in file: " + file, e);
            }
        }
        return retval;
    }

    @Override
    public void run() {
        try {
            // stage the model files for processing
            final Path tmp = getTempPath();
            // load the freemarker template
            final Template tpl = getTemplate();
            // get a solver
            final AlloySolver solver = new AlloySolver(outdir.toFile(), this.arguments.getLimit(), null);
            try (PrintWriter log = new PrintWriter(appendWriter(outdir.resolve("graph-check.log")))) {
                //log.printf(LOG_HEADER);
                //log.flush();
                for (int j : this.arguments.getBundleSizes()) {
                    solveBundleSize(tmp, tpl, solver, log, j);
                    System.out.flush();
                }
            }
            // generate the graph for our results
            if (this.arguments.isGraph())
                new CounterExampleGrapher(outdir).run();
        } catch (IOException | ParserConfigurationException e) {
            logger.error("error analyzing apps", e);
        }
    }

    /**
     * Solves all bundles of the passed size, in parallel.
     */
    private void solveBundleSize(final Path tmp, final Template tpl, final AlloySolver solver, final PrintWriter log,
                                 final int size)
            throws IOException {
        try (PrintWriter bnd = new PrintWriter(appendWriter(outdir.resolve(String.format("bundles.%d.log", size))))) {
            bnd.printf("BUNDLE GENERATOR SEED: %d%n", this.arguments.getSeed());
            bnd.flush();
            // load up all the connected apps
            final Map<String, Object> data = new HashMap<>();
            final List<List<String>> batches = getBundles(size);
            IntStream.range(0, batches.size()).parallel().forEach((i) -> {
                final String uid = RandomStringUtils.randomAlphabetic(6);
                final List<String> batch = batches.get(i);
                bnd.printf("%s,%s%n", uid, String.join(",", batch));
                bnd.flush();
                solveBatch(tmp, tpl, solver, log, data, batch, uid, size);
            });
        }
    }

    /**
     * Creates and returns a temporary, timestamped folder for output (or the specified folder)
     */
    private Path getTempPath() throws IOException {
        if (this.outdir == null) {
            this.outdir = LatestOutputFolder.create(null, "run");
        }
        final Path tmp = this.outdir.resolve("stage");
        if (!Files.exists(tmp)) {
            //noinspection ResultOfMethodCallIgnored
            tmp.toFile().mkdirs();
            TempModelFolder.stageFiles(tmp, this.arguments.getMetaDir(), this.arguments.getAppsDir());
        }
        return tmp;
    }

    /**
     * Loads the FreeMarker template specified in the arguments
     */
    private Template getTemplate() throws IOException {
        final Configuration cfg = new Configuration(Configuration.VERSION_2_3_28);
        cfg.setClassForTemplateLoading(this.getClass(), "/");
        return cfg.getTemplate(this.arguments.getTemplate());
    }

    /**
     * Solves for a batch of apps. Generates a bundle based on the passed template and data, solves with the passed solver,
     * and writes output to the passed folder.
     */
    private void solveBatch(final Path tmp, final Template tpl, final AlloySolver solver, final PrintWriter log,
                            final Map<String, Object> data, final List<String> batch, final String uid, final int size) {
        data.put("apps", batch);
        final Path model = tmp.resolve(String.format("bundle-%02d.%s.als", size, uid));
        try (BufferedWriter writer = createWriter(model)) {
            tpl.process(data, writer);
            final Map<String, AlloySolver.SolverResult> solutions = solver.getSolutionsForFile(model.toFile(),
                    this.arguments.getPrplist());
            final int ruleCount = getRuleCountFromBundle(tmp, batch);
            for (Map.Entry<String, AlloySolver.SolverResult> r : solutions.entrySet()) {
                final AlloySolver.SolverResult value = r.getValue();
                log.printf(LOG_PATTERN, uid, size, ruleCount, r.getKey(),
                        value.getCounterExampleCount(), value.getSolveTimeMS());
                log.flush();
            }
        } catch (Err | TemplateException | IOException err) {
            logger.error("error solving batch", err);
        }
    }

    /**
     * Returns the list of bundles of the passed size
     */
    private List<List<String>> getBundles(final int size) throws IOException {
        return (this.arguments.getBundle() == null)
                ? Bundler.generateBundle(size, this.arguments.getSeed(), this.arguments.getAppsDir())
                : Collections.singletonList(this.arguments.getBundle());
    }

    /**
     * Builder/argument struct for the formal analyzer class
     */
    @SuppressWarnings({"WeakerAccess", "UnusedReturnValue", "unused"})
    public static class Arguments {

        // output directory (null will be replaced w/ a timestamped folder)
        private Path outdir = null;
        // random seed
        private long seed = System.currentTimeMillis();
        // provided bundle of apps
        private List<String> bundle = null;
        // list of bundle sizes to analyze
        private List<Integer> bundleSizes = IntStream.rangeClosed(1, 20)
                .boxed().collect(Collectors.toList());
        // flag indicating we should generate graphs for counterexamples
        private boolean graph = false;
        // path to the app models
        private Path appsDir = Paths.get("models", "apps");
        // path to the metamodel files
        private Path metaDir = Paths.get("models", "meta");
        // list of commands to check (see the templates in the resources)
        private List<String> prplist = null;
        // template file (from the resources) to use when making bundles
        private String template = "graph_model_template.ftl";
        // counterexample enumeration limit
        private int limit = 10;

        public Path getOutdir() {
            return outdir;
        }

        public Arguments outdir(Path outdir) {
            this.outdir = outdir;
            return this;
        }

        public long getSeed() {
            return seed;
        }

        public Arguments seed(long seed) {
            this.seed = seed;
            return this;
        }

        public List<String> getBundle() {
            return bundle;
        }

        public Arguments bundle(List<String> bundle) {
            this.bundle = bundle;
            this.bundleSizes = Collections.singletonList(this.bundle.size());
            return this;
        }

        public Arguments bundle(String... apps) {
            return this.bundle(Arrays.asList(apps));
        }

        public List<Integer> getBundleSizes() {
            return bundleSizes;
        }

        public Arguments bundleSizes(List<Integer> bundleSizes) {
            this.bundleSizes = bundleSizes;
            return this;
        }

        public Arguments bundleSizes(Integer... bundleSizes) {
            return this.bundleSizes(Arrays.asList(bundleSizes));
        }

        public boolean isGraph() {
            return graph;
        }

        public Arguments graph(boolean graph) {
            this.graph = graph;
            return this;
        }

        public Path getAppsDir() {
            return appsDir;
        }

        public Arguments appsDir(Path appsDir) {
            this.appsDir = appsDir;
            return this;
        }

        public Path getMetaDir() {
            return metaDir;
        }

        public Arguments metaDir(Path metaDir) {
            this.metaDir = metaDir;
            return this;
        }

        public List<String> getPrplist() {
            return prplist;
        }

        public Arguments prplist(List<String> prplist) {
            this.prplist = prplist;
            return this;
        }

        public Arguments prplist(String... prps) {
            return this.prplist(Arrays.asList(prps));
        }

        public String getTemplate() {
            return template;
        }

        public Arguments template(String template) {
            this.template = template;
            return this;
        }

        public int getLimit() {
            return limit;
        }

        public Arguments limit(int limit) {
            this.limit = limit;
            return this;
        }
    }
}
