#!/bin/bash

# set main partition (probably root- or home-partition)
HARDDRIVE=/dev/sda3

FREE1=$(df $HARDDRIVE -h --output=avail)
FREE2=${FREE1:6}
FREE3=$(echo $FREE2 | sed 's/ //g')

echo "FREE $FREE3"
