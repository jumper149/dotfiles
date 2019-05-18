#!/usr/bin/env bash

TRASHPATH="/home/$USER/.trash/"
FILES=$(ls -A $TRASHPATH)

echo "$FILES" | while read line ;
do
	echo "deleting $line"
	rm -r "$TRASHPATH$line"
	sleep 0.1
done
