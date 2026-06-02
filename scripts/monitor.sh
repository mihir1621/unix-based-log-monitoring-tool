#!/bin/bash
# monitor.sh - Continuously monitors log files for critical events

LOG_DIR="../logs"
MONITOR_LOG="../reports/realtime_monitor.log"

echo "Starting Real-time Log Monitor..."
echo "Monitoring $LOG_DIR for ERROR, CRITICAL, FAILED, EXCEPTION, TIMEOUT..."
echo "Press [CTRL+C] to stop."

# Ensure report directory exists
mkdir -p ../reports

# tail -f all logs and grep for critical issues
tail -f $LOG_DIR/*.log | awk '
/ERROR|CRITICAL|FAILED|EXCEPTION|TIMEOUT/ {
    # Print the matched line and append to monitor log
    print "\033[31m" $0 "\033[0m" # Red color for critical alerts
    fflush()
}' | tee -a "$MONITOR_LOG"
