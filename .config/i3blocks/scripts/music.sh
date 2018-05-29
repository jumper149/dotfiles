#!/bin/bash

MAX_LENGTH=20

SONG=$(mpc current)
NAME_LENGTH=${#SONG}

if [[ $NAME_LENGTH -gt $MAX_LENGTH ]] ;
	then
		SONG=${SONG:0:$MAX_LENGTH} ;
		SONG="$SONG..."
fi

echo $SONG
