#!/bin/bash

echo "==================================="
echo "     AUTOMATED BACKUP SCRIPT       "
echo "==================================="

# take source directory input
read -p "Enter directory to backup: " source

# Check if source directory exists
if [ ! -d "$source" ]; then
    echo "The source directory does not exist."
    exit 1
fi

# take backup destination input
read -p "Enter backup destination: " destination

# If the destination does not exists, create it 
if [ ! -d "$destination" ]; then
    mkdir -p "$destination"
    echo "Backup directory has been created."
fi

# backup type choices
echo "Backup Type:"
echo "1. Simple Copy"
echo "2. Compressed Archive (tar.gz)"

read -p "Choose backup type: " choice

# add the timestamp
timestamp=$(date +%Y%m%d_%H%M%S)

# include the start time
START=$(date +%s)

echo "[*] Starting backup..."
echo "[*] Source: $source"
echo "[*] Destination: $destination"

# start the actual backup process
if [ "$choice" -eq 1 ]; then

    backup_name="backup_$timestamp"
    cp -r "$source" "$destination/$backup_name"

    backup_path="$destination/$backup_name"

elif [ "$choice" -eq 2 ]; then

    backup_name="backup_$timestamp.tar.gz"
    tar -czf "$destination/$backup_name" "$source"

    backup_path="$destination/$backup_name"

else
    echo "Invalid choice."
    exit 1
fi

# obtain the end time
END=$(date +%s)
DURATION=$((END - START))

# verify if it is sucessfully backed up
if [ -e "$backup_path" ]; then
    echo "Backup successfully completed."
else
    echo "Backup failed."
    exit 1
fi

# get the size of the backup
size=$(du -sh "$backup_path" | cut -f1)

# display the summary of the backup
echo
echo "Backup Details:"
echo "File     : $(basename "$backup_path")"
echo "Location : $destination"
echo "Size     : $size"
echo "Time     : $DURATION seconds"
