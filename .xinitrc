#!/usr/bin/env sh

start_wm="$1"
if [ -z "$start_wm" ]; then
	start_wm="xmonad"
	echo "WindowManager defaults to Xmonad"
fi


xrdb "$HOME/.Xresources"
xmodmap "/etc/X11/xinit/.Xmodmap"

[ -f ~/.xprofile ] && . ~/.xprofile

xset r rate 200 30
setxkbmap -option caps:escape
~/.scripts/touchpad.sh
xset b off
~/.wallpaper/wallpaper_set.sh
xsetroot -cursor_name left_ptr
xdotool mousemove 0 0

urxvtd -q -o -f
blugon --waitforx --fade &
unclutter --timeout 3 --jitter 3 --ignore-scrolling &

conky --config="$HOME/.config/conky/clock.conf" &

exec $start_wm

pkill urxvtd
pkill blugon
pkill unclutter
pkill conky
