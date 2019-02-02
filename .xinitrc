#!/bin/sh

start_wm="$1"
if [ -z "$start_wm" ]; then
	start_wm="xmonad"
fi


xrdb "$HOME/.Xresources"
xmodmap "/etc/X11/xinit/.Xmodmap"

xset r rate 200 30
setxkbmap -option caps:escape
~/.scripts/touchpad.sh
xset b off
~/.wallpaper/wallpaper_set.sh
xdotool mousemove 0 0

urxvtd -f
blugon --waitforx &
unclutter --timeout 3 --jitter 3 --ignore-scrolling &

$start_wm

pkill urxvtd
pkill blugon
pkill unclutter
