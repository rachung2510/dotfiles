#!/bin/bash

pw="root"

notify_bluetooth() {
	notify-send -u normal -i "~/.config/dunst/img/bluetooth-$1.png" "Bluetooth turned $1" "Status: $(eval $cmd)"
}
eww_update() {
	eww update $1-bool=$(bash scripts/getbool.sh $1) &&
	eww update $1-literal="$(eww get $1-literal)"
}

if [[ $1 = "wifi" ]]; then
	if [[ "$(eww get wifi-bool)" != "" ]]; then
		nmcli radio wifi off
	else
		nmcli radio wifi on
	fi
	eww_update wifi
	eww update wifi-tooltip=$(bash scripts/tooltip.sh wifi)

elif [[ $1 = "bluetooth" ]]; then
	cmd="service bluetooth status | grep 'Active:' | grep -oP '(?<=Active: ).*'"
	if [[ "$(eww get bluetooth-bool)" != "" ]]; then
		# bluetooth.service must be disabled (sudo systemctl disable bluetooth)
		echo $pw | sudo -S service bluetooth stop
		notify_bluetooth off
	else
		echo $pw | sudo -S service bluetooth start
		notify_bluetooth on
	fi
	eww_update bluetooth

elif [[ $1 = "notif" ]]; then
	if [[ "$(eww get notif-bool)" != "" ]]; then
		dunstctl set-paused false
	else
		dunstctl set-paused true
		notify-send "Do not disturb disabled" "Notifications will be shown"
	fi
	eww_update notif

elif [[ $1 = "lock" ]]; then
	~/.config/i3/scripts/poweractions.sh "lock"
elif [[ $1 = "sleep" ]]; then
	~/.config/i3/scripts/poweractions.sh "sleep"
elif [[ $1 = "logout" ]]; then
	~/.config/i3/scripts/poweractions.sh "exit"
fi
