#!/bin/bash

if [ "`hostname`" = "deskarch" ]; then
	feh --no-fehbg --bg-fill ~/.wallpaper/adi-0.jpg --bg-fill ~/.wallpaper/adi-1.jpg
else
	feh --no-fehbg --bg-fill ~/.wallpaper/space/13.jpg
fi
