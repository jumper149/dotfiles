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
	MAIN_PULSEAUDIO_SINK='alsa_output.pci-0000_00_1b.0.analog-stereo'
        MAIN_PULSEAUDIO_SOURCE='alsa_input.usb-Plantronics_Plantronics_GameCom_780_788-00.analog-stereo'
elif [ "$(hostname)" = "x200arch" ]
then
	MAIN_NETWORKING_DEVICE='wlp2s0'
	MAIN_PARTITION='/dev/sda2'
	MAIN_PULSEAUDIO_SINK='alsa_output.pci-0000_00_1b.0.analog-stereo'
	MAIN_PULSEAUDIO_SOURCE='alsa_input.pci-0000_00_1b.0.analog-stereo'
fi

