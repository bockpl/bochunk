#!/bin/bash
MOUNTPOINT=/mnt/mfs

for DIR in $(grep "/.*" /etc/mfs/mfshdd.cfg); do
  # kasowanie wszystkich znakow przez sciezka
  DIR=$(echo $DIR|sed -e "s@.${MOUNTPOINT}@${MOUNTPOINT}@")
  
  # zmiana wlascicielstwa dla katalogow z chunkami
  USER_GROUP="mfs:mfs"
  if [ $(stat -c %U:%G $DIR) != $USER_GROUP ]; then
    echo "Change owner for $DIR"
    chown -R $USER_GROUP $DIR
  fi
done

# Start the first process
mfschunkserver -f start
