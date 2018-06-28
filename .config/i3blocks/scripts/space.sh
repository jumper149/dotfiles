#!/bin/bash

HARDDRIVE=/dev/sda2

FREE1=$(df $HARDDRIVE -h --output=avail)
FREE2=${FREE1:6}
FREE3=$(echo $FREE2 | sed 's/ //g')

echo "FREE $FREE3"
