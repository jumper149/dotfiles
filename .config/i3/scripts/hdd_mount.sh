#!/bin/bash

i3-msg floating enable 

MOUNTSPOT='/home/jumper/Storage'

clear

echo "gimme password to mount HDD to $MOUNTSPOT"

sudo mount '/dev/sda1' $MOUNTSPOT

exit
