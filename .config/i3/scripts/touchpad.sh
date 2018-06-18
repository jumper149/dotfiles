#!/bin/bash

DEVICE="ELAN0501:00 04F3:3019 Touchpad"

xinput set-prop "$DEVICE" 283 1 # Tapping
xinput set-prop "$DEVICE" 291 1 # Natural Scrolling
xinput set-prop "$DEVICE" 146 0 # on/off, disable dis shit (vim op), needs to be last option
