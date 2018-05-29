#!/bin/bash

pdfviewer="$3"
editor="$2"

texfile="$1"
pdffile="${texfile:0:$( expr ${#texfile} - 3 )}pdf"

echo $pdffile

$pdfviewer $pdffile & $editor $texfile
