#!/usr/bin/env bash

source ~/.system-info.sh
DEVICE="$MAIN_NETWORKING_DEVICE"

INFO=$(ip address show dev $DEVICE | grep inet\ )
IPADR=${INFO:$(expr index "$INFO" inet + 4)}
IPADRFORMAT=${IPADR:0:$(expr index "$IPADR" \  - 1)}

echo $IPADRFORMAT
