#!/bin/bash

sh -c "pactl set-sink-mute 0 false ; pactl set-sink-volume 0 -5%"

# i3blocks
pkill --signal SIGRTMIN+14 i3blocks

paplay ~/.config/i3/scripts/feedback.aiff
