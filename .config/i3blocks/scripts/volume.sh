#!/usr/bin/env bash

source ~/.system-info.sh
SINK="$MAIN_PULSEAUDIO_SINK"

PREPREINFO="$(pactl list sinks)"
PREINFO="$(echo "$PREPREINFO" | grep -n "Sink #$MAIN_PULSEAUDIO_SINK")"
LINE="${PREINFO:0:$(expr index "$PREINFO" ":" - 1)}"
INFO=$(echo "$PREPREINFO" | tail -n "+$LINE")
STARTINDEX=$(expr index "$INFO" \% - 4)
LENFROMINDEX=4
VOLUME=${INFO:$STARTINDEX:$LENFROMINDEX}
VOLUME_PERCENT="${VOLUME:0: -1}"

OUTSTRING=$(echo $VOLUME | sed 's/ //g')

MUTEQ=$(pactl list sinks | grep Mute: -m 1)

if [[ $MUTEQ = *"yes"* ]] ; then
	echo "MUTED"
	echo ""
	echo "#707880"
else
	echo "VOL $OUTSTRING"
	if [ "$VOLUME_PERCENT" -gt "100" ]; then
		echo ""
		if [ "$VOLUME_PERCENT" -le "125" ]; then
			COLOR="#85678f"
		elif [ "$VOLUME_PERCENT" -le "150" ]; then
			COLOR="#a54242"
		else
			COLOR="#de935f"
		fi
		echo "$COLOR"
	fi
fi
