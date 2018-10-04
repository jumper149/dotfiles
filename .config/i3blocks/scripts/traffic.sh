#!/bin/bash

source ~/.system-info.sh
DEVICE="$MAIN_NETWORKING_DEVICE"

LENGTH=11
INFO="$(vnstat --iface $DEVICE -tr 2 --json | sed 's/,/\n/g')"

lookuprx='"rx":{"ratestring":"'
RXVAL="$(echo "$INFO" | grep "$lookuprx")"
RXVAL="${RXVAL:${#lookuprx}}"
RXVAL="0000${RXVAL:0:$((${#RXVAL} - 1))}"
RXVAL="${RXVAL:$((${#RXVAL} - $LENGTH))}"
RXVAL="$(echo "$RXVAL" | sed 's/bit//g')"

lookuptx='"tx":{"ratestring":"'
TXVAL="$(echo "$INFO" | grep "$lookuptx")"
TXVAL="${TXVAL:${#lookuptx}}"
TXVAL="0000${TXVAL:0:$((${#TXVAL} - 1))}"
TXVAL="${TXVAL:$((${#TXVAL} - $LENGTH))}"
TXVAL="$(echo "$TXVAL" | sed 's/bit//g')"

if [ "$RXVAL" = "" ] && [ "$TXVAL" = "" ]
then
	exit 2
else
	echo "$RXVAL - $TXVAL"
fi
