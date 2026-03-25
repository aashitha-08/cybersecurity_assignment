#!/bin/bash

# check if filename is given

if [ $# -eq 0 ]; then
    echo "Usage: ./q3_log_analyzer.sh <logfile>"
    exit 1
fi

logfile=$1

#check if the file already exists

if [ ! -f "$logfile" ]; then
    echo "File '$logfile' does not exist."
    exit 1
fi

# check if the logfile is empty

if [ ! -s "$logfile" ]; then
    echo "The log file is empty."
    exit 1
fi

echo "=== LOG FILE ANALYSIS ==="
echo "Log file: $logfile"
echo

# we find the total entries

total=$(wc -l < "$logfile")
echo "Total Entries: $total"
echo

# Find all the unique IP addresses

echo "Unique IP addresses:"
awk '{print $1}' "$logfile" | sort | uniq | while read ip
do
    echo " - $ip"
done

unique_count=$(awk '{print $1}' "$logfile" | sort | uniq | wc -l)
echo "Total Unique IP Addresses: $unique_count"
echo

# we fetch the status code summary

echo "Status Code Summary:"
awk '{print $NF}' "$logfile" | sort | uniq -c | while read count code
do
    echo " $code: $count requests"
done

echo

# we find the most frequently accessed page

most_page=$(awk '{print $7}' "$logfile" | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
page_count=$(awk '{print $7}' "$logfile" | sort | uniq -c | sort -nr | head -1 | awk '{print $1}')

echo "Most frequently accessed page:"
echo " $most_page - $page_count times"
echo

# Top 3 IP addresses

echo "Top 3 IP Addresses:"
awk '{print $1}' "$logfile" | sort | uniq -c | sort -nr | head -3 | nl | while read num count ip
do
    echo " $num. $ip - $count requests"
done

