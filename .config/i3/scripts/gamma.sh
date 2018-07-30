#!/bin/bash

RED_VAL=1
GREEN_VAL=0.8
BLUE_VAL=0.6

INFO="$(xrandr --listmonitors | grep "0:")"
MONITOR="$(echo "$INFO" | sed 's/ /\n/g' | tail -n 1)"

xrandr --output "$MONITOR" --gamma "$(echo "$RED_VAL $GREEN_VAL $BLUE_VAL" | sed 's/ /:/g')"
