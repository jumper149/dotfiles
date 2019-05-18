#!/usr/bin/env bash

TRASHPATH="$HOME/.trash/"

for file in "$TRASHPATH"*
do
	echo "deleting $file"
	rm -r "$file"
done
