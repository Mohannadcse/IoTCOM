package edu.unl.cse.iotcom;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.Err;
import edu.mit.csail.sdg.alloy4compiler.ast.Command;
import edu.mit.csail.sdg.alloy4compiler.ast.ExprVar;
import edu.mit.csail.sdg.alloy4compiler.ast.Module;
import edu.mit.csail.sdg.alloy4compiler.parser.CompUtil;
import edu.mit.csail.sdg.alloy4compiler.translator.*;

import java.io.File;
import java.nio.file.Paths;
import java.util.*;

/**
 * Wrapper for the Alloy analyzer used by IOTCOM.
 *
 * @author Clay Stevens
 */
public class AlloySolver {

    // output directory
    private final File outdir;
    // instance-specific enumeration limit
    private final int limit;
    // instance-specific Alloy options
    private final A4Options options;

    /**
     * Creates a new Alloy solver w/ the passed options and enumeration limit
     */
    AlloySolver(File outdir, int limit, A4Options options) {
        this.outdir = outdir;
        this.limit = limit;
        this.options = options == null ? getDefaultOptions() : options;
    }

    /**
     * Returns the default Alloy options
     */
    private static A4Options getDefaultOptions() {
        final A4Options options = new A4Options();
        options.solver = A4Options.SatSolver.SAT4J;
        options.skolemDepth = 2;
        return options;
    }

    /**
     * Determines whether or not the passed solution (or one essentially the same) is already in the passed
     * list of "skolem unique" solutions (i.e., all skolems in the model are assigned the same tuples)
     *
     * @param solution     Solution to test
     * @param skolemUnique List of previously encountered skolem unique solutions
     * @return true if the passed solution is new
     * @throws Err Something went wrong during the solve
     */
    static boolean isUnique(final A4Solution solution, final List<HashMap<String, String>> skolemUnique) throws Err {
        final HashMap<String, String> skolems = new LinkedHashMap<>();
        for (ExprVar skolem : solution.getAllSkolems()) {
            final A4TupleSet tuples = (A4TupleSet) solution.eval(skolem);
            for (A4Tuple tup : tuples)
                skolems.put(skolem.toString(), tup.toString());
        }
        boolean retval = skolemUnique.stream()
                .allMatch(m -> m.keySet().stream()
                        .anyMatch(k -> !Objects.equals(m.get(k), skolems.get(k))));
        if (retval)
            skolemUnique.add(skolems);
        return retval;
    }

    /**
     * Executes the passed command with the passed options in the passed module, writing the solution as XML to the
     * passed directory.
     *
     * @param world       Alloy module
     * @param options     Alloy options
     * @param outdir      Output folder
     * @param command     Command to execute
     * @param commandName Command name (for logging/file naming)
     * @param limit       Enumeration limit
     * @return Result of solving for this command
     * @throws Err Something went wrong during the solve
     */
    static SolverResult executeCommand(final Module world, final A4Options options, final File outdir,
                                       final Command command, final String commandName, int limit)
            throws Err {

        final TimingReporter rep = new TimingReporter(Log4jReporter.INSTANCE);
        final SolverResult res = new SolverResult();

        A4Solution solution = TranslateAlloyToKodkod.execute_command(rep, world.getAllReachableSigs(), command, options);
        res.solveTimeMS = rep.solveTimeMS;

        final List<HashMap<String, String>> skolemUnique = new LinkedList<>();
        for (int i = 0; i < limit && solution.satisfiable(); ++i) {
            if (isUnique(solution, skolemUnique)) {
                res.counterExampleCount++;
                final String filename = Paths.get(outdir.getAbsolutePath(),
                        String.format("%s.%d.xml", commandName, i)).toString();
                solution.writeXML(filename);
            }
            if (solution.isIncremental())
                solution = solution.next();
            else
                break;
        }
        return res;
    }

    /**
     * Enumerates solutions for the passed file up to the instance limit on enumeration, testing the
     * properties (commands) in the passed list only (unless null, in which case it runs all commands in the file)
     *
     * @param file    Alloy model file to solve
     * @param prpList List of commands to execute or null (for all commands)
     * @return Map of command names to results, including the number of instances found and the solution time
     * @throws Err Something went wrong during the solve
     */
    Map<String, SolverResult> getSolutionsForFile(final File file, final List<String> prpList) throws Err {
        final Map<String, SolverResult> retval = new HashMap<>();
        final Module world = CompUtil.parseEverything_fromFile(Log4jReporter.INSTANCE, null, file.getAbsolutePath());
        final File outdir = (this.outdir != null) ? this.outdir
                : new File(Paths.get(file.getParent(), "out").toString());
        //noinspection ResultOfMethodCallIgnored
        outdir.mkdirs();
        final List<Command> commands = world.getAllCommands();
        for (int i = 0; i < commands.size(); i++) {
            final Command command = commands.get(i);
            final String lbl = new StringTokenizer(command.label, " ").nextToken();
            if (prpList == null || prpList.contains(lbl)) {
                final String commandName = String.format("%s_%s_%d", file.getName(), lbl, i);
                retval.put(String.format("%3s,%02d", lbl, i),
                        executeCommand(world, this.options, outdir, command, commandName, this.limit));
            }
        }
        return retval;
    }

    /**
     * Result object from solution enumeration. Contains the solve time and the number of instances or
     * counterexamples.
     */
    static final class SolverResult {
        private long solveTimeMS;
        private long counterExampleCount;

        /**
         * Returns the solution time (in ms) for the first solution
         */
        long getSolveTimeMS() {
            return solveTimeMS;
        }

        /**
         * Returns the number of counterexamples
         */
        long getCounterExampleCount() {
            return counterExampleCount;
        }
    }

    /**
     * Reporter used to extract the solution time from Alloy
     */
    private static final class TimingReporter extends A4Reporter {
        private long solveTimeMS;

        private TimingReporter(final A4Reporter parent) {
            super(parent);
        }

        @Override
        public void resultSAT(Object command, long solvingTime, Object solution) {
            super.resultSAT(command, solvingTime, solution);
            this.solveTimeMS = solvingTime;
        }

        @Override
        public void resultUNSAT(Object command, long solvingTime, Object solution) {
            super.resultUNSAT(command, solvingTime, solution);
            this.solveTimeMS = solvingTime;
        }

    }
}

