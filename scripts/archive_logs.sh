#!/bin/bash
# ==============================================================================
# Script: archive_logs.sh
# Description: Simulates an enterprise log rotation policy (like logrotate).
#              Compresses reports and logs older than 7 days to save disk space.
# ==============================================================================

ARCHIVE_DIR="../archive"
REPORTS_DIR="../reports/daily_reports"

# Create archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

echo "========================================"
echo " Starting Log & Report Archiving..."
echo "========================================"

# Generate an archive filename based on the current date
ARCHIVE_NAME="$ARCHIVE_DIR/reports_archive_$(date +%Y%m%d).tar.gz"

# Find .txt reports older than 7 days.
# Note: For testing purposes on Windows/GitBash without old files, 
# you can change '+7' (older than 7 days) to '+0' (older than today) or remove it.
FILES_TO_ARCHIVE=$(find "$REPORTS_DIR" -type f -name "*.txt" -mtime +7 2>/dev/null)

if [ -z "$FILES_TO_ARCHIVE" ]; then
    echo "[INFO] No reports older than 7 days found for archiving."
else
    echo "[INFO] Archiving old reports into $ARCHIVE_NAME..."
    # Compress the files
    tar -czf "$ARCHIVE_NAME" $FILES_TO_ARCHIVE
    
    # Remove the original uncompressed files to free up space
    for file in $FILES_TO_ARCHIVE; do
        rm "$file"
    done
    echo "[SUCCESS] Archiving completed successfully!"
fi
