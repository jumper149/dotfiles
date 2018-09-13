#!/bin/bash

source ~/.system-info.sh
source="$MAIN_PULSEAUDIO_SOURCE"

pactl set-source-mute "$source" toggle

# i3blocks
pkill --signal SIGRTMIN+14 i3blocks
