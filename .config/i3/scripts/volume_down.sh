#!/usr/bin/env bash

source ~/.system-info.sh
sink="$MAIN_PULSEAUDIO_SINK"

sh -c "pactl set-sink-mute "$sink" false ; pactl set-sink-volume "$sink" -5%"

# i3blocks
pkill --signal SIGRTMIN+14 i3blocks

paplay ~/.config/i3/scripts/feedback.aiff
