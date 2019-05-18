#!/usr/bin/env bash

# you might need to 'mkdir ~/.trash'

for file in "$@"
do
	mv "$file" "/home/$USER/.trash/"
done
