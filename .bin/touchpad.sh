#!/usr/bin/env bash

source ~/.system-info.sh
DEVICE="$MAIN_TOUCHPAD"

xinput set-prop "$DEVICE" "libinput Tapping Enabled" 1
xinput set-prop "$DEVICE" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$DEVICE" "Device Enabled" 0
