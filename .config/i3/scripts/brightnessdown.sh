#!/bin/bash

value=$(cat /sys/class/backlight/intel_backlight/brightness)

if [ $value -gt 5 ]; then 
	tee /sys/class/backlight/intel_backlight/brightness <<< "$(($value - 5))"
fi
