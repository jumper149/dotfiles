#!/bin/bash

# main networking/internet device
# main partition
# main pulseaudio sink/source
if [ "$(hostname)" = "x220arch" ]
then
	MAIN_NETWORKING_DEVICE='wlp2s0'
	MAIN_PARTITION='/dev/sda3'
	MAIN_PULSEAUDIO_SINK='0'
	MAIN_PULSEAUDIO_SOURCE='1'
elif [ "$(hostname)" = "x201arch" ]
then
	MAIN_NETWORKING_DEVICE='wlp5s0'
	MAIN_PARTITION='/dev/sda2'
	MAIN_PULSEAUDIO_SINK='0'
	MAIN_PULSEAUDIO_SOURCE='1'
elif [ "$(hostname)" = "deskarch" ]
then
	MAIN_NETWORKING_DEVICE='enp7s0'
	MAIN_PARTITION='/dev/sda3'
	MAIN_PULSEAUDIO_SINK='3'
	MAIN_PULSEAUDIO_SOURCE='1'
fi

