#!/bin/bash
PORT=1234
read -p "Host IP: " HOST
echo "Connecting to $HOST on port $PORT..."
while true; do
    ncat --ssl "$HOST" $PORT
    echo "Disconnected. Reconnecting in 3 seconds..."
    sleep 3
done

