#!/bin/bash

dir="~/.config/polybar/colorblocks/scripts/rofi"
remaining_time="$(acpi -b)"
volt=$(cat /sys/class/power_supply/BAT1/voltage_now)
curr=$(cat /sys/class/power_supply/BAT1/current_now)
watt=$(echo "scale=2; ${volt}*${curr}/1000000/1000000" | bc)
msg="${remaining_time##*, }
${watt} W discharging"
rofi -theme "$dir/message.rasi" -e "$msg"
