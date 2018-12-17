#!/bin/bash

# input cannot contain '\n'

LIST=""
for arg in "$@" # put everything in a list
do
	LIST="$LIST$arg\n"
done

if [ ${#LIST} -gt 0 ] # cut off last '\n'
then
	LIST=${LIST:0:$((${#LIST} - 2))}
fi

SPACEDLIST=$(echo "$LIST" | sed 's/\\n/ /g')

if [ -n "$DISPLAY" ]
then
	RETURNSTRING="`echo -e "$LIST" | rofi -dmenu`"
else
	RETURNSTRING="`python ~/.scripts/decide/decide-fallback.py $SPACEDLIST`"
fi

if [ -n "$RETURNSTRING" ]
then
	echo "$RETURNSTRING"
else
	exit 1
fi
