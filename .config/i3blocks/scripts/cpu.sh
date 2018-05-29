#!/bin/bash

INFO=$(cat /proc/stat | grep cpu -m 1) # formatting info

STARTCHAR=$(expr index "$INFO" \  + 1 )
LIST=${INFO:$STARTCHAR}
FORMULA=$(echo "$LIST" | sed 's/ / + /g')

AMOUNT=$(($FORMULA))

NICE_AMOUNT=${LIST:$(expr index "$LIST" \ )} # ugly string formatting
SYSTEM_AMOUNT=${NICE_AMOUNT:$(expr index "$NICE_AMOUNT" \ )}
IDLE_AMOUNT=${SYSTEM_AMOUNT:$(expr index "$SYSTEM_AMOUNT" \ )}
IDLE=${IDLE_AMOUNT:0:$(expr index "$IDLE_AMOUNT" \  - 1)}

sleep 2

NEW_INFO=$(cat /proc/stat | grep cpu -m 1) # again

NEW_LIST=${NEW_INFO:$(expr index "$NEW_INFO" \  + 1)}
NEW_FORMULA=$(echo "$NEW_LIST" | sed 's/ / + /g')

NEW_AMOUNT=$(($NEW_FORMULA))

NEW_NICE_AMOUNT=${NEW_LIST:$(expr index "$NEW_LIST" \ )}
NEW_SYSTEM_AMOUNT=${NEW_NICE_AMOUNT:$(expr index "$NEW_NICE_AMOUNT" \ )}
NEW_IDLE_AMOUNT=${NEW_SYSTEM_AMOUNT:$(expr index "$NEW_SYSTEM_AMOUNT" \ )}
NEW_IDLE=${NEW_IDLE_AMOUNT:0:$(expr index "$NEW_IDLE_AMOUNT" \  - 1)}

DIFF_AMOUNT=$(($NEW_AMOUNT - $AMOUNT)) # quick maths
DIFF_IDLE=$(($NEW_IDLE - $IDLE))
USED=$(($DIFF_AMOUNT - $DIFF_IDLE))
USAGE=$((100 * $USED / $DIFF_AMOUNT))

FORMAT_USAGE1="00$USAGE" # formatting
FORMAT_USAGE2=${FORMAT_USAGE1:$((${#FORMAT_USAGE1} - 2))}

echo "CPU $FORMAT_USAGE2%"
