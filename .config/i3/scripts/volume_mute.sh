#!/bin/bash

pactl set-sink-mute 0 1

# i3blocks
pkill --signal SIGRTMIN+14 i3blocks
