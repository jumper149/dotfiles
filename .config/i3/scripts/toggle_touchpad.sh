#!/bin/bash

DEVICE="ELAN0501:00 04F3:3019 Touchpad"

STRING=$(xinput list-props "$DEVICE" | grep "Device Enabled (142)")
STATE=${STRING:$(expr ${#STRING} - 1):1}

NEWSTATE=$(( $(($STATE + 1)) % 2))

xdotool mousemove 0 0
xinput set-prop "$DEVICE" 142 $NEWSTATE
