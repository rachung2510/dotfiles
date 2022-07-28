#!/bin/bash

player_status=$(playerctl status 2> /dev/null)

if [[ $player_status = "Stopped" ]]; then
	echo ""
	exit 0
fi

if [[ $1 = "prev" ]]; then
	echo " 玲"
elif [[ $1 = "next" ]]; then
	echo "怜 "
fi
