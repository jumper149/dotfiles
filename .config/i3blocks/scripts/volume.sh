#!/bin/bash

source ~/.system-info.sh
SINK="$MAIN_PULSEAUDIO_SINK"

PREPREINFO="$(pactl list sinks)"
PREINFO="$(echo "$PREPREINFO" | grep -n "Sink #$MAIN_PULSEAUDIO_SINK")"
LINE="${PREINFO:0:$(expr index "$PREINFO" ":" - 1)}"
INFO=$(echo "$PREPREINFO" | tail -n "+$LINE")
STARTINDEX=$(expr index "$INFO" \% - 4)
LENFROMINDEX=4
VOLUME=${INFO:$STARTINDEX:$LENFROMINDEX}

OUTSTRING=$(echo $VOLUME | sed 's/ //g')

MUTEQ=$(pactl list sinks | grep Mute: -m 1)

if [[ $MUTEQ = *"yes"* ]] ;
	then echo "MUTED"
	else echo "VOL $OUTSTRING"
fi
