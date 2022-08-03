#!/bin/bash

STATUS="$(playerctl -p playerctld status)";
play=""
pause=""

if [[ $1 = "icon" ]]; then
	if [[ $STATUS = "Playing" ]]; then
		echo $pause
	else
		echo $play
	fi
elif [[ "$1" == "action" ]]; then
	if [[ $STATUS = "Playing" ]]; then
    	playerctl -p playerctld pause -s
    	eww update play-icon=$play
	else
    	playerctl -p playerctld play -s
    	eww update play-icon=$pause
	fi
fi
