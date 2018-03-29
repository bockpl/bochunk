#!/bin/bash

for DIR in $(grep "/.*" /etc/mfs/mfshdd.cfg); do
  chown -R mfs:mfs $DIR
done

# Start the first process
mfschunkserver start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start mfschunkserver: $status"
  exit $status
fi

while sleep 15; do
  ps aux |grep mfschunkserver |grep -q -v grep
  PROCESS_1_STATUS=$?
  if [ $PROCESS_1_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done
