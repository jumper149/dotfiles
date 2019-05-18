#!/usr/bin/env bash

value=$(cat /sys/class/backlight/intel_backlight/brightness)
delta=100
if [ $value -gt $delta ]; then 
	tee /sys/class/backlight/intel_backlight/brightness <<< "$(($value - $delta))"
fi
