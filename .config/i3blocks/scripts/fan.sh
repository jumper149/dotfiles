#!/bin/bash

# needs to be adapted

INFO=$(cat /proc/acpi/ibm/fan | grep "speed" -m 1)

SPEED=${INFO:8}
if [ $SPEED = 0 ] ; then
	SPEED="----"
	exit
fi
SPEED="0000$SPEED"
SPEED="${SPEED:$(( ${#SPEED} - 4 ))}"

echo "$SPEED RPM"
