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
	if [ $NUMBER -lt 20 ]
	then
		echo "$STATE3 $PERCENTAGE2"
		echo ""
		echo "#FF0000"
	else
		echo "$STATE3 $PERCENTAGE2"
	fi
fi
