#!/bin/bash

DEVICE="ELAN0501:00 04F3:3019 Touchpad"

xinput set-prop "$DEVICE" 142 0 #disable dis shit (vim op)
xinput set-prop "$DEVICE" 279 1
xinput set-prop "$DEVICE" 287 1
