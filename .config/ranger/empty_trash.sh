#!/bin/bash

TRASHPATH="/home/$USER/.trash/"
FILES=$(ls -A $TRASHPATH)

echo "$FILES" | while read line ;
do
	echo "deleting $line"
	rm "$TRASHPATH$line"
	sleep 0.1
done
