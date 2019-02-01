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

if [ "$start_wm" = "xmonad" ]; then
	urxvtd -f
	xautolock -locker 'i3lock -c 000000 -f --script' -notify 3 -notifier ~/.config/i3/scripts/lock_notify.sh -time 30 &
	blugon --waitforx &
	unclutter --timeout 3 --jitter 3 --ignore-scrolling &

	$start_wm

	pkill urxvtd
	pkill xautolock
	pkill blugon
	pkill unclutter
else
	$start_wm
fi
