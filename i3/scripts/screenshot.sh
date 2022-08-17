#!/bin/bash

dir="$HOME/Pictures/Screenshots"
[[ ! -d $dir ]] && mkdir -p $dir
path="$dir/$(date '+%Y-%m-%d %H:%M:%S')_screenshot.png"

maim -s "$path"
xclip -selection clipboard -t image/png "$path"

if [[ -f $path ]]; then
	notify-send -a maim -u normal -i "$path" "Snip saved to clipboard" "Screenshot saved to Pictures."
fi

