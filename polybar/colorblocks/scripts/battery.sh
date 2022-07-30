#!/bin/bash

dir="~/.config/polybar/colorblocks/scripts/rofi"
status="$(cat /sys/class/power_supply/BAT1/status)"

time_msg="$(acpi -b)"
duration="${time_msg##*, }"

if [[ $status = "Charging" ]]; then
	msg="Time until charged: ${duration% until charged*}"
else
	volt=$(cat /sys/class/power_supply/BAT1/voltage_now)
	curr=$(cat /sys/class/power_supply/BAT1/current_now)
	watt=$(echo "scale=2; ${volt}*${curr}/1000000/1000000" | bc)
	msg="Time remaining: ${duration% remaining*}
Consumption: ${watt} W"
fi

rofi -theme "$dir/message.rasi" -e "$msg"
