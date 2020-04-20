package edu.unl.cse.iotcom;

import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.alloy4compiler.ast.Module;
import edu.mit.csail.sdg.alloy4compiler.parser.CompUtil;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Options;
import edu.mit.csail.sdg.alloy4compiler.translator.A4Solution;
import edu.mit.csail.sdg.alloy4compiler.translator.TranslateAlloyToKodkod;
import edu.unl.cse.iotcom.AlloySolver.SolverResult;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class AlloySolverTest {
    @Test
    void testIsUnique() throws Err {
        String testmodel = String.join(System.lineSeparator(),
                "one sig A { cmd = C1 + C2 }",
                "one sig B { trg = C1 + C2 }",
                "abstract sig C {}",
                "one sig C1, C2 extends C {}",
                "assert a1 { no x : C | (x in A.cmd) and (x in B.trg) }",
                "check a1"
        );
        A4Options options = new A4Options();
        options.solver = A4Options.SatSolver.SAT4J;
        options.skolemDepth = 1;
        Module world = CompUtil.parseEverything_fromString(null, testmodel);

        List<HashMap<String, String>> unique = new LinkedList<>();

        A4Solution solution = TranslateAlloyToKodkod.execute_command(
                null, world.getAllReachableSigs(), world.getAllCommands().get(0), options);
        assertTrue(solution.satisfiable());
        assertTrue(AlloySolver.isUnique(solution, unique));

        solution = solution.next();
        assertTrue(solution.satisfiable());
        assertTrue(AlloySolver.isUnique(solution, unique));

        solution = solution.next();
        assertFalse(solution.satisfiable());
    }

    @Test
    void testExecuteCommand(@TempDir Path outdir) throws Err {
        String testmodel = String.join(System.lineSeparator(),
                "one sig A { cmd = C1 + C2 }",
                "one sig B { trg = C1 + C2 }",
                "abstract sig C {}",
                "one sig C1, C2 extends C {}",
                "assert a1 { no x : C | (x in A.cmd) and (x in B.trg) }",
                "check a1"
        );
        A4Options options = new A4Options();
        options.solver = A4Options.SatSolver.SAT4J;
        options.skolemDepth = 1;
        Module world = CompUtil.parseEverything_fromString(null, testmodel);

        SolverResult res = AlloySolver.executeCommand(world, options, outdir.toFile(),
                world.getAllCommands().get(0), "a1", 10);

        assertEquals(2, res.getCounterExampleCount());
    }

    @Test
    void testGetSolutionsForFile(@TempDir Path outdir) throws IOException, Err {
        String testmodel = String.join(System.lineSeparator(),
                "one sig A { cmd = C1 + C2 }",
                "one sig B { trg = C1 + C2 }",
                "abstract sig C {}",
                "one sig C1, C2 extends C {}",
                "assert a1 { no x : C | (x in A.cmd) and (x in B.trg) }",
                "check a1"
        );
        Path modelFile = outdir.resolve("testModel.als");
        Files.write(modelFile, testmodel.getBytes());

        A4Options options = new A4Options();
        options.solver = A4Options.SatSolver.SAT4J;
        options.skolemDepth = 1;

        AlloySolver uut = new AlloySolver(outdir.toFile(), 10, options);
        Map<String, SolverResult> actual = uut.getSolutionsForFile(modelFile.toFile(), null);

        String cmdName = String.format("%3s,%02d", "a1", 0);

        assertEquals(1, actual.size());
        assertTrue(actual.containsKey(cmdName));
        assertEquals(2, actual.get(cmdName).getCounterExampleCount());

        assertEquals(3, Files.list(outdir).count());
    }
}