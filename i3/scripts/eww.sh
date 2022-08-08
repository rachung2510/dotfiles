#!/bin/bash

windows="$(eww windows) eol"
open_windows=$(echo "$(eww windows)" | grep "*")
ESC=9
RETURN=36

#echo "$open_windows"

if [[ "$(eww ping)" = "" ]]; then
	eww daemon
fi

if [[ $open_windows = *"$1"* ]]; then
	eww close $1
	[ $1 = "sidebar" ] && pkill cava && eww open bar
	killall eww.sh
elif [[ $1 = "sidebar" ]]; then
	eww close bar
	gnome-terminal --hide-menubar --window-with-profile=dc1 --role=dc1 -- cava -p ~/.config/cava/config &
	sleep 0.15 && eww open sidebar
	xinput test-xi2 --root 3 | grep -A2 --line-buffered RawKeyRelease | while read -r line; do
	    if [[ $line == *"detail"* ]]; then
	        key=$( echo $line | sed "s/[^0-9]*//g")
			if [[ $key = $ESC ]] || [[ $key = $RETURN ]]; then
				eww close sidebar && pkill cava
				eww open bar
				exit 0
			fi
		fi
	done
elif [[ $1 = "bar" ]]; then
	eww open bar

else
	killall eww.sh
fi
