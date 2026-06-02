#!/bin/bash
# database_loader.sh - Parses logs and generates SQL INSERT statements

LOG_DIR="../logs"
SQL_DIR="../sql"
SQL_FILE="$SQL_DIR/load_data.sql"

mkdir -p "$SQL_DIR"

echo "-- SQL Script generated automatically from log files" > "$SQL_FILE"
echo "-- Date: $(date)" >> "$SQL_FILE"
echo "USE log_monitor_db;" >> "$SQL_FILE"
echo "" >> "$SQL_FILE"

# Process all logs to find ERROR, CRITICAL, FAILED
# Format: 2026-06-02 09:12:45 [ERROR] NullPointerException in UserService.java:145
# We want to insert into anomaly_logs(log_timestamp, severity, source_file, message)

cat $LOG_DIR/*.log | awk '
/ERROR|CRITICAL|FAILED/ {
    # $1 = Date, $2 = Time, $3 = [SEVERITY]
    # The rest is the message
    timestamp = $1 " " $2
    severity = $3
    gsub(/\[|\]/, "", severity) # Remove brackets
    
    # Message is the rest of the line
    message = ""
    for (i=4; i<=NF; i++) {
        message = message $i " "
    }
    
    # Determine source file heuristically (simple approach for demo)
    source_file = "application.log"
    if ($0 ~ /Database|connection|query/) { source_file = "database.log" }
    if ($0 ~ /Transaction|Payment|gateway/) { source_file = "transaction.log" }

    # Escape single quotes in message for SQL
    gsub(/\047/, "\047\047", message)

    printf "INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES (\047%s\047, \047%s\047, \047%s\047, \047%s\047);\n", timestamp, severity, source_file, message
}' >> "$SQL_FILE"

echo "SQL insert statements generated at $SQL_FILE"
echo "To load into MySQL, run: mysql -u <username> -p < $SQL_FILE"
