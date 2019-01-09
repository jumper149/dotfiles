#!/bin/bash

source ~/.system-info.sh

if [ "`hostname`" = "deskarch" ]; then
	MAIN_PULSEAUDIO_SINK='1'
fi

if [ -z "$1" ]; then
	exit 1
elif [ "$1" = "off" ]; then
	pactl unload-module module-loopback
elif [ "$1" = "on" ]; then
	pactl load-module module-loopback latency_msec=1 sink=$MAIN_PULSEAUDIO_SINK source=$MAIN_PULSEAUDIO_SOURCE channel_map=mono,mono
fi
