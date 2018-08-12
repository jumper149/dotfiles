#!/bin/bash

# set device
if [ "$(hostname)" = "x220arch" ]
then
	DEVICE=wlp2s0
elif [ "$(hostname)" = "x201arch" ]
then
	DEVICE=wlp2s0
else
	exit 1
fi

INFO=$(ip address show dev $DEVICE | grep inet\ )
IPADR=${INFO:$(expr index "$INFO" inet + 4)}
IPADRFORMAT=${IPADR:0:$(expr index "$IPADR" \  - 1)}

echo $IPADRFORMAT
