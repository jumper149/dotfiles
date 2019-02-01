#!/bin/sh

xrdb "$HOME/.Xresources"
xmodmap "/etc/X11/xinit/.Xmodmap"

xset r rate 200 30
setxkbmap -option caps:escape
~/.scripts/touchpad.sh
xset b off
~/.wallpaper/wallpaper_set.sh
xdotool mousemove 0 0

urxvtd &
xautolock -locker 'i3lock -c 000000 -f --script' -notify 3 -notifier ~/.config/i3/scripts/lock_notify.sh -time 30 &
unclutter --timeout 3 --jitter 3 --ignore-scrolling &

xmonad
