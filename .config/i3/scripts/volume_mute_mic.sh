#!/bin/bash

source=1

pactl set-source-mute "$source" toggle

# i3blocks
pkill --signal SIGRTMIN+14 i3blocks
