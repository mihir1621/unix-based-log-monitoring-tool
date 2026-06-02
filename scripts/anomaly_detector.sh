#!/bin/bash
# anomaly_detector.sh - Detects errors and data anomalies from logs using awk and sed

LOG_DIR="../logs"
ANOMALY_REPORT="../reports/anomaly_report_$(date +%Y%m%d).txt"

mkdir -p ../reports

echo "Running Anomaly Detection..." > "$ANOMALY_REPORT"
echo "Date: $(date)" >> "$ANOMALY_REPORT"
echo "----------------------------------------" >> "$ANOMALY_REPORT"

# 1. High-frequency errors (Count occurrences of specific errors)
echo "[1] High-Frequency Errors Detected:" >> "$ANOMALY_REPORT"
cat $LOG_DIR/*.log | grep "ERROR" | sed -E 's/^[0-9-]{10} [0-9:]{8} \[ERROR\] //' | sort | uniq -c | sort -nr | head -n 5 >> "$ANOMALY_REPORT"
echo "" >> "$ANOMALY_REPORT"

# 2. Database Connection Issues
echo "[2] Database Connection Anomalies:" >> "$ANOMALY_REPORT"
awk '/Database connection lost|Database outage|timeout/ {print $1, $2, $0}' $LOG_DIR/database.log >> "$ANOMALY_REPORT"
echo "" >> "$ANOMALY_REPORT"

# 3. Payment/Transaction Failures
echo "[3] Transaction Failures & Missing Records:" >> "$ANOMALY_REPORT"
awk '/FAILED|Missing/ {print $1, $2, $0}' $LOG_DIR/transaction.log >> "$ANOMALY_REPORT"
echo "" >> "$ANOMALY_REPORT"

# 4. Invalid Data Formats
echo "[4] Invalid Data Formats Detected:" >> "$ANOMALY_REPORT"
grep -i "Invalid" $LOG_DIR/*.log | sed 's/^.*\.log://' >> "$ANOMALY_REPORT"
echo "" >> "$ANOMALY_REPORT"

echo "Anomaly detection complete. Report saved to $ANOMALY_REPORT"
cat "$ANOMALY_REPORT"
