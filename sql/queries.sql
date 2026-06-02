-- queries.sql
-- Useful queries for RCA, analytics, and reporting

USE log_monitor_db;

-- 1. Find recurring errors and count their occurrences
SELECT message, COUNT(*) AS occurrence_count
FROM anomaly_logs
WHERE severity IN ('ERROR', 'CRITICAL')
GROUP BY message
ORDER BY occurrence_count DESC
LIMIT 10;

-- 2. Count failures by severity level
SELECT severity, COUNT(*) AS total_issues
FROM anomaly_logs
GROUP BY severity
ORDER BY total_issues DESC;

-- 3. Identify affected transactions (Failed payments, missing records)
SELECT log_timestamp, message
FROM anomaly_logs
WHERE source_file = 'transaction.log'
  AND (message LIKE '%TXN-%' OR message LIKE '%FAILED%')
ORDER BY log_timestamp DESC;

-- 4. Identify database outages and connection issues
SELECT log_timestamp, message
FROM anomaly_logs
WHERE source_file = 'database.log'
  AND (message LIKE '%timeout%' OR message LIKE '%outage%' OR message LIKE '%connection lost%')
ORDER BY log_timestamp DESC;

-- 5. Check system health trend from daily reports (last 7 days)
SELECT report_date, error_count, critical_count, health_status
FROM monitoring_reports
ORDER BY report_date DESC
LIMIT 7;

-- 6. Find periods of high error frequency (e.g., grouped by hour)
SELECT DATE_FORMAT(log_timestamp, '%Y-%m-%d %H:00:00') AS hour_block, COUNT(*) AS issue_count
FROM anomaly_logs
GROUP BY hour_block
ORDER BY issue_count DESC;
