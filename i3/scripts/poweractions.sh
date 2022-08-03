#!/bin/bash

bg=00000080
shade4=8e24aa
shade8=ce93d8
urgent=eb4d4b
ver=4834d4
ver_ring=6c5ce7
fg=f9f9f9
alpha=ffffff00
font="Iosevka Nerd Font"

pw="root"

disable_bluetooth(){
	# bluetooth.service must be disabled (sudo systemctl disable bluetooth)
	echo $pw | sudo -S service bluetooth stop
	eww update bluetooth_bool=$(bash scripts/getbool.sh bluetooth) &&
	eww update bluetooth-literal="$(eww get bluetooth-literal)"
}

if [[ $1 = "lock" ]]; then
	pkill cava && eww close-all
	playerctl -p playerctld pause
	i3lock -c $bg -k --radius=100 --ring-width=20 --ring-color=$shade8 --ringwrong-color=$urgent --keyhl-color=$shade4 --separator-color=$alpha \
		--time-color=$fg --date-color=$fg --verif-color=$fg --wrong-color=$fg \
		--ringver-color=$ver_ring --insidever-color=$ver \
		--line-color=$alpha \
		--time-font=$font --date-font=$font --verif-size=24 \
		--layout-font=$font --verif-font=$font --wrong-font=$font

elif [[ $1 = "sleep" ]]; then
	pkill cava && eww close-all
	amixer set Master mute
	disable_bluetooth &&
	./poweractions.sh "lock"
	systemctl suspend

elif [[ $1 = "exit" ]]; then
	i3-msg exit
fi
