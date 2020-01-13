#!/usr/bin/env bash

# main networking/internet device
# main partition
# main pulseaudio sink/source
# main webcam
# main touchpad

if [ "$(hostname)" = "jumpnix" ]
then
    MAIN_NETWORKING_DEVICE='wlp2s0'
    MAIN_PARTITION='/dev/sda1'
    MAIN_PULSEAUDIO_SINK='alsa_output.pci-0000_00_1b.0.analog-stereo'
    MAIN_PULSEAUDIO_SOURCE='alsa_input.pci-0000_00_1b.0.analog-stereo'
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
    MAIN_PULSEAUDIO_SINK='alsa_output.usb-C-Media_Electronics_Inc._USB_Advanced_Audio_Device-00.analog-stereo'
    MAIN_PULSEAUDIO_SOURCE='alsa_input.usb-C-Media_Electronics_Inc._USB_Advanced_Audio_Device-00.analog-stereo'
elif [ "$(hostname)" = "x200arch" ]
then
    MAIN_NETWORKING_DEVICE='wlp2s0'
    MAIN_PARTITION='/dev/sda2'
    MAIN_PULSEAUDIO_SINK='alsa_output.pci-0000_00_1b.0.analog-stereo'
    MAIN_PULSEAUDIO_SOURCE='alsa_input.pci-0000_00_1b.0.analog-stereo'
fi

