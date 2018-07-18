#!/bin/bash

# needs to be adapted

# x201/x220
INFO=$(cat /proc/acpi/ibm/fan | grep "speed" -m 1)
SPEED="${INFO:8}"
SPEED="0000$SPEED"
SPEED="${SPEED:$(( ${#SPEED} - 4 ))}"

echo "$SPEED RPM"
