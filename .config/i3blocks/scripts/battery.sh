#!/bin/bash

STRING=$(acpi)

PERCENTAGE1=${STRING:$( expr index "$STRING" ,)}
PERCENTAGE2=${PERCENTAGE1:1:$(expr index "$PERCENTAGE1" % - 1)}
NUMBER="${PERCENTAGE2:0:$((${#PERCENTAGE2} - 1))}"

STATE1=${STRING:$( expr index "$STRING" :)}
STATE2=${STATE1:1:$(expr index "$STATE1" , - 2)}

case "$STATE2" in
	Full)
		STATE3="FULL"
		;;
	Charging)
		STATE3="LOAD"
		;;
	Discharging)
		STATE3="BATT"
		;;
	*)
		STATE3="????"
		;;
esac

if [ "$STATE3" = "" ] || [ "$PERCENTAGE2" = "" ]
then
	exit 1
else
	echo "$STATE3 $PERCENTAGE2"
	if [ $NUMBER -le 40 ]; then
		echo ""
		if [ "$NUMBER" -gt "25" ]; then
			echo "#85678f"
		elif [ "$NUMBER" -gt "10" ]; then
			echo "#a54242"
		else
			echo "#de935f"
		fi
	elif [ "$NUMBER" -ge "90" ]; then
		echo ""
		echo "#707880"
	fi
fi
