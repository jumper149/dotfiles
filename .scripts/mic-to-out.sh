#!/usr/bin/env bash

source ~/.system-info.sh

if [ -z "$1" ]; then
	exit 1
elif [ "$1" = "off" ]; then
	pactl unload-module module-loopback
elif [ "$1" = "on" ]; then
	pactl load-module module-loopback latency_msec=1 source="$MAIN_PULSEAUDIO_SOURCE" sink="$MAIN_PULSEAUDIO_SINK"
fi
