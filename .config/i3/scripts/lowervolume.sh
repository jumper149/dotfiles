#!/bin/bash

sh -c "pactl set-sink-mute 0 false ; pactl set-sink-volume 0 -5%"

paplay ~/.config/i3/scripts/feedback.aiff
