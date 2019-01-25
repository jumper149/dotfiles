#!/bin/bash

# needs to be adapted

if [ "$(hostname)" = "x220arch" ]
then
	INFO=$(cat /proc/acpi/ibm/fan | grep "speed" -m 1)
	SPEED="${INFO:8}"
	SPEED="0000$SPEED"
	SPEED="${SPEED:$(( ${#SPEED} - 4 ))}"
elif [ "$(hostname)" = "x201arch" ]
then
	INFO=$(cat /proc/acpi/ibm/fan | grep "speed" -m 1)
	SPEED="${INFO:8}"
	SPEED="0000$SPEED"
	SPEED="${SPEED:$(( ${#SPEED} - 4 ))}"
elif [ "$(hostname)" = "deskarch" ]
then
	exit 2
elif [ "$(hostname)" = "x200arch" ]
then
	INFO=$(cat /proc/acpi/ibm/fan | grep "speed" -m 1)
	SPEED="${INFO:8}"
	SPEED="0000$SPEED"
	SPEED="${SPEED:$(( ${#SPEED} - 4 ))}"
else
	exit 1
fi

echo "$SPEED RPM"
if [ "${SPEED:0:4}" = "0000" ]; then
	echo ""
	echo "#707880"
fi
