#!/bin/bash

FILE=~/.config/i3/config

GAPSINNERVAL=6 # works best if this is single digit, check $FILE
GAPSOUTERVAL=16

INFO=$(cat $FILE | grep "gaps")

INNERINFO=$(echo "$INFO" | grep "inner")
INNERNOW=${INNERINFO:$((${#INNERINFO} - 1))}

if [ $INNERNOW -eq $GAPSINNERVAL ] ;
then
	sed -i 's/gaps inner 6/gaps inner 0/g' $FILE
	sed -i 's/gaps outer 16/gaps outer 0/g' $FILE ;
else
	sed -i 's/gaps inner 0/gaps inner 6/g' $FILE
	sed -i 's/gaps outer 0/gaps outer 16/g' $FILE ;
fi

i3-msg restart # somehow returns error code 1 ?!?!
