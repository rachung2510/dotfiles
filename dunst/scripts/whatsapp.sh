#!/bin/bash
s=$2
b=$3
content=$(echo $b | grep -oP '(?<=web.whatsapp.com<\/a> ).*')
notify-send -i ~/.config/dunst/img/whatsapp.png "Whatsapp Web" "<i>$s</i>\n$content"
