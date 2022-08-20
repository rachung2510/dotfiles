#!/bin/bash

GTK3CONF="$HOME/.config/gtk-3.0/settings.ini"
GTK2CONF="$HOME/.gtkrc-2.0"
EWWCONF="$HOME/.config/eww/eww.scss"
ALACONF="$HOME/.config/alacritty/alacritty.yml"
I3CONF="$HOME/.config/i3/config"
ROFICONF="$HOME/.config/rofi/styles/colors.rasi"

if [[ -f $GTK3CONF ]]; then
	theme=$(grep "gtk-theme-name" $GTK3CONF | cut -d "=" -f2)
	[[ "${theme,,}" = *"dark"* ]] && uu="Dark" || uu="Light"
else
	uu="Light"
fi
ll="$(echo $uu | tr '[:upper:]' '[:lower:]')"
[[ $1 = "-p" ]] && echo "$ll" && exit 0

DARK=""
LIGHT=""
[[ $ll = "light" ]] && SELECTED=0 || SELECTED=1
chosen=$(echo -e "$LIGHT\n$DARK" | rofi -dmenu -selected-row $SELECTED -theme ~/.config/rofi/theme.rasi)

case $chosen in
	$DARK)
		uu=Dark
		ll=dark
	;;
	$LIGHT)
		uu=Light
		ll=light
	;;
esac

feh --bg-scale ~/.config/i3/wallpapers/$ll-wallpaper.jpg
sed -i -e "s:@import .*:@import \"styles/$ll.scss\";:g" $EWWCONF
sed -i -e "s/gtk-theme-name=.*/gtk-theme-name=Orchis-Purple-$uu/g" $GTK2CONF
sed -i -e "s/gtk-theme-name=.*/gtk-theme-name=Orchis-Purple-$uu/g" $GTK3CONF
sed -i -e "s:config/alacritty/.*:config/alacritty/$ll.yml:g" $ALACONF

sed -i -e "s/@import .*/@import \"$ll\"/g" $ROFICONF

inactive_bg=$(grep "inactive-bg-$ll" $I3CONF | awk '{print $3}')
inactive_text=$(grep "inactive-text-$ll" $I3CONF | awk '{print $3}')
sed -i -e "s/set \$inactive-bg.*/set \$inactive-bg\t\t$inactive_bg/g" $I3CONF
sed -i -e "s/set \$inactive-text.*/set \$inactive-text\t\t$inactive_text/g" $I3CONF

pkill polkit-gnome-au
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
i3-msg reload
