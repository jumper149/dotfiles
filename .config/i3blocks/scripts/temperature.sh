#!/bin/bash

# needs to be adapted

# x201
#INFO=$(cat /proc/acpi/ibm/thermal)
#INFO=${INFO:14}
#TEMP=${INFO:0:$(expr index "$INFO" \  - 1)}
#echo "TEMP $TEMP°C"

# x220
INFO=$(sensors -A coretemp-isa-0000)
INFO=$(echo "$INFO" | grep "Package id 0")
TEMP=${INFO:$( expr index "$INFO" "\+"):2}
echo "TEMP $TEMP°C"

