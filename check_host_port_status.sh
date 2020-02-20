#!/bin/bash

# Usage $ check_host_port_status.sh <host> <port> 
# Argument host must be an element from {apps, besu, fabric} and port is a number.
# Outputs connectivity result every 10 second with epoch time.

PORT=$2

if [[ "$2" = "" ]] ;
then
  echo "Enter port number as second argument. First argument must be host {apps, besu, fabric}."
  exit
fi

if [[ "$1" != "apps" && "$1" != "besu" && "$1" != "fabric" ]] ;
then
  echo "Enter correct host {apps, besu, fabric} as first argument."
  exit
fi

if [[ "$1" = "apps" ]] ;
then
  HOST=213.21.96.188
elif [[ "$1" = "besu" ]] ;
then
  HOST=213.21.96.189
else
  HOST=213.21.96.190
fi

echo "Testing $1 at port $2 ..."
for (( c=1; c<=500; c++ ))
do
  T=$(date +%s)
  echo "At Unix Time $T : nc -zv $1 at $HOST:$PORT"
  nc -zv $HOST $PORT
  sleep 10
done
