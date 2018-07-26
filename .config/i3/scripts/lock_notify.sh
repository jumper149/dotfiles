#!/bin/bash

MODULE='intel_backlight'
MODPATH="/sys/class/backlight/$MODULE"

value=$(cat $MODPATH/actual_brightness)
#value=$(xbacklight -get)

slptime=0.25
lowbri=1
highbri=$(cat $MODPATH/max_brightness)

function cycle {
	tee $MODPATH/brightness <<< "$lowbri"
	#xbacklight -set "$lowbri"
	sleep $slptime
	tee $MODPATH/brightness <<< "$highbri"
	#xbacklight -set "$highbri"
	sleep $slptime
}

CYCLE_COUNTER=0

while [ $CYCLE_COUNTER -lt 5 ] ;
do
	CYCLE_COUNTER=$(( $CYCLE_COUNTER + 1 ))
	cycle
done

tee $MODPATH/brightness <<< "$value"
#xbacklight -set "$value"
