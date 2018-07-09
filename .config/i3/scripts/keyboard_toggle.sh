#!/bin/bash

if [ "$(setxkbmap -query | grep layout)" == "layout:     us" ];
	then
		setxkbmap de
	else
		setxkbmap us
fi

setxkbmap -option caps:escape
