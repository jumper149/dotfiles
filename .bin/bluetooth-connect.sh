#!/usr/bin/env bash

# space seperated list of mac addresses
MAC_LIST="38:18:4C:19:90:56"
MAC="$(~/.scripts/decide/main.sh "${MAC_LIST}")"

printf "power on\nconnect ${MAC}\nquit\n" | bluetoothctl
