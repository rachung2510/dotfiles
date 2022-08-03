#!/bin/bash

if [[ $1 = "wifi" ]]; then
	status="$(nmcli radio wifi)"
	if [[ $status = *"enabled"* ]]; then
		echo "selected"
	else
		echo ""
	fi

elif [[ $1 = "bluetooth" ]]; then
	status=$(service bluetooth status | grep "Status:")
	if [[ $status = *"Running"* ]]; then
		echo "selected"
	else
		echo ""
	fi

elif [[ $1 = "notif" ]]; then
	status=$(dunstctl is-paused)
	if [[ $status = "false" ]]; then
		echo ""
	else
		echo "selected"
	fi

elif [[ $1 = "mute" ]]; then
	mute=$(amixer -D pulse sget Master | grep 'off')
	if [[ $mute != "" ]]; then echo "true";
	else echo "false"; fi
fi