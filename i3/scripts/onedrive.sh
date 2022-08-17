#!/bin/bash

pid=$(pgrep onedrive.sh)
if [[ $(echo "$pid" | awk -F '[ ]' '{print (NF?NF-1:0)}') != "0" ]]; then
	exit 0
fi

while true; do
	onedrive --synchronize
	onedrive --synchronize --confdir=~/.config/onedriveimperial
	sleep 300
done
