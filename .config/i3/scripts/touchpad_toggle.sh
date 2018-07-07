#!/bin/bash

DEVICE="SynPS/2 Synaptics TouchPad"

STRING=$(xinput list-props "$DEVICE" | grep "Device Enabled")
STATE=${STRING:$(expr ${#STRING} - 1):1}

NEWSTATE=$(( $(($STATE + 1)) % 2))

xdotool mousemove 0 0
xinput set-prop "$DEVICE" "Device Enabled" $NEWSTATE
