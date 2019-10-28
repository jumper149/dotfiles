#!/usr/bin/env sh

INPUT="$(cat /dev/stdin)"
subject="$(echo "${INPUT}" | grep -m1 "Subject:" | sed 's/Subject: //g' | cut -c '1-24')"
title="mail - ${subject}"

enscriptFlags="--word-wrap --font=Courier11 --header-font=CourierBold12 --output=-"
encodeFlags="-c --from-code=utf-8 --to-code=ISO-8859-1" 
ps2pdfFlags="- -"
zathuraFlags="-"

echo "${INPUT}" | iconv ${encodeFlags} | enscript ${enscriptFlags} --title="${title}" | ps2pdf ${ps2pdfFlags} | zathura ${zathuraFlags}
