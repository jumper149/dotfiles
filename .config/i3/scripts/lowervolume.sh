#!/bin/bash

sh -c "pactl set-sink-mute 0 false ; pactl set-sink-volume 0 -5%"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
paplay $DIR/feedback.aiff
