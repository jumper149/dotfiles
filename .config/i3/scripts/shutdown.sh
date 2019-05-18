#!/usr/bin/env bash

OPTION="`~/.scripts/decide/main.sh 'shutdown' 'reboot' 'leave i3'`"

COMMAND=""

case "$OPTION" in
	"shutdown")
		shutdown now
		;;
	"reboot")
		reboot
		;;
	"leave i3")
		i3-msg "exit"
		;;
	*)
		exit 1
esac
