#!/bin/bash

# needs to be adapted

if [ "$(hostname)" = "x220arch" ]
then
	INFO=$(sensors -A coretemp-isa-0000)
	INFO=$(echo "$INFO" | grep "Package id 0")
	TEMP=${INFO:$( expr index "$INFO" "\+"):2}
elif [ "$(hostname)" = "x201arch" ]
then
	INFO=$(cat /proc/acpi/ibm/thermal)
	INFO=${INFO:14}
	TEMP=${INFO:0:$(expr index "$INFO" \  - 1)}
elif [ "$(hostname)" = "deskarch" ]
then
	INFO=$(sensors -A coretemp-isa-0000)
	INFO=$(echo "$INFO" | grep "Package id 0")
	TEMP=${INFO:$( expr index "$INFO" "\+"):2}
else
	exit 1
fi

if [ "$TEMP" = "" ]
then
	exit 2
else
	echo "TEMP $TEMP°C"
fi
