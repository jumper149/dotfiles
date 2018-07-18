#!/bin/bash

value=$(cat /sys/class/backlight/intel_backlight/brightness)
maxval=$(cat /sys/class/backlight/intel_backlight/max_brightness)
delta=100
if [ $value -lt $(($maxval - delta)) ]; then 
	tee /sys/class/backlight/intel_backlight/brightness <<< "$(($value + $delta))"
fi
