package edu.unl.cse.iotcom;

import edu.mit.csail.sdg.alloy4.A4Reporter;
import edu.mit.csail.sdg.alloy4.ErrorWarning;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Alloy reporter wrapper for Log4J 2.
 *
 * @author Clay Stevens
 */
final class Log4jReporter extends A4Reporter {

    // singleton instance
    static final Log4jReporter INSTANCE = new Log4jReporter();
    // logger for logging the logs
    private static final Logger logger = LogManager.getFormatterLogger();

    @Override
    public void debug(String msg) {
        super.debug(msg);
        logger.debug(msg);

    }

    @Override
    public void warning(ErrorWarning msg) {
        super.warning(msg);
        logger.debug(msg.msg, msg);
    }
}
