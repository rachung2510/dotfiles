#!/bin/bash

if [[ $1 = "vol" ]]; then
#	sink=$(pactl list short sinks | tail -n 1 | awk '{print $2}')
	sink=$(pactl get-default-sink)
#	output_type=$(echo $sink | awk -F '[.]' '{print $1}')
	if [[ $sink = "bluez"* ]]; then
		id=$(echo $sink | awk -F '[.]' '{print $2}' | tr '_' ':')
		name=$(bluetoothctl info $id | grep "Name:" | awk '{print $2}')
	elif [[ $sink = "alsa_output"* ]]; then
		name="Speakers"
	fi
	echo -e "\nSpeaker: $name"

elif [[ $1 = "batt" ]]; then
	duration=$(acpi -b | awk -F '[,]' '{print $3}' | awk -F ' ' '{print $1}')
	volt=$(cat /sys/class/power_supply/BAT1/voltage_now)
    curr=$(cat /sys/class/power_supply/BAT1/current_now)
    watt=$(echo "scale=2; ${volt}*${curr}/1000000/1000000" | bc)
	echo -e "\nTime: ${duration%:*}\nRate: $watt W"

elif [[ $1 = "wifi" ]]; then
	dev="enp4s0f3u2"
	if [[ $(nmcli | grep $dev) != "" ]]; then
		name=$(nmcli | grep $dev | head -n 1 | grep -oP '(?<=connected to).*')
	else
		name=$(iwgetid -r)
		dev="wlp3s0"
	fi
	if [[ $name != "" ]]; then
		ip=$(ip addr show dev $dev | grep "inet " | awk '{print $2}')
		echo -e "Network: $name\nIP: $ip"
	fi
fi
