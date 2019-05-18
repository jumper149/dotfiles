#!/usr/bin/env bash

LOCATION=Hanover
WEATHERREPORT=~/.config/i3blocks/scripts/weatherreport

ping wttr.in -q -c 1 -w 1 &> /dev/null || exit

curl wttr.in/~$LOCATION -# &> $WEATHERREPORT

STRING1=$(cat $WEATHERREPORT | grep °C -m 1)
STRING2=${STRING1:$(expr index "$STRING1" ° - 19)}

#echo $STRING2
