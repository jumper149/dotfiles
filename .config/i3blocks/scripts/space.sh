#!/bin/bash

# set main partition (probably root- or home-partition)
HARDDRIVE=""
if [ "$(hostname)" = "x220arch" ]
then
	HARDDRIVE=/dev/sda3
elif [ "$(hostname)" = "x201arch" ]
then
	HARDDRIVE=/dev/sda2
else
	exit 1
fi

FREE1=$(df $HARDDRIVE -h --output=avail)
FREE2=${FREE1:6}
FREE3=$(echo $FREE2 | sed 's/ //g')

if [ "$FREE3" = "" ]
then
	exit 2
else
	echo "FREE $FREE3"
fi
