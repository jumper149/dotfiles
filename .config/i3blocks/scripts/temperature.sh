#!/usr/bin/env bash

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
elif [ "$(hostname)" = "x200arch" ]
then
	INFO=$(cat /proc/acpi/ibm/thermal)
	INFO=${INFO:14}
	TEMP=${INFO:0:$(expr index "$INFO" \  - 1)}
else
	exit 1
fi

if [ "$TEMP" = "" ]
then
	exit 2
else
	echo "TEMP $TEMP°C"
	if [ "$TEMP" -ge 65 ]; then
		echo ""
		if [ "$TEMP" -lt 75 ]; then
			echo "#85678f"
		elif [ "$TEMP" -lt 85 ]; then
			echo "#a54242"
		else
			echo "#de935f"
		fi
	fi
fi
