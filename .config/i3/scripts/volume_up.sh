#!/bin/bash

sink=0

sh -c "pactl set-sink-mute "$sink" false ; pactl set-sink-volume "$sink" +5%"

# i3blocks
pkill --signal SIGRTMIN+14 i3blocks

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
paplay $DIR/feedback.aiff
