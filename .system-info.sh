#!/usr/bin/env bash

# main networking/internet device
# main partition
# main pulseaudio sink/source
# main webcam
# main touchpad

if [ "$(hostname)" = "x220arch" ]
then
	MAIN_NETWORKING_DEVICE='wlp2s0'
	MAIN_PARTITION='/dev/sda3'
	MAIN_PULSEAUDIO_SINK='0'
	MAIN_PULSEAUDIO_SOURCE='1'
	MAIN_WEBCAM='/dev/video0'
	MAIN_TOUCHPAD='SynPS/2 Synaptics TouchPad'
elif [ "$(hostname)" = "x201arch" ]
then
	MAIN_NETWORKING_DEVICE='wlp5s0'
	MAIN_PARTITION='/dev/sda3'
	MAIN_PULSEAUDIO_SINK='0'
	MAIN_PULSEAUDIO_SOURCE='1'
elif [ "$(hostname)" = "deskarch" ]
then
	MAIN_NETWORKING_DEVICE='enp7s0'
	MAIN_PARTITION='/dev/sda3'
	MAIN_PULSEAUDIO_SINK='1'
	MAIN_PULSEAUDIO_SOURCE='3'
elif [ "$(hostname)" = "x200arch" ]
then
	MAIN_NETWORKING_DEVICE='wlp2s0'
	MAIN_PARTITION='/dev/sda2'
	MAIN_PULSEAUDIO_SINK='0'
	MAIN_PULSEAUDIO_SOURCE='1'
fi

