#!/bin/bash

INFO=$(pactl list sinks | grep Volume: -m 1)
STARTINDEX=$(expr index "$INFO" \% - 4)
LENFROMINDEX=4
VOLUME=${INFO:$STARTINDEX:$LENFROMINDEX}

OUTSTRING=$(echo $VOLUME | sed 's/ //g')

echo "VOL $OUTSTRING"
