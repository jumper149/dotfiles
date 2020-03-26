#!/usr/bin/env bash

Xresources="`cat "$HOME/.Xresources"`"

function EscSeqRGB {
	N="$1"
	Hex="`printf '%x\n' $N | tr 'a-z' 'A-Z'`"
	RGB="`echo "$Xresources" | grep -m "1" "*.color${N}:" | cut --delimiter="#" --fields="2"`"
	EscSeq="\e]P${Hex}${RGB}"
	echo -en "$EscSeq"
}

for i in `seq 0 15`
do
	EscSeqRGB "$i"
done
