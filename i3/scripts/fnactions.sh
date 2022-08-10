#!/bin/bash
DUNST="~/.config/dunst"
TAG="fn"

# $1=icon, $2=value, $3=summary
alert() {
	dunstify -u "low" -i "$DUNST/img/$1.png" -h int:value:$2 -h string:x-dunst-stack-tag:$TAG "Current $3: $2%"
}

if [[ $1 = "vol" ]]; then
	val=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '(?<=/  ).*?(?=%)' | head -n 1)
	eww update volume-val="$(bash ~/.config/eww/scripts/getval.sh vol)"
	alert "volume-$2" $val "volume"

elif [[ $1 = "mute" ]]; then
	pactl set-sink-mute @DEFAULT_SINK@ toggle
    eww update vol-icon=$(bash ~/.config/eww/scripts/geticon.sh vol) &&
    eww update mute-bool=$(bash ~/.config/eww/scripts/getbool.sh mute) &&
    eww update vol-literal="$(eww get vol-literal)"
	if [[ $2 != "notify" ]]; then exit 0; fi
	val=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '(?<=/  ).*?(?=%)' | head -n 1)
	if [[ $(pactl get-sink-mute @DEFAULT_SINK@) = "Mute: yes" ]]; then
		dunstify -u "low" -i "$DUNST/img/volume-mute.png" -h int:value:$val -h string:x-dunst-stack-tag:$TAG "Speakers muted"
	else
		dunstify -u "low" -i "$DUNST/img/volume-up.png" -h int:value:$val -h string:x-dunst-stack-tag:$TAG "Speakers unmuted"
	fi

elif [[ $1 = "light" ]]; then
	val=$(echo "100*$(brightnessctl g)/$(brightnessctl m)" | bc)
	eww update light-val="$(bash ~/.config/eww/scripts/getval.sh light)"
	eww update light-icon="$(bash ~/.config/eww/scripts/geticon.sh light)"
	alert "brightness-$2" $val "brightness"
fi
