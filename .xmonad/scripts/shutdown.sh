#!/usr/bin/env bash

OPTION="`~/.scripts/decide/main.sh 'shutdown' 'reboot' 'leave Xmonad'`"

COMMAND=""

case "$OPTION" in
	"shutdown")
		shutdown now
		;;
	"reboot")
		reboot
		;;
	"leave Xmonad")
		pkill xmonad
		;;
	*)
		exit 1
esac
