-- SQL Script generated automatically from log files
-- Date: Wed Jun  3 00:52:06 IST 2026
USE log_monitor_db;

INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 09:12:45', 'ERROR', 'application.log', 'NullPointerException in UserService.java:145 ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 10:05:22', 'ERROR', 'application.log', 'Application crashed: OutOfMemoryError ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 10:30:15', 'CRITICAL', 'application.log', 'Failed to load configuration file: /etc/app/config.yml ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 10:35:00', 'ERROR', 'application.log', 'NullPointerException in UserService.java:145 ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 12:45:12', 'ERROR', 'application.log', 'File not found: /var/data/uploads/image_502.png ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 14:05:33', 'ERROR', 'application.log', 'Invalid data format in payload from IP 192.168.1.55 ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 15:30:10', 'ERROR', 'application.log', 'NullPointerException in UserService.java:145 ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 09:05:15', 'ERROR', 'database.log', 'Database connection lost. Attempting to reconnect... ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 09:05:20', 'CRITICAL', 'database.log', 'Database outage detected on host db-primary-01 ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 11:45:22', 'ERROR', 'application.log', 'Deadlock found when trying to get lock; try restarting transaction ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 14:20:55', 'ERROR', 'database.log', 'Database connection timeout after 30000ms. ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 16:45:30', 'ERROR', 'application.log', 'Deadlock found when trying to get lock; try restarting transaction ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 09:12:45', 'ERROR', 'transaction.log', 'Payment gateway timeout for TXN-1002. ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 09:15:00', 'FAILED', 'transaction.log', 'Transaction TXN-1002 failed due to gateway timeout. ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 11:30:15', 'ERROR', 'application.log', 'Missing transaction record for ID TXN-1004 during reconciliation. ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 12:05:45', 'ERROR', 'application.log', 'Invalid card details provided for TXN-1005. ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 12:05:45', 'FAILED', 'transaction.log', 'Transaction TXN-1005 failed. ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 14:10:10', 'ERROR', 'transaction.log', 'Payment gateway timeout for TXN-1006. ');
INSERT INTO anomaly_logs (log_timestamp, severity, source_file, message) VALUES ('2026-06-02 14:12:00', 'FAILED', 'transaction.log', 'Transaction TXN-1006 failed due to gateway timeout. ');
