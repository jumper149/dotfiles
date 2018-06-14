#!/bin/bash

echo "using ~/.config/i3/scripts/hdd_mount.sh" # hardcoded 2 times

INFO=$(~/.config/i3/scripts/hdd_mount.sh)

DRIVE0=$(echo "$INFO" | grep drive)
MOUNTSPOT0=$(echo "$INFO" | grep mountspot)

DRIVE=${DRIVE0:7}
MOUNTSPOT=${MOUNTSPOT0:11}

BACKUPSPOT="$MOUNTSPOT/backup_jumparch/"

echo ""
echo "gimme password to backup to '$BACKUPSPOT'"
echo "(full path, check carefully!, u dont wanna extract into '/')"

sudo -k
sudo rsync -aAXv --delete --exclude=$MOUNTSPOT/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude="swapfile" --exclude="lost+found" --exclude=".cache" "/" "$BACKUPSPOT"

exit
