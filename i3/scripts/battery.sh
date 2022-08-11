#!/bin/bash

LOW_THRESH=15
HIGH_THRESH=95

pid=$(pgrep battery.sh)
if [[ $(echo "$pid" | awk -F '[ ]' '{print (NF?NF-1:0)}') != "0" ]]; then
	exit 0
fi

while :
do
	STATUS=$(cat /sys/class/power_supply/BAT1/status)
	POWER=$(acpi -b | grep "Battery 0" | grep -o '[0-9]\+%' | tr -d '%')

	if [[ $STATUS = "Charging" ]]; then
		if [[ $POWER -ge $HIGH_THRESH ]]; then
			dunstify -u low -i "~/.config/dunst/img/battery-full.png" -h "string:x-dunst-stack-tag:batt-full" "Battery is fully charged" "Please disconnect your charger"
		fi
	else
		if [[ $POWER -le $LOW_THRESH ]]; then
			duration=$(acpi -b | grep -oP '(?<=%, ).*(?= remaining)')
			dunstify -u critical -i "~/.config/dunst/img/battery-critical.png" -h "string:x-dunst-stack-tag:batt-crit" "Your battery is running low" "${duration%:*} remaining"
		fi
	fi
sleep 60
#echo "run"
done
