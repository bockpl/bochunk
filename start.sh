#!/bin/bash
MOUNTPOINT=/mnt/mfs

for DIR in $(grep "/.*" /etc/mfs/mfshdd.cfg); do
  # kasowanie wszystkich znakow przez sciezka
  DIR=$(echo $DIR|sed -e "s@.${MOUNTPOINT}@${MOUNTPOINT}@")
  chown -R mfs:mfs $DIR
done

# Start the first process
mfschunkserver start
RESULT=$?
if [[ ${RESULT} = "0" ]]; then
  echo "Failed to start mfschunkserver: $status"
  exit $status
fi

while sleep 15; do
  if $(ps aux |grep mfschunkserver |grep -q -v grep); then
    echo "Mfschunkserver exited!"
    exit 1
  fi
done
