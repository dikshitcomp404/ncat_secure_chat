#!/bin/bash
PORT=1234
echo "Starting VM ncat SSL chat host on port $PORT..."
while true; do
    ncat --ssl -l --keep-open -p $PORT
    echo "Connection closed. Waiting for new connection..."
    sleep 2
done
