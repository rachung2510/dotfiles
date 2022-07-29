#!/bin/bash

dir="~/.config/polybar/colorblocks/scripts/rofi"
var="$(acpi -b)"
msg="${var##*,}"
rofi -theme "$dir/message.rasi" -e "$msg"
