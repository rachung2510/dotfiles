#!/bin/bash

windows="$(eww windows) eol"
open_windows=$(echo "$(eww windows)" | grep "*")
ESC=9
RETURN=36

#echo "$open_windows"

if [[ "$(eww ping)" = "" ]]; then
	eww daemon
fi
close() {
	eww close sidebar && pkill vis
	eww open bar
	killall eww.sh
}

if [[ $1 != "" ]] && [[ $open_windows = *"$1"* ]]; then
	[ $1 = "bar" ] && eww close bar
	[ $1 = "sidebar" ] && close

elif [[ $1 = "sidebar" ]]; then
	eww close bar
	theme=$(~/.config/i3/scripts/theme.sh -p)
	gnome-terminal --hide-menubar --window-with-profile=cava-$theme --role=cava -- vis &
	sleep 0.24 && eww open sidebar
	xinput test-xi2 --root 3 | grep -A2 --line-buffered RawKeyRelease | while read -r line; do
	    if [[ $line == *"detail"* ]]; then
	        key=$( echo $line | sed "s/[^0-9]*//g")
			if [[ $key = $ESC ]] || [[ $key = $RETURN ]]; then
				eww close sidebar && pkill vis
				eww open bar
				exit 0
			fi
		fi
	done

elif [[ $1 = "bar" ]]; then
	eww open bar

else
	close
fi
