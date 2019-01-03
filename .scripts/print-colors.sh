#!/bin/bash

CHAR="ABC"

function print_color() {
	tput sgr0
	printf '%s ' "$1"
	tput setab "$1"
	printf '%s' "$CHAR"
	tput sgr0
	tput setaf "$1"
}

echo "escape sequence: '\e[\$((30 + ?)m)' | 0 < ? <  8"
echo "terminal color:  'tput setaf ?'    | 0 < ? < 16"

print_color " 0"; printf ' BLACK   '; print_color " 8" ; printf ' BLACK   \n'
print_color " 1"; printf ' RED     '; print_color " 9" ; printf ' RED     \n'
print_color " 2"; printf ' GREEN   '; print_color "10"; printf ' GREEN   \n'
print_color " 3"; printf ' YELLOW  '; print_color "11"; printf ' YELLOW  \n'
print_color " 4"; printf ' BLUE    '; print_color "12"; printf ' BLUE    \n'
print_color " 5"; printf ' MAGENTA '; print_color "13"; printf ' MAGENTA \n'
print_color " 6"; printf ' CYAN    '; print_color "14"; printf ' CYAN    \n'
print_color " 7"; printf ' WHITE   '; print_color "15"; printf ' WHITE   \n'

tput sgr0
