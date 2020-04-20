package edu.unl.cse.iotcom;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.alloy4.ErrorSyntax;
import edu.mit.csail.sdg.alloy4compiler.ast.Command;
import edu.mit.csail.sdg.alloy4compiler.ast.Module;
import edu.mit.csail.sdg.alloy4compiler.parser.CompUtil;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Options;
import edu.mit.csail.sdg.alloy4compiler.translator.TranslateAlloyToKodkod;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Stream;

/**
 * Tests collections of IoT app models against the IOTCOM metamodel to make sure they compile
 *
 * @author Clay Stevens
 */
public final class AppTester {

    /**
     * Tests Alloy app models to make sure they compile with our metamodel. Logs output to Log4J.
     *
     * @param args Optional arguments, each requiring a value as the next positional argument:
     *             <p>
     *             --outdir [path]         Output directory (default: ./models/compiling)
     *             --metadir [path]        Input directory for the metamodel .als files (default: ./models/meta)
     *             --appsdir [path]        Input directory for the app .als files (default: ./models/apps)
     *             <p>
     *             Example: AppTester --outdir ./out/compiling --metadir ./models/meta --appsdir ./models/apps
     */
    @SuppressWarnings({"Duplicates", "PlaceholderCountMatchesArgumentCount"})
    public static void main(String[] args) {
        List<String> arglist = Arrays.asList(args);

        Path outdir = Paths.get("models", "compiling");
        int outarg = arglist.indexOf("--outdir");
        if (outarg > -1)
            outdir = Paths.get(arglist.get(outarg + 1));

        Path metadir = Paths.get("models", "meta");
        int metaarg = arglist.indexOf("--metadir");
        if (metaarg > -1)
            metadir = Paths.get(arglist.get(metaarg + 1));

        Path appsdir = Paths.get("models", "apps");
        int appsarg = arglist.indexOf("--appsdir");
        if (appsarg > -1)
            appsdir = Paths.get(arglist.get(appsarg + 1));

        try {
            Pair<Integer, Integer> result = AppTester.parseFiles(outdir, metadir, appsdir);
            logger.info("summary: %d ok, %d fail", result.getLeft(), result.getRight());
        } catch (IOException | Err e) {
            logger.error("error during parsing", e);
        }
    }

    // logger for logging the logs
    private static final Logger logger = LogManager.getFormatterLogger();

    /**
     * Tests the app models in the passed app directory against the metamodel in the passed metamodel
     * path, writing the apps that actually compile to the passed output directory. Results are logged
     * to Log4j.
     *
     * @param outdir  Output directory for compiling apps
     * @param metadir Metamodel directory
     * @param appsdir App model directory
     * @return Ordered pair indicating number of passed and failed apps, respectively
     * @throws IOException Some issue with the files
     * @throws Err         Some issue with the Alloy execution
     */
    @SuppressWarnings({"PlaceholderCountMatchesArgumentCount", "ResultOfMethodCallIgnored"})
    static Pair<Integer, Integer> parseFiles(final Path outdir, final Path metadir, final Path appsdir)
            throws IOException, Err {
        final Path tmp = outdir.resolve("stage");
        tmp.toFile().mkdirs();
        try {
            TempModelFolder.stageFileSet(Files.list(metadir), tmp, "");

            final A4Options opt = new A4Options();
            opt.solver = A4Options.SatSolver.SAT4J;

            int pass = 0;
            int fail = 0;

            final Iterator<Path> it = Files.list(appsdir).iterator();
            while (it.hasNext()) {
                final Path appfile = it.next();
                final Path staged = Files.copy(appfile, tmp.resolve(appfile.getFileName()));
                try {
                    final Module module = CompUtil.parseEverything_fromFile(A4Reporter.NOP, null, staged.toAbsolutePath().toString());
                    final Command cmd = new Command(false, 1, 1, 0, module.parseOneExpressionFromString("{ }"));
                    TranslateAlloyToKodkod.execute_command(A4Reporter.NOP, module.getAllReachableSigs(), cmd, opt);
                    logger.info("(PASS) %s", appfile.toAbsolutePath());
                    Files.copy(appfile, outdir.resolve(appfile.getFileName()));
                    pass++;
                } catch (ErrorSyntax es) {
                    logger.info("(FAIL) %s", appfile.toAbsolutePath());
                    logger.info("  Syntax error at line %d column %d", es.pos.y, es.pos.x);
                    logger.info("  %s", es.getMessage());
                    fail++;
                }
            }
            return Pair.of(pass, fail);
        } finally {
            try (Stream<Path> walk = Files.walk(tmp)) {
                walk.sorted(Comparator.reverseOrder())
                        .map(Path::toFile)
                        .forEach(File::delete);
            }
            final Path symlink = outdir.resolve("latest");
            if (Files.exists(symlink))
                symlink.toFile().delete();
        }
    }
}
