#!/bin/bash

i3-msg floating enable 

DRIVE='/dev/sda1'
MOUNTSPOT='/home/jumper/Storage'

clear

echo "gimme password to mount HDD to $MOUNTSPOT"

sudo -k
sudo mount $DRIVE $MOUNTSPOT

echo "drive: $DRIVE"
echo "mountspot: $MOUNTSPOT"

exit
