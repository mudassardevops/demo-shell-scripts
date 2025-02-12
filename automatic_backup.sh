#!/bin/bash
<<help
this is a  shell scripit to take backups
can also be used with cron
help

# Configuration
BACKUP_DIR="/home/ubuntu/backups"          # Directory to store backups
SOURCE_DIR="/home/ubuntu/important_files"  # Directory to back up
DATE=$(date +"%Y%m%d_%H%M%S")              # Timestamp for backup file
BACKUP_NAME="backup_$DATE.tar.gz"          # Backup file name
LOG_FILE="/home/ubuntu/backup.log"         # Log file for backup process

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Start backup process
log_message "Starting backup of $SOURCE_DIR to $BACKUP_DIR/$BACKUP_NAME"

# Create the backup
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR" 2>> "$LOG_FILE"

# Check if backup was successful
if [ $? -eq 0 ]; then
    log_message "Backup completed successfully."
else
    log_message "Backup failed. Check the log for details."
    exit 1
fi

# Optional: Delete old backups (e.g., older than 7 days)
find "$BACKUP_DIR" -name "backup_*.tar.gz" -type f -mtime +7 -exec rm {} \;
log_message "Deleted backups older than 7 days."

log_message "Backup process finished."
