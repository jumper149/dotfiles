#!/bin/bash

# requires fstab to only contain partitions listed with UUID
NEEDED_LIST=()
for LINE in "$(cat /etc/fstab | grep UUID)" ; do
	LINE="$(echo "$LINE" | sed 's/UUID=//')"
	LINE="$(echo "$LINE" | awk '{print $1}')"
	NEEDED_LIST+="$LINE "
done

# to ignore another UUID append it to NEEDED_LIST with
# NEEDED_LIST+="UUID-to-add"

UUID_LIST=()
for UUID in /dev/disk/by-uuid/* ; do
	check="ok"
	for NEEDED_UUID in $NEEDED_LIST ; do
		if [ "$UUID" == "/dev/disk/by-uuid/$NEEDED_UUID" ] ; then
			check="needed"
		fi
	done
	if [ "$check" == "ok" ] ; then
		UUID_LIST+="$UUID "
	fi
done

LABEL_LIST=( "all" )
for UUID in $UUID_LIST ; do
	LABEL_LIST+=" $(lsblk -no LABEL $UUID)"
done

CHOSEN_LABEL="$(~/.scripts/decide/main.sh $LABEL_LIST)"

if [ "$CHOSEN_LABEL" == "" ] ; then
	echo "ERROR: didn't choose anything to unmount, is 'decide' working?"
	exit 1 ;
elif [ "$CHOSEN_LABEL" == "all" ] ; then
	for UUID in $UUID_LIST ; do
		echo "Unmounting $(lsblk -no NAME,LABEL,UUID $UUID)"
		udevil umount "$UUID"
	done
else
	echo "Unmounting $(lsblk -no NAME,LABEL,UUID /dev/disk/by-label/$CHOSEN_LABEL)"
	udevil umount "/dev/disk/by-label/$CHOSEN_LABEL"
fi
