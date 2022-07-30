#!/bin/bash

player_status=$(playerctl status 2> /dev/null)
if [[ $player_status = "Stopped" ]] || [[ $player_status = "" ]]; then
    echo "%{F#999}Offline%{F-}"
	exit 0
fi

playerctld daemon 2> /dev/null
player="$(playerctl metadata --format '{{playerName}}')"
cmd="playerctl "
title="$($cmd metadata title)"
trackid="$($cmd metadata 'mpris:trackid')"
artist="$($cmd metadata artist)"

if [[ $player == "spotify" ]]; then
	icon=""
	if [[ $artist = "" ]]; then
		metadata="${title}"
	else
		metadata="${artist} - ${title}"
	fi
else
	metadata="${title% -*}"
fi

if [[ $player == "chromium" ]] && [[ $title == *"YouTube" ]]; then
	icon=""
elif [[ $player == "chromium" ]]; then
	icon=""
elif [[ $player == "edge" ]]; then
	icon=""
elif [[ $player == "firefox" ]]; then
	icon=""
fi

display="${icon} %{T3}${metadata}%{T-} "
display_mod="${icon} %{T3}${metadata} "

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
	echo "$display" | awk '{if (length($display) > 50) {print substr($display_mod, 0, 51)"...%{T-}"} else print $display}'
elif [[ $player_status = "Paused" ]]; then
	echo "%{F#999}`echo "$display" | awk '{if (length($display) > 50) {print substr($display_mod, 0, 51)"...%{T-}"} else print $display}'`%{F-}"
fi
