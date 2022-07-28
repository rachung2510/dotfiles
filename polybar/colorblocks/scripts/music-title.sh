#!/bin/bash

player_status=$(playerctl status 2> /dev/null)
if [[ $player_status = "Stopped" ]] || [[ $player_status = "" ]]; then
    echo "%{F#999}Offline%{F-}"
	exit 0
fi

command="playerctl -p playerctld "
title="$($command metadata title)"
trackid="$($command metadata 'mpris:trackid')"
artist="$($command metadata artist)"

if [[ $trackid == *"/com/spotify"* ]]; then
	if [[ $artist = "" ]]; then
		display=" %{T3}${title}%{T-} "
	else
		display=" %{T3}${artist} - ${title}%{T-} "
	fi
elif [[ $trackid == *"/org/chromium"* ]] && [[ $title == *"YouTube" ]]; then
	display=" %{T3}${title% -*}%{T-} "
elif [[ $trackid == *"/org/chromium"* ]]; then
	display=" %{T3}${title% -*}%{T-} "
else
	display=" %{T3}${title% -*}%{T-} "
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
	echo "$display" | awk '{if (length($display) > 50) {print substr($display, 0, 51)"...   "} else print $display}'
elif [[ $player_status = "Paused" ]]; then
	echo "%{F#999}`echo $display | awk '{if (length($display) > 50) {print substr($display, 0, 51)"...   "} else print $display}'`%{F-}"
fi
