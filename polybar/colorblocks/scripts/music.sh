#!/bin/bash

player_status=$(playerctl status 2> /dev/null)

if [[ $player_status = "Paused" ]]; then
	echo "契"
elif [[ $player_status = "Playing" ]]; then
	echo ""
else
	echo ""
fi
