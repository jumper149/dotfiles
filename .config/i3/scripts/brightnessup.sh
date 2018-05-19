#!/bin/bash

value=$(cat /sys/class/backlight/intel_backlight/brightness)

if [ $value -lt 95 ]; then 
	tee /sys/class/backlight/intel_backlight/brightness <<< "$(($value + 5))"
fi
