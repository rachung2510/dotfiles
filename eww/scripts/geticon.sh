#!/bin/bash

batt_icons=("" "" "" "" "" "")
light_icons=("" "" "")

if [[ $1 = "vol" ]]; then
	mute=$(amixer -D pulse sget Master | grep 'off')
	if [[ $mute != "" ]]; then
		echo ""
	else
		echo ""
	fi

elif [[ $1 = "light" ]]; then
	level=$(echo 100*$(brightnessctl g)/$(brightnessctl m) | bc)
	if [[ level -le 30 ]]; then ramp=0;
	elif [[ level -le 60 ]]; then ramp=1;
	else ramp=2; fi
	echo "${light_icons[$ramp]}"

elif [[ $1 = "batt" ]]; then
	status=$(cat /sys/class/power_supply/BAT1/status)
	if [[ $status = "Charging" ]]; then
		echo ""
		exit 0
	fi
	level=$(acpi -b | grep -oP '(?<=, ).*(?=%,)')
	if [[ level -ge 99 ]]; then
		echo ""
		exit 0
	fi
	if [[ level -le 15 ]]; then ramp=0;
	elif [[ level -le 30 ]]; then ramp=1;
	elif [[ level -le 50 ]]; then ramp=2;
	elif [[ level -le 70 ]]; then ramp=3;
	elif [[ level -le 95 ]]; then ramp=4;
	else ramp=5; fi
	echo "${batt_icons[$ramp]}"

fi
