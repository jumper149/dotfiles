#!/usr/bin/env bash

source ~/.system-info.sh
HARDDRIVE="$MAIN_PARTITION"

FREE1=$(df $HARDDRIVE -h --output=avail)
FREE2=${FREE1:6}
FREE3=$(echo $FREE2 | sed 's/ //g')

if [ "$FREE3" = "" ]
then
	exit 2
else
	echo "FREE $FREE3"
fi
