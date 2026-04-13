#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <IP>"
    exit 1
fi

IP=$1
DATE=$(date +%F)
OUTPUT="scan_${IP}_${DATE}.txt"

echo "Scanning $IP..." > $OUTPUT

for PORT in 21 22 80 443 3306
do
    (echo > /dev/tcp/$IP/$PORT) >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "Port $PORT: OPEN" | tee -a $OUTPUT
    else
        echo "Port $PORT: CLOSED" >> $OUTPUT
    fi
done

echo "Scan saved to $OUTPUT"