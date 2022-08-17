#!/bin/bash
DUNST="~/.config/dunst"
TAG="fn"

# $1=icon, $2=value, $3=summary
alert() {
	notify-send -u "low" -i "$DUNST/img/$1.png" -h int:value:$2 -h string:x-dunst-stack-tag:$TAG "Current $3: $2%"
}

if [[ $1 = "vol" ]]; then
	val="$(bash ~/.config/eww/scripts/getval.sh vol)"
	eww update volume-val=$val
	eww update mute-bool=$(bash ~/.config/eww/scripts/getbool.sh mute) &&
	eww update vol-icon=$(bash ~/.config/eww/scripts/geticon.sh vol) &&
	alert "volume-$2" $val "volume"

elif [[ $1 = "mute" ]]; then
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	eww update mute-bool=$(bash ~/.config/eww/scripts/getbool.sh mute) &&
	eww update vol-icon=$(bash ~/.config/eww/scripts/geticon.sh vol) &&
	eww update vol-literal="$(eww get vol-literal)"
	if [[ $2 != "notify" ]]; then exit 0; fi
	val="$(bash ~/.config/eww/scripts/getval.sh vol)"
	if [[ $(pactl get-sink-mute @DEFAULT_SINK@) = "Mute: yes" ]]; then
		notify-send -u "low" -i "$DUNST/img/volume-mute.png" -h int:value:$val -h string:x-dunst-stack-tag:$TAG "Speakers muted"
	else
		notify-send -u "low" -i "$DUNST/img/volume-up.png" -h int:value:$val -h string:x-dunst-stack-tag:$TAG "Speakers unmuted"
	fi

elif [[ $1 = "light" ]]; then
	val="$(bash ~/.config/eww/scripts/getval.sh light)"
	eww update light-val=$val
	eww update light-icon="$(bash ~/.config/eww/scripts/geticon.sh light)"
	alert "brightness-$2" $val "brightness"
fi
