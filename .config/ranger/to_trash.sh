#!/bin/bash

for file in "$@"
do
	mv "$file" "/home/$USER/.trash/"
done
