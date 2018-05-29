#!/bin/bash

HARDDRIVE=/dev/sdb3

#SIZE1=$(df $HARDDRIVE -h --output=size)
#SIZE2=${SIZE1:6}
#SIZE3=$(echo $SIZE2 | sed 's/ //g')
#
#USED1=$(df $HARDDRIVE -h --output=used)
#USED2=${USED1:6}
#USED3=$(echo $USED2 | sed 's/ //g')
#
#echo "$USED3/$SIZE3"

FREE1=$(df $HARDDRIVE -h --output=avail)
FREE2=${FREE1:6}
FREE3=$(echo $FREE2 | sed 's/ //g')

echo "FREE $FREE3"
