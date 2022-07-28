#!/bin/bash

player_status=$(playerctl status 2> /dev/null)

if [[ $player_status = "Paused" ]] || [[ $player_status = "Playing" ]]; then
	playerctl -p playerctld play-pause
fi
