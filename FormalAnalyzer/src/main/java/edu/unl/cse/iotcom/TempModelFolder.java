package edu.unl.cse.iotcom;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;

/**
 * Helper class for IOTCOM to stage all the metamodel and app files to the same temporary folder.
 *
 * @author Clay Stevens
 */
public final class TempModelFolder {

    /**
     * Stages model files for analysis. Alloy does not handle nested folder structures very well,
     * so this class copies the metamodel, the policies, and the apps all into the same place.
     *
     * @param args Optional arguments, each requiring a value as the next positional argument:
     *             <p>
     *             --prefix [string]       Prefix added to the default dated output folder name (default: run)
     *             --outdir [path]         Staging output directory (default: ./out/run[datetime]/stage)
     *             --metadir [path]        Input directory for the metamodel .als files (default: ./models/meta)
     *             --appsdir [path]        Input directory for the app .als files (default: ./models/apps)
     *             <p>
     *             Example: TempModelFolder --outdir ./out/stage --metadir ./models/meta --appsdir ./models/apps
     */
    @SuppressWarnings("Duplicates")
    public static void main(String[] args) {
        try {
            List<String> arglist = Arrays.asList(args);

            String prefix = "run";
            int prefArg = arglist.indexOf("--prefix");
            if (prefArg > -1)
                prefix = arglist.get(prefArg + 1);

            Path outdir = LatestOutputFolder.create(Paths.get("out"), prefix).resolve("stage");
            int outArg = arglist.indexOf("--outdir");
            if (outArg > -1)
                outdir = Paths.get(arglist.get(outArg + 1));

            Path metaDir = Paths.get("models", "meta");
            int metaArg = arglist.indexOf("--metadir");
            if (metaArg > -1)
                metaDir = Paths.get(arglist.get(metaArg + 1));

            Path appsDir = Paths.get("models", "apps");
            int appsArg = arglist.indexOf("--appsdir");
            if (appsArg > -1)
                appsDir = Paths.get(arglist.get(appsArg + 1));

            // stage the files based on the passed arguments
            TempModelFolder.stageFiles(outdir, metaDir, appsDir);
            // NOTE: this is NOT a logging statement, we need this output
            System.out.println(outdir.toAbsolutePath());
        } catch (IOException e) {
            logger.error("error staging temp folder", e);
        }
    }

    // logger for logging the logs
    private static final Logger logger = LogManager.getFormatterLogger();

    /**
     * Stages the passed metamodel, policy, and app models files to the passed output directory. Will only
     * stage *.als files.
     *
     * @param outdir  Destination folder
     * @param metadir Metamodel folder
     * @param appsdir App folder
     * @throws IOException Some issue with the files
     */
    static void stageFiles(final Path outdir, final Path metadir, final Path appsdir)
            throws IOException {
        stageFileSet(Files.list(metadir), outdir, "");
        stageFileSet(Files.list(appsdir), outdir, "app_");
    }

    /**
     * Stages a particular steam of files to the passed destination, prepending the staged
     * filenames with the passed prefix and filtering files to only *.als files
     *
     * @param src    Stream of input files to stage
     * @param dst    Destination folder
     * @param prefix Prepended string
     */
    static void stageFileSet(final Stream<Path> src, final Path dst, final String prefix) {
        src.filter(FileSystems.getDefault().getPathMatcher("glob:**.als")::matches).forEach(p -> {
            Path name = dst.resolve(prefix + p.getFileName().toString()
                    .replace("-", "_")
                    .replace("+", ""));
            try {
                if (!Files.exists(name))
                    Files.copy(p, name);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
}
