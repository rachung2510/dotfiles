#!/bin/bash

DIR=$HOME/.config/i3/scripts/wsnaming
CONF=$DIR/wsconfig.ini
THIS=$DIR/`basename "$0"`
rofi_cmd="rofi -theme ~/.config/rofi/setwsname.rasi"
reload_cmd="python -c 'import sys; sys.path.append(\""$DIR"\"); import i3_workspace_names_daemon as daemon; daemon.run(\""$CONF"\")'"

# 1st dialog: choose workspace
ws_info=$(i3-msg -t get_workspaces)
NAMES=$(echo $ws_info | grep -oP '"name":"\s*\K[^,]*(?=",)')
NAMES="$NAMES\nunset all"
FOCUSES=($(echo $ws_info | grep -oP '"focused":\s*\K[^\s,]*(?=\s*,)'))
sel=$(echo ${FOCUSES[@]/true//} | cut -d/ -f1 | wc -w)
choice1=$(echo -e "$NAMES" | $rofi_cmd -dmenu -auto-select -p "ws:" -selected-row $sel)
[[ $choice1 = "" ]] && exit 0
if [[ $choice1 = "unset all" ]]; then
	for i in $(seq 1 10); do sed -i $(($i+1))'s/.*/'$i' = auto/' $CONF; done
	eval $reload_cmd
	exit 0
fi
wsnum=$(echo $choice1 | awk '{print $1}')

# icon dialog options
deficon=$(grep "ws${wsnum} =" $CONF | awk '{print $NF}')
options="\
auto
default - $deficon
terminal - 
window - 
browser - 
note - 
chat - 
game - 
music - 
email - 
video - 
files - 
draw - 
excel - 
virtual mgr - 
telegram - 
youtube - "

# get selected icon
icon=$(grep "$wsnum " $CONF | awk '{print $NF}')
if [[ $icon = "auto" ]]; then
	sel=0
else
	ln1=$(grep -P "^auto" -n $THIS | awk -F ':' '{print $1'})
	ln2=$(grep -P "^$icon" -n $THIS | awk -F ':' '{print $1'})
	sel=$(($ln2-$ln1))
fi

# 2nd dialog: choose icon
choice2=$(echo "$options" | $rofi_cmd -dmenu -p "icon:" -selected-row $sel)
[[ $choice2 = "" ]] && exit 0
newname=$(echo $choice2 | awk '{print $1}')
newicon=$(echo $choice2 | awk -F' ' '{print $NF}')
[[ $newname = "" ]] || [[ $newname = "auto" ]] && newicon=""

# rename through i3ipc
python $DIR/wsrename.py -n $wsnum -i $newicon

# update config
sed -i $(($wsnum+1))'s/.*/'$wsnum' = '$newname'/' $CONF
[[ $newname = "auto" ]] && eval $reload_cmd
