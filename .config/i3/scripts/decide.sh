#!/bin/bash

XRES=$(cat ~/.Xresources)
COLOR0=$(echo "$XRES" | grep 'color0:')
color0=${COLOR0:$(expr index "$COLOR0" \# - 1)}
COLOR2=$(echo "$XRES" | grep 'color2:')
color2=${COLOR2:$(expr index "$COLOR2" \# - 1)}
COLOR8=$(echo "$XRES" | grep 'color8:')
color8=${COLOR8:$(expr index "$COLOR8" \# - 1)}
COLORe=$(echo "$XRES" | grep 'color15:')
colore=${COLORe:$(expr index "$COLORe" \# - 1)}

LIST=""

for arg in "$@"
do
	LIST="$LIST$arg\n"
done

echo -e "$LIST" | dmenu -b -i -fn 'Inconsolata:style=Bold' -nb "$colore" -nf "$color8" -sb "$color2" -sf "$color0"
