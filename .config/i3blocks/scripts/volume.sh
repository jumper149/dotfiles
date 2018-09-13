#!/bin/bash

source ~/.system-info.sh
SINK="$MAIN_PULSEAUDIO_SINK"

INFO=$(pactl list sinks | grep Volume: -m 1)
STARTINDEX=$(expr index "$INFO" \% - 4)
LENFROMINDEX=4
VOLUME=${INFO:$STARTINDEX:$LENFROMINDEX}

OUTSTRING=$(echo $VOLUME | sed 's/ //g')

MUTEQ=$(pactl list sinks | grep Mute: -m 1)

if [[ $MUTEQ = *"yes"* ]] ;
	then echo "MUTED"
	else echo "VOL $OUTSTRING"
fi
