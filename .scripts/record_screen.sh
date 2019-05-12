#!/bin/bash

# first positional argument is $OUTPUT_FILE
OUTPUT_FILE="$1"

FRAME_RATE="60"

source ~/.system-info.sh
PULSE_SINK="$MAIN_PULSEAUDIO_SINK"
PULSE_SINK="$MAIN_PULSEAUDIO_SINK"

BITRATE="128k"

# get screen resolution
INFO="$(xrandr --listmonitors | sed '2q;d')"
INFO="$(echo "$INFO" | awk '{print $3}')"
X_RES="${INFO:0:$(expr index "$INFO" "/" - 1)}"
Y_RES="${INFO:$(expr index "$INFO" "x" )}"
Y_RES="${Y_RES:0:$(expr index "$Y_RES" "/" - 1)}"
SCREEN_RES="$(echo "$X_RES" "x" "$Y_RES" | sed 's/ //g')"

echo "outputfile=$OUTPUT_FILE"
echo "framerate=$FRAME_RATE"
echo "pulse_sink=$PULSE_SINK"
echo "audio_bitrate=$BITRATE"
echo "screenresolution=$SCREEN_RES"
echo "display=$DISPLAY"

if [ -n "$1" ]
then
	ffmpeg -f x11grab -video_size "$SCREEN_RES" -framerate "$FRAME_RATE" -i "$DISPLAY" -f pulse -i "$PULSE_SINK" -c:v libx264 -preset ultrafast -c:a mp3 -b:a "$BITRATE" "$OUTPUT_FILE"
else
	echo "ERROR: no output file given"
	exit 1
fi
