#!/bin/bash

# know arrays are mounted on execution

# add known UUIDs to the array below
KNOWN_LIST=( "CC78-FDFE" "3AE57D7D33FF9529" "0011-9095" "10df1b75-8e8f-4773-b079-c3bd32b85c16" "16DC46E5DC46BF2D" )

for UUID in /dev/disk/by-uuid/* ; do
	for KNOWN_UUID in "${KNOWN_LIST[@]}" ; do
		if [ "$UUID" == "/dev/disk/by-uuid/$KNOWN_UUID" ] ; then
			udevil mount "$UUID" ;
		fi
	done
done
