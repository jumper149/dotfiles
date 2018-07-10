#!/bin/bash

# needs to be adapted

INFO=$(cat /proc/acpi/ibm/thermal)
INFO=${INFO:14}
TEMP=${INFO:0:$(expr index "$INFO" \  - 1)}

echo "TEMP $TEMP°C"
