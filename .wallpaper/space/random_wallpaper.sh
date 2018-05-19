#!/bin/bash

path=~/.wallpaper/space/
maxnumba=$( ls $path | wc -w )
numba=$(( $RANDOM % maxnumba ))

#feh --bg-fill ~/.wallpaper/space/$numba.jpg
feh --bg-fill ~/.wallpaper/space/13.jpg
