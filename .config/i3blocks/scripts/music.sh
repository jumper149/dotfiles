#!/usr/bin/env bash

MAX_LENGTH="20"

INFO="`mpc status`"

SONG="`mpc current`"
NAME_LENGTH="${#SONG}"

if [ "$NAME_LENGTH" -gt "$MAX_LENGTH" ]; then
		SONG="${SONG:0:$MAX_LENGTH}"
		SONG="$SONG…"
fi

STATE="`echo $INFO | head -n 2`"

echo "$SONG"

if [[ "$STATE" = *"[paused]"* ]]; then
	echo ""
	echo "#707880"

fi
