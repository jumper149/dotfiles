#!/bin/bash

sink=0

sh -c "pactl set-sink-mute "$sink" false ; pactl set-sink-volume "$sink" -5%"

# i3blocks
pkill --signal SIGRTMIN+14 i3blocks

paplay ~/.config/i3/scripts/feedback.aiff
