-- schema.sql
-- Create database and tables for the Log Monitoring Tool

CREATE DATABASE IF NOT EXISTS log_monitor_db;
USE log_monitor_db;

-- Table to store detailed anomalies/errors parsed from logs
CREATE TABLE IF NOT EXISTS anomaly_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_timestamp DATETIME NOT NULL,
    severity VARCHAR(20) NOT NULL,
    source_file VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to store daily report summaries
CREATE TABLE IF NOT EXISTS monitoring_reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    report_date DATE NOT NULL,
    total_logs INT DEFAULT 0,
    info_count INT DEFAULT 0,
    warning_count INT DEFAULT 0,
    error_count INT DEFAULT 0,
    critical_count INT DEFAULT 0,
    failed_count INT DEFAULT 0,
    health_status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to store recurring error patterns for trend analysis
CREATE TABLE IF NOT EXISTS recurring_errors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    error_pattern VARCHAR(255) NOT NULL,
    occurrence_count INT DEFAULT 1,
    last_seen DATETIME NOT NULL,
    UNIQUE KEY (error_pattern)
);
