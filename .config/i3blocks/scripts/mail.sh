#!/usr/bin/env bash

mail_PID="$(pgrep "offlineimap")"

if [ -n "$mail_PID" ]
then
	echo "IMAP"
fi
