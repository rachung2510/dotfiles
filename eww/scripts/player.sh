#!/bin/bash

play=""
pause=""

status() {
	STATUS="$(playerctl -p playerctld status)";
	[[ $1 = "-p" ]] && echo $STATUS && return 0
	[[ $STATUS = "Playing" ]] && echo $pause || echo $play
}

metadata() {
	player="$(playerctl metadata --format '{{playerName}}')"
	title="$(playerctl metadata title)"
	artist="$(playerctl metadata artist)"
	if [[ $player = "spotify" ]]; then icon=""
	elif [[ $title = *"YouTube" ]]; then icon=""
	else icon=$icon; fi
	[[ $1 = "title" ]] && echo "$icon ${title% -*}" && return 0
	[[ $1 = "artist" ]] && echo $artist
}

if [[ $1 = "icon" ]]; then
	status
	playerctl -p playerctld -F status | while read _; do
    	status
	done

elif [[ $1 ==  "title" ]] || [[ $1 = "artist" ]]; then
	playerctld daemon 2>/dev/null
	metadata $1
	playerctl -F metadata title | while read _; do
    	metadata $1
	done

elif [[ $1 == "action" ]]; then
	if [[ "$(status -p)" = "Playing" ]]; then
    	playerctl -p playerctld pause -s
    	eww update play-icon=$play
	else
    	playerctl -p playerctld play -s
    	eww update play-icon=$pause
	fi
fi
