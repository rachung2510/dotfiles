#!/bin/bash

pid=$(pgrep onedrive.sh)
if [[ $(echo "$pid" | awk -F '[ ]' '{print (NF?NF-1:0)}') != "0" ]]; then
	exit 0
fi

while true; do
	#check wifi
	if [[ $(iwgetid -r) = "" ]]; then
		choice=$(dunstify --action="kill,Kill process" "OneDrive sync failed" "WiFi not connected. Consider killing the OneDrive sync")
		case "$choice" in
			"kill")
				notify-send "OneDrive sync stopped"
				exit 0
				;;
		esac
	fi

	echo "pass"
	onedrive --synchronize
	onedrive --synchronize --confdir=~/.config/onedriveimperial
	sleep 300
done
