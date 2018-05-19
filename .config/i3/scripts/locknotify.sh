#!/bin/bash

value=$(cat /sys/class/backlight/intel_backlight/brightness)

slptime=0.25
lowbri=1
highbri=99

tee /sys/class/backlight/intel_backlight/brightness <<< "$lowbri"

sleep $slptime

tee /sys/class/backlight/intel_backlight/brightness <<< "$highbri"

sleep $slptime

tee /sys/class/backlight/intel_backlight/brightness <<< "$lowbri"

sleep $slptime

tee /sys/class/backlight/intel_backlight/brightness <<< "$highbri"

sleep $slptime

tee /sys/class/backlight/intel_backlight/brightness <<< "$lowbri"

sleep $slptime

tee /sys/class/backlight/intel_backlight/brightness <<< "$highbri"

sleep $slptime

tee /sys/class/backlight/intel_backlight/brightness <<< "$value"
