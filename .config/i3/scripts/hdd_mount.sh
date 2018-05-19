#!/bin/bash

i3-msg floating enable 

mountspot='/home/jumper/Storage'

clear

echo "gimme password to mount HDD to $mountspot"

sudo mount '/dev/sda1' $mountspot
