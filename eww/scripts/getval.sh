#!/bin/bash

if [[ $1 = "vol" ]]; then
	# echo $(pactl get-sink-volume @DEFAULT_SINK@) | grep -oP '(?<=\/)(?:\s*)\K.*?(?=%){1}' | head -n 1
	echo "$(amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%')"
	exit 0
elif [[ $1 = "light" ]]; then
	echo "100*$(brightnessctl g)/$(brightnessctl m)" | bc
	exit 0
elif [[ $1 = "batt" ]]; then
	echo "$(acpi -b | grep "Battery 0" | grep -o '[0-9]\+%' | tr -d '%')"
	exit 0
elif [[ $1 = "lang" ]]; then
	case  "$(ibus engine)" in
		"xkb:us::eng") echo "EN";;
		"libpinyin") echo "拼";;
		"anthy") echo "ち" ;;
	esac
	exit 0
fi

if [[ $1 = "cpu" ]]; then
	val=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
elif [[ $1 = "ram" ]]; then
	val=$(echo "scale=2; $(free -m |grep Mem | awk '{print $3}')/1000" | bc)
	echo $val
	exit 0
#	val=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
elif [[ $1 = "hdd" ]]; then
	val=$(df / | awk 'END{ print $(NF-1) }')
	if [[ $2 = "used" ]]; then
		echo "scale=1; $(df / -Bm --output=used | tail -n 1 | tr -d 'M')/1000" | bc
		exit 0
	elif [[ $2 = "avail" ]]; then
		echo "scale=1; $(df / -Bm --output=avail | tail -n 1 | tr -d 'M')/1000" | bc
		exit 0
	fi
fi
echo "scale=1; ${val%*\%}/1" | bc
