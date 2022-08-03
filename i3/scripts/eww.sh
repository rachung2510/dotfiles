#!/bin/bash

windows="$(eww windows) eol"
open_window="$(echo $windows | grep -oP '(?<=\*).*?(?= )')"

#echo $windows
#echo $open_window

if [[ "$(eww ping)" = "" ]]; then
	eww daemon
fi

if [[ $open_window = "" ]]; then
	if [[ $1 = "sidebar" ]]; then
		gnome-terminal --hide-menubar --window-with-profile=dc1 --role=dc1 -- cava -p ~/.config/cava/config &
	fi
	sleep 0.15 && eww open $1
else
	eww close-all && pkill cava
fi

