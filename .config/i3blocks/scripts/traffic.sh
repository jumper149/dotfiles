#!/bin/bash

# set desired device

#!/bin/bash

# needs to be adapted

if [ "$(hostname)" = "x220arch" ]
then
	DEVICE=wlp2s0
elif [ "$(hostname)" = "x201arch" ]
then
	DEVICE=wlp5s0
else
	exit 1
fi

LENGTH=11
INFO="$(vnstat --iface wlp2s0 -tr 2 --json | sed 's/,/\n/g')"

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
