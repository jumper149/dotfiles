#!/bin/bash

HOURS=$(date '+%H')
MINS=$(date '+%M')

TIMEp=$(( $(( $(( 60 * $HOURS )) + MINS )) % 1440 ))p

red_gamma="`sed -n $TIMEp ~/.config/i3/scripts/blugon/gamma_from_mins_red`"
green_gamma="`sed -n $TIMEp ~/.config/i3/scripts/blugon/gamma_from_mins_green`"
blue_gamma="`sed -n $TIMEp ~/.config/i3/scripts/blugon/gamma_from_mins_blue`"

xgamma -rgamma $red_gamma -ggamma $green_gamma -bgamma $blue_gamma
