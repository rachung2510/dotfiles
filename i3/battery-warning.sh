#!/bin/bash

NOTIFY_BOOL=0
THRESHOLD=15

while :
do
	STATUS=$(cat /sys/class/power_supply/BAT1/status)
	if [[ $STATUS = "Charging" ]]; then
		NOTIFY_BOOL=0
		continue
	fi

	POWER=$(acpi -b | grep "Battery 0" | grep -o '[0-9]\+%' | tr -d '%')
	if [[ $POWER -le $THRESHOLD ]] && [[ $NOTIFY_BOOL = 0 ]]; then
		duration=$(acpi -b | grep -oP '(?<=%, ).*(?= remaining)')
#		minutes=$(echo "$duration" | grep -oP '(?<=:).*(?=:)')
		notify-send -u critical "Your battery is running low" "${duration} remaining"
	fi
	NOTIFY_BOOL=1
sleep 30
#echo "run"
done
