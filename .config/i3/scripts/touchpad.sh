#!/bin/bash

DEVICE="SynPS/2 Synaptics TouchPad"

xinput set-prop "$DEVICE" "libinput Tapping Enabled" 1
xinput set-prop "$DEVICE" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$DEVICE" "Device Enabled" 0
