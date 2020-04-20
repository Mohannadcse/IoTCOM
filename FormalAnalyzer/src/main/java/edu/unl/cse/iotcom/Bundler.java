package edu.unl.cse.iotcom;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Iterators;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.*;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

/**
 * Generates bundles of apps for IOTCOM's formal analysis
 *
 * @author Clay Stevens
 */
public final class Bundler {

    /**
     * Generates bundles of models based on the files in the passed directories and writes
     * them to the configured log file.
     *
     * @param args Optional arguments, each requiring a value as the next positional argument:
     *             <p>
     *             --size [num]       Size of the bundles to create (default: 6)
     *             --seed [num]       Random seed to use for the random ordering (default: System.currentTimeMillis())
     *             --outfile [path]   Output file path (default: ./bundles.[size].log
     *             --appsdir [path]   Input directory containing the app .als files (default: ./models/apps)
     *             <p>
     *             Example: Bundler --size 6 --seed 293748203 --outfile ./bundles.6.log --appsdir ./models/apps
     */
    @SuppressWarnings("Duplicates")
    public static void main(String[] args) {
        List<String> argList = Arrays.asList(args);

        int size = 6;
        int sizeArg = argList.indexOf("--size");
        if (sizeArg > -1)
            size = Integer.parseInt(argList.get(sizeArg + 1));

        long seed = System.currentTimeMillis();
        int seedArg = argList.indexOf("--seed");
        if (seedArg > -1)
            seed = Long.parseLong(argList.get(seedArg + 1));

        Path outfile = Paths.get(String.format("bundles.%d.log", size));
        int fileArg = argList.indexOf("--outfile");
        if (fileArg > -1)
            outfile = Paths.get(argList.get(fileArg + 1));

        Path appsdir = Paths.get("models", "apps");
        int appsArg = argList.indexOf("--appsdir");
        if (appsArg > -1)
            appsdir = Paths.get(argList.get(appsArg + 1));

        // write the bundle (and seed) to the chosen outfile
        try (PrintWriter bnd = new PrintWriter(Files.newBufferedWriter(outfile,
                StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING))) {
            bnd.printf("BUNDLE GENERATOR SEED: %d%n", seed);
            bnd.flush();
            for (List<String> batch : generateBundle(size, seed, appsdir)) {
                String uid = RandomStringUtils.randomAlphabetic(6);
                bnd.printf("%s,%s%n", uid, String.join(",", batch));
                bnd.flush();
            }
        } catch (IOException e) {
            logger.error("error generating bundles", e);
        }
    }

    // logger for logging the logs
    private static final Logger logger = LogManager.getFormatterLogger();
    // path matcher to ensure we bundle .als files
    private static final PathMatcher alsFileMatcher = FileSystems.getDefault()
            .getPathMatcher("glob:**.als");

    /**
     * Generates a list of bundles of the passed size of apps from the files at the passed path,
     * randomized using the passed seed.
     *
     * @param size    Number of files to include in each bundle
     * @param seed    Random seed
     * @param appsDir Path to bundle (.als) files from
     * @return List of bundles of app names of at most the passed size
     * @throws IOException Files in the passed path cannot be listed
     */
    static List<List<String>> generateBundle(final int size, final long seed, final Path appsDir)
            throws IOException {
        final List<String> appNames = Files.list(appsDir)
                .filter(alsFileMatcher::matches)
                .map(p -> p.getFileName().toString()
                        .substring(0, p.getFileName().toString().indexOf("."))
                        .replace("-", "_")
                        .replace("+", ""))
                .filter(f -> !f.isEmpty())
                .collect(Collectors.toList());
        Collections.shuffle(appNames, new Random(seed));
        return ImmutableList.copyOf(Iterators.partition(appNames.iterator(), size));
    }
}
