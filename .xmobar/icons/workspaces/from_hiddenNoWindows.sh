#!/bin/bash

# Give `workspaces`-directory as argument.
# Generate all other workspace icons from the ones in `hiddenNoWindows`.

if [ -z "$1" ]

cd "${1}/hiddenNoWindows/"

STATUSLIST="hidden,current,urgent,visible"
STATUSES="$(echo "${STATUSLIST}" | sed 's/,/\n/g')"

STARTLINE="21"
ENDLINE="36"

STANDARDCHAR='w'

for status in ${STATUSES} ; do
    case $status in
        hidden)
            colorchar='W'
            ;;
        current)
            colorchar='g'
            ;;
        urgent)
            colorchar='y'
            ;;
        visible)
            colorchar='W'
            ;;
        *)
            colorchar="${STANDARDCHAR}"
            ;;
    esac

    for file in workspace_*.xpm ; do
        sed "${STARTLINE},${ENDLINE}s/${STANDARDCHAR}/${colorchar}/g" "$file" > "../${status}/${file}"
    done
done
