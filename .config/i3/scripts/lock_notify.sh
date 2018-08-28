#!/bin/bash

# --- prevent-corner: ---
# top right

# get screen resolution
INFO="$(xrandr --listmonitors | sed '2q;d')"
INFO="$(echo "$INFO" | awk '{print $3}')"
X_RES="${INFO:0:$(expr index "$INFO" "/" - 1)}"
Y_RES="${INFO:$(expr index "$INFO" "x" )}"
Y_RES="${Y_RES:0:$(expr index "$Y_RES" "/" - 1)}"

# get mouse position
INFO="$(xdotool getmouselocation)"
X_VAL="$(echo $INFO | awk '{print $1}')"
X_VAL="${X_VAL:2}"
Y_VAL="$(echo $INFO | awk '{print $2}')"
Y_VAL="${Y_VAL:2}"
echo $X_VAL
echo $Y_VAL

if [ $(( $X_RES - $X_VAL )) -lt 10 ] && [ $Y_VAL -lt 10 ]
then
	echo "aborting lock by pressing Super_L"
	xdotool key 'Super_L'
	exit 0
fi
exit

# --- flashing: ---

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
