#!/usr/bin/env bash

XRES="$(cat "${HOME}/.Xresources")"
COLOR0="$(echo "${XRES}" | grep 'color0:')"
color0="${COLOR0:$(expr index "${COLOR0}" \# - 1)}"
COLORe="$(echo "${XRES}" | grep 'color15:')"
colore="${COLORe:$(expr index "${COLORe}" \# - 1)}"

monitors="$(xrandr --listactivemonitors | grep "[0-9]\{1,\}:")"
selectedMonitor="$(decide "${monitors}" | cut --delimiter=: --fields=1)"

exec screenkey --no-systray --font "Inconsolata Bold" --bg-color "${color0}" --font-color "${colore}" --opacity "0.75" --timeout "1.5" --scr "${selectedMonitor}"
