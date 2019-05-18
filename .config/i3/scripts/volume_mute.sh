#!/usr/bin/env bash

source ~/.system-info.sh
sink="$MAIN_PULSEAUDIO_SINK"

pactl set-sink-mute "$sink" toggle

# i3blocks
pkill --signal SIGRTMIN+14 i3blocks
