#!/bin/bash

windows="$(eww windows) eol"
open_windows="$(echo $windows | grep -oP '(?<=\*).*?(?= )')"
ESC=9
RETURN=36

#echo $windows
echo $open_windows

if [[ "$(eww ping)" = "" ]]; then
	eww daemon
fi

if [[ $open_windows != *"sidebar"* ]]; then
	gnome-terminal --hide-menubar --window-with-profile=dc1 --role=dc1 -- cava -p ~/.config/cava/config &
	sleep 0.15 && eww open sidebar
	xinput test-xi2 --root 3 | grep -A2 --line-buffered RawKeyRelease | while read -r line; do
	    if [[ $line == *"detail"* ]]; then
	        key=$( echo $line | sed "s/[^0-9]*//g")
			if [[ $key = $ESC ]] || [[ $key = $RETURN ]]; then
				eww close $1 && pkill cava
				exit 0
			fi
		fi
	done
else
	eww close sidebar && pkill cava
	killall eww.sh
fi
