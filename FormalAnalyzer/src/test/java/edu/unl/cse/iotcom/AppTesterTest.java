package edu.unl.cse.iotcom;

import edu.mit.csail.sdg.alloy4.Err;
import org.apache.commons.lang3.tuple.Pair;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;

class AppTesterTest {

    @Test
    void parseFiles(@TempDir Path outdir) throws IOException, Err {
        Pair<Integer, Integer> result = AppTester.parseFiles(outdir,
                Paths.get("models", "meta"),
                Paths.get("models", "test"));
        assertNotEquals(0, result.getLeft());
        assertEquals(0, result.getRight());
        assertEquals((long) result.getLeft(), Files.list(outdir).count());
    }
}