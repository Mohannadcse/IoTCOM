package edu.unl.cse.iotcom;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.io.IOException;
import java.nio.file.*;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class FormalAnalyzerTest {

    @Test
    void testRunWithGraphs(@TempDir Path outdir) throws IOException, InterruptedException {
        PathMatcher xmlMatcher = FileSystems.getDefault().getPathMatcher("glob:**.xml");
        PathMatcher dotMatcher = FileSystems.getDefault().getPathMatcher("glob:**.dot");

        FormalAnalyzer.Arguments opts = new FormalAnalyzer.Arguments()
                .outdir(outdir)
                .seed(1587400397957L)
                .bundleSizes(3)
                .appsDir(Paths.get("models", "test"))
                .prplist("t1")
                .limit(10)
                .graph(true);
        FormalAnalyzer uut = new FormalAnalyzer(opts);
        uut.run();

        Path bundles = outdir.resolve("bundles.3.log");
        assertTrue(Files.exists(bundles));

        Path graphCheck = outdir.resolve("graph-check.log");
        assertTrue(Files.exists(graphCheck));

        assertEquals(7, Files.lines(bundles).count());
        assertEquals(6, Files.lines(graphCheck).count());
        assertEquals(14, Files.list(outdir).filter(xmlMatcher::matches).count());
        assertEquals(14, Files.list(outdir).filter(dotMatcher::matches).count());
    }
}