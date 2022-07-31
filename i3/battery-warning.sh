#!/bin/bash

LOW_THRESH=15
HIGH_THRESH=95
NOTIFY_BOOL=0

while :
do
	STATUS=$(cat /sys/class/power_supply/BAT1/status)
	POWER=$(acpi -b | grep "Battery 0" | grep -o '[0-9]\+%' | tr -d '%')

	if [[ $STATUS = "Charging" ]]; then
		if [[ $POWER -ge $HIGH_THRESH ]] && [[ $NOTIFY_BOOL = 0 ]]; then
			notify-send -u low -i "~/.config/dunst/img/battery-full.png" "Battery is fully charged" "Please disconnect your charger"
			NOTIFY_BOOL=1
		elif [[ $POWER -lt $HIGH_THRESH ]]; then
			NOTIFY_BOOL=0
		fi
	else
		if [[ $POWER -le $LOW_THRESH ]] && [[ $NOTIFY_BOOL = 0 ]]; then
			duration=$(acpi -b | grep -oP '(?<=%, ).*(?= remaining)')
	#		minutes=$(echo "$duration" | grep -oP '(?<=:).*(?=:)')
			notify-send -u critical -i "~/.config/dunst/img/battery-critical.png" "Your battery is running low" "${duration} remaining"
			NOTIFY_BOOL=1
		elif [[ $POWER -gt $LOW_THRESH ]]
			NOTIFY_BOOL=0
		fi
	fi
sleep 60
#echo "run"
done
