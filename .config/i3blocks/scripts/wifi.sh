#!/bin/bash

# written for ip (which is standard installed)

DEVICE=wlp3s0
INFO=$(ip address show dev $DEVICE | grep inet\ )
IPADR=${INFO:$(expr index "$INFO" inet + 4)}
IPADRFORMAT=${IPADR:0:$(expr index "$IPADR" \  - 1)}

echo $IPADRFORMAT
