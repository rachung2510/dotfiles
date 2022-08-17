#!/usr/bin/env bash
ROFIDIR="$HOME/.config/rofi"

# Options
shutdown=''
reboot=''
lock=''
suspend=''
logout=''

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $ROFIDIR/confirm.rasi
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

pkill cava && eww close sidebar 2> /dev/null
chosen="$(echo -e "$options" | rofi -theme $ROFIDIR/powermenu.rasi -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl poweroff
		else
			exit 0
		fi
	;;
    $reboot)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
		else
			exit 0
        fi
	;;
    $lock)
		~/.config/i3/scripts/poweractions.sh "lock"
	;;
    $suspend)
		~/.config/i3/scripts/poweractions.sh "sleep"
	;;
    $logout)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			~/.config/i3/scripts/poweractions.sh "exit"
		else
			exit 0
        fi
	;;
esac
