#!/bin/bash

path="$HOME/Pictures/Screenshots/$(date '+%Y-%m-%d %H:%M:%S')_screenshot.png"

maim -s "$path"
xclip -selection clipboard -t image/png "$path"

if [[ -f $path ]]; then
	dunstify -a maim -u normal -i "$path" "Snip saved to clipboard" "Screenshot saved to Pictures."
fi

