#!/bin/bash

# looks for drives inside /media/

DRIVES=$(echo /media/*)
DRIVES=$(echo "$DRIVES" | sed -e 's@/media/@@g')
SPOT=$(~/.config/i3/scripts/decide.sh $DRIVES)
SPOT="/media/$SPOT/backup_$HOSTNAME/"
echo "backup to $SPOT"

sudo -k
sudo rsync -aAXv --delete --exclude=$SPOT/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude="swapfile" --exclude="lost+found" --exclude=".cache" "/" "$SPOT"
