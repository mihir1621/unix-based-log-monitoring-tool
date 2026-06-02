#!/bin/bash
# report_generator.sh - Generates a daily summary report of the system logs

LOG_DIR="../logs"
REPORT_DIR="../reports/daily_reports"
REPORT_FILE="$REPORT_DIR/report_$(date +%Y%m%d).txt"

mkdir -p "$REPORT_DIR"

# Compute Metrics
TOTAL_LOGS=$(cat $LOG_DIR/*.log | wc -l)
INFO_COUNT=$(cat $LOG_DIR/*.log | grep -c "\[INFO\]")
WARN_COUNT=$(cat $LOG_DIR/*.log | grep -c "\[WARNING\]")
ERROR_COUNT=$(cat $LOG_DIR/*.log | grep -c "\[ERROR\]")
CRIT_COUNT=$(cat $LOG_DIR/*.log | grep -c "\[CRITICAL\]")
FAIL_COUNT=$(cat $LOG_DIR/*.log | grep -c "\[FAILED\]")

# Generate Report Header
cat <<EOF > "$REPORT_FILE"
=========================================================
          UNIX-BASED LOG MONITORING DAILY REPORT         
=========================================================
Report Date : $(date)
---------------------------------------------------------
TOTAL LOG ENTRIES : $TOTAL_LOGS
INFO MESSAGES     : $INFO_COUNT
WARNING MESSAGES  : $WARN_COUNT
ERROR MESSAGES    : $ERROR_COUNT
CRITICAL ISSUES   : $CRIT_COUNT
FAILED TRANSACTIONS: $FAIL_COUNT
---------------------------------------------------------
TOP RECURRING ERRORS:
EOF

# Extract top recurring errors using awk and sed
cat $LOG_DIR/*.log | grep -E "\[ERROR\]|\[CRITICAL\]" | sed -E 's/^[0-9-]{10} [0-9:]{8} \[[A-Z]+\] //' | sort | uniq -c | sort -nr | head -n 5 >> "$REPORT_FILE"

cat <<EOF >> "$REPORT_FILE"
---------------------------------------------------------
SYSTEM HEALTH SUMMARY:
EOF

if [ $CRIT_COUNT -gt 0 ] || [ $ERROR_COUNT -gt 10 ]; then
    echo "Status: POOR - System is experiencing a high volume of errors and critical issues." >> "$REPORT_FILE"
elif [ $ERROR_COUNT -gt 0 ]; then
    echo "Status: FAIR - System has some errors that require attention." >> "$REPORT_FILE"
else
    echo "Status: GOOD - System is stable with minimal errors." >> "$REPORT_FILE"
fi

cat <<EOF >> "$REPORT_FILE"
---------------------------------------------------------
ROOT CAUSE ANALYSIS (RCA) SUGGESTIONS:
EOF

# Simple RCA Logic
if grep -q "Database outage" $LOG_DIR/database.log; then
    echo "- DATABASE OUTAGE DETECTED: Check primary DB instance health, network connectivity, and connection pool limits." >> "$REPORT_FILE"
fi

if grep -q "OutOfMemoryError" $LOG_DIR/application.log; then
    echo "- APPLICATION CRASH DETECTED: Java OutOfMemoryError found. Investigate memory leaks or increase JVM heap size." >> "$REPORT_FILE"
fi

if grep -q "gateway timeout" $LOG_DIR/transaction.log; then
    echo "- PAYMENT GATEWAY TIMEOUTS: Verify external API vendor status and check firewall/proxy rules." >> "$REPORT_FILE"
fi

if grep -q "Missing transaction record" $LOG_DIR/transaction.log; then
    echo "- MISSING RECORDS: Discrepancy in transaction reconciliation. Audit the message queue or DB transaction commits." >> "$REPORT_FILE"
fi

echo "=========================================================" >> "$REPORT_FILE"

echo "Report generated successfully: $REPORT_FILE"
