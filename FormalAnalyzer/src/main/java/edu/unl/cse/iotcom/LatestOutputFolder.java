package edu.unl.cse.iotcom;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Helper class to generate timestamped output folders for IOTCOM
 *
 * @author Clay Stevens
 */
final class LatestOutputFolder {

    /**
     * Creates a new timestamped folder based in the passed path with the passed prefix, and generates
     * a symlink in the base called pointing to the latest such timestamped folder.
     *
     * @param base   Base path (defaults to "./out")
     * @param prefix String to prepend to the timestamp (default "run")
     * @return Created path
     * @throws IOException Error creating file structure
     */
    static Path create(Path base, final String prefix) throws IOException {
        if (base == null)
            base = Paths.get("out");
        // create a new results directory
        final String dirname = String.format("%s_%s", prefix, (new SimpleDateFormat("yyyyMMdd_HHmmss")).format(new Date()));
        final Path output = base.resolve(dirname);
        Files.createDirectories(output);
        // recreate the symlink to latest
        final Path link = base.resolve("latest");
        Files.deleteIfExists(link);
        Files.createSymbolicLink(link.toAbsolutePath(), output.toAbsolutePath());
        return output;
    }

}
