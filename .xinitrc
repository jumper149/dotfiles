#!/usr/bin/env sh

start_wm="${1}"
if [ -z "${start_wm}" ]; then
	start_wm="xmonad"
	echo "WindowManager defaults to Xmonad"
fi


xrdb "${HOME}/.Xresources"
xmodmap "/etc/X11/xinit/.Xmodmap"

[ -f ~/.xprofile ] && . ~/.xprofile

setxkbmap -option caps:escape
touchpad init
xset b off
feh --no-fehbg --bg-fill "${XDG_DATA_HOME}/wallpaper/gradientBlack.png"
xsetroot -cursor_name left_ptr
xdotool mousemove 0 0

unclutter --timeout 3 --jitter 3 --ignore-scrolling &

exec ${start_wm}

pkill unclutter
