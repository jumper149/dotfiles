#!/bin/bash

# written for NetworkManager

DEVICE=wlp3s0
INFO=$(nmcli connection | grep $DEVICE)
ESSID=${INFO:0:$(expr index "$INFO" \ )}

echo $ESSID
