#!/bin/bash

LOW_THRESH=15
HIGH_THRESH=95

high() {
	notify-send -u low -i ~/.config/dunst/img/battery-full.png -h "string:x-dunst-stack-tag:batt-full" "Battery is fully charged" "Please disconnect your charger"
}

low() {
	duration=$(acpi -b | grep -oP '(?<=%, ).*(?= remaining)')
	notify-send -u critical -i ~/.config/dunst/img/battery-critical.png -h "string:x-dunst-stack-tag:batt-crit" "Your battery is running low" "${duration%:*} ($1%) remaining"
}

[[ $1 = "--high" ]] && high && exit 0
[[ $1 = "--low" ]] && low $LOW_THRESH && exit 0

pid=$(pgrep battery.sh)
if [[ $(echo "$pid" | awk -F '[ ]' '{print (NF?NF-1:0)}') != "0" ]]; then
	exit 0
fi

while :
do
	STATUS=$(cat /sys/class/power_supply/BAT1/status)
	POWER=$(acpi -b | grep "Battery 0" | grep -o '[0-9]\+%' | tr -d '%')

	if [[ $STATUS = "Charging" ]]; then
		if [[ $POWER -ge $HIGH_THRESH ]]; then high; fi
	else
		if [[ $POWER -le $LOW_THRESH ]]; then low $POWER; fi
	fi
sleep 60
#echo "run"
done
