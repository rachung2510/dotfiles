#!/bin/bash
status=$(echo $(timeout 0.5 bluetoothctl scan on) | awk -F'[][]' '{ print $1 }')
if [[ $status != "Discovery started " ]]; then
	notify-send -u critical -i ~/.config/dunst/img/bluetooth-off.png "Bluetooth controller not detected" "Please shutdown and restart system"
fi
