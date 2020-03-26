#!/usr/bin/env bash

OPTION="$(decide 'shutdown' 'reboot' 'leave i3')"

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
