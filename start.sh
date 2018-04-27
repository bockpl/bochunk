#!/bin/bash
MOUNTPOINT=/mnt/mfs

for DIR in $(grep "/.*" /etc/mfs/mfshdd.cfg); do
  # kasowanie wszystkich znakow przez sciezka
  DIR=$(echo $DIR|sed -e "s@.${MOUNTPOINT}@${MOUNTPOINT}@")
  chown -R mfs:mfs $DIR
done

# Start the first process
mfschunkserver -f start
