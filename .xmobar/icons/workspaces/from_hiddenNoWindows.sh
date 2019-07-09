#!/bin/bash

# Give `workspaces`-directory as argument.
# Generate all other workspace icons from the ones in `hiddenNoWindows`.

if [ -z "$1" ]
then echo "give workspaces-directory as argument"
    exit 1
fi

cd "${1}/hiddenNoWindows/"

STATUSLIST="hidden,current,urgent,visible"
STATUSES="$(echo "${STATUSLIST}" | sed 's/,/\n/g')"

STARTLINE="21"
ENDLINE="38"

STANDARDCHAR='w'
STANDARDBGCHAR=' '
STANDARDBORDERCHAR='s'

for status in ${STATUSES} ; do
    case $status in
        hidden)
            colorchar='W'
            bgchar="${STANDARDBGCHAR}"
            borderchar="${STANDARDBORDERCHAR}"
            ;;
        current)
            colorchar='g'
            bgchar="${STANDARDBGCHAR}"
            borderchar='g'
            ;;
        urgent)
            colorchar='y'
            bgchar="${STANDARDBGCHAR}"
            borderchar="${STANDARDBORDERCHAR}"
            ;;
        visible)
            colorchar='W'
            bgchar="${STANDARDBGCHAR}"
            borderchar='w'
            ;;
        *)
            colorchar="${STANDARDCHAR}"
            bgchar="${STANDARDBGCHAR}"
            borderchar="${STANDARDBORDERCHAR}"
            ;;
    esac

    for file in workspace_*.xpm ; do # a, A, d are not used as colorcodes
        sed "${STARTLINE},${ENDLINE}s/${STANDARDCHAR}/a/g" "$file" \
            | sed "${STARTLINE},${ENDLINE}s/${STANDARDBGCHAR}/A/g" \
            | sed "${STARTLINE},${ENDLINE}s/${STANDARDBORDERCHAR}/d/g" \
            | sed "${STARTLINE},${ENDLINE}s/a/${colorchar}/g" \
            | sed "${STARTLINE},${ENDLINE}s/A/${bgchar}/g" \
            | sed "${STARTLINE},${ENDLINE}s/d/${borderchar}/g" \
            > "../${status}/${file}"
    done
done
