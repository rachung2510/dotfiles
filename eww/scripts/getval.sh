#!/bin/bash

if [[ $1 = "vol" ]]; then
	echo "$(amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%')"
	exit 0
elif [[ $1 = "light" ]]; then
	echo "100*$(brightnessctl g)/$(brightnessctl m)" | bc
	exit 0
elif [[ $1 = "batt" ]]; then
	echo "$(acpi -b)" | grep -oP '(?<=, ).*(?=%,)'
	exit 0
fi

if [[ $1 = "cpu" ]]; then
	val=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
elif [[ $1 = "ram" ]]; then
	val=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
elif [[ $1 = "hdd" ]]; then
	val=$(df / | awk 'END{ print $(NF-1) }')
fi
echo "scale=1; ${val%*\%}/1" | bc
