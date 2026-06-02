#!/bin/bash
# ==============================================================================
# Script: generate_mock_logs.sh
# Description: Generates realistic mock log files for testing the monitoring tool.
#              Useful for recruiters or anyone cloning the project to test it.
# ==============================================================================

LOGS_DIR="../logs"
mkdir -p "$LOGS_DIR"

APP_LOG="$LOGS_DIR/application.log"
DB_LOG="$LOGS_DIR/database.log"
TXN_LOG="$LOGS_DIR/transaction.log"

# Clear existing logs
> "$APP_LOG"
> "$DB_LOG"
> "$TXN_LOG"

echo "========================================"
echo " Generating Mock Production Logs..."
echo "========================================"

CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")

# 1. Application Logs
echo "$CURRENT_DATE [INFO] Application started successfully." >> "$APP_LOG"
echo "$CURRENT_DATE [INFO] User login successful for ID 992." >> "$APP_LOG"
echo "$CURRENT_DATE [ERROR] NullPointerException in UserService.java:145" >> "$APP_LOG"
echo "$CURRENT_DATE [ERROR] NullPointerException in UserService.java:145" >> "$APP_LOG"
echo "$CURRENT_DATE [INFO] Cache cleared." >> "$APP_LOG"
echo "$CURRENT_DATE [ERROR] OutOfMemoryError: Java heap space" >> "$APP_LOG"
echo "[SUCCESS] Generated $APP_LOG"

# 2. Database Logs
echo "$CURRENT_DATE [INFO] Connected to primary db cluster." >> "$DB_LOG"
echo "$CURRENT_DATE [WARNING] Slow query detected. Execution time 1500ms." >> "$DB_LOG"
echo "$CURRENT_DATE [ERROR] Database connection lost. Attempting to reconnect..." >> "$DB_LOG"
echo "$CURRENT_DATE [CRITICAL] Database outage detected on host db-primary-01" >> "$DB_LOG"
echo "$CURRENT_DATE [ERROR] Deadlock found when trying to get lock; try restarting transaction" >> "$DB_LOG"
echo "[SUCCESS] Generated $DB_LOG"

# 3. Transaction Logs
echo "$CURRENT_DATE [INFO] Transaction TXN-1001 completed." >> "$TXN_LOG"
echo "$CURRENT_DATE [FAILED] Transaction TXN-1002 failed due to gateway timeout." >> "$TXN_LOG"
echo "$CURRENT_DATE [ERROR] Missing transaction record for ID TXN-1004 during reconciliation." >> "$TXN_LOG"
echo "$CURRENT_DATE [INFO] Transaction TXN-1003 completed." >> "$TXN_LOG"
echo "$CURRENT_DATE [ERROR] Invalid card details provided for TXN-1005." >> "$TXN_LOG"
echo "[SUCCESS] Generated $TXN_LOG"

echo "========================================"
echo " Done! You can now run the monitoring scripts."
echo " Try running: bash anomaly_detector.sh"
echo "========================================"
