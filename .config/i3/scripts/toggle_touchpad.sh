#!/bin/bash

DEVICE="ELAN0501:00 04F3:3019 Touchpad"

OPTIONNO=146

STRING=$(xinput list-props "$DEVICE" | grep "Device Enabled ($OPTIONNO)")
STATE=${STRING:$(expr ${#STRING} - 1):1}

NEWSTATE=$(( $(($STATE + 1)) % 2))

xdotool mousemove 0 0
xinput set-prop "$DEVICE" $OPTIONNO $NEWSTATE
