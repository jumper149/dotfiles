#!/bin/bash

#value=$(cat /sys/class/backlight/intel_backlight/brightness)
value=$(xbacklight -get)

slptime=0.25
lowbri=1
highbri=99

#tee /sys/class/backlight/intel_backlight/brightness <<< "$lowbri"
xbacklight -set "$lowbri"

sleep $slptime

#tee /sys/class/backlight/intel_backlight/brightness <<< "$highbri"
xbacklight -set "$highbri"

sleep $slptime

#tee /sys/class/backlight/intel_backlight/brightness <<< "$lowbri"
xbacklight -set "$lowbri"

sleep $slptime

#tee /sys/class/backlight/intel_backlight/brightness <<< "$highbri"
xbacklight -set "$highbri"

sleep $slptime

#tee /sys/class/backlight/intel_backlight/brightness <<< "$lowbri"
xbacklight -set "$lowbri"

sleep $slptime

#tee /sys/class/backlight/intel_backlight/brightness <<< "$highbri"
xbacklight -set "$highbri"

sleep $slptime

#tee /sys/class/backlight/intel_backlight/brightness <<< "$value"
xbacklight -set "$value"
