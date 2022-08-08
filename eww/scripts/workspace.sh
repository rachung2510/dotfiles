#!/bin/bash

run() {
	ws_info=$(i3-msg -t get_workspaces)
	LITERAL="(box :class 'bar-widget workspaces' :orientation 'v' :space-evenly 'falsie' :spacing '3' :width bar-width"
	len=$(echo $ws_info | jq 'length')
	NUMS=$(echo $ws_info | jq '.[] | .num')
	NAMES=$(echo $ws_info | jq '.[] | .name')
	URGENTS=$(echo $ws_info | jq '.[] | .urgent')
	FOCUSES=$(echo $ws_info | jq '.[] | .focused')
	for i in $(seq 1 $len); do
		NUM=$(echo $NUMS | awk -F' ' '{print $'$i'}')
		NAME=$(echo ${NAMES//\"/} | awk -F' ' '{print $'$(( i*2 ))'}')
		URGENT=$(echo $URGENTS | awk -F' ' '{print $'$i'}')
		FOCUSED=$(echo $FOCUSES | awk -F' ' '{print $'$i'}')
		MODI=""
		if [[ $URGENT = true ]]; then MODI="urgent"; fi
		if [[ $FOCUSED = true ]]; then MODI="focused"; fi
		LITERAL="$LITERAL (ws :num $NUM :name '$NAME' :modi '$MODI')"
	done

	echo "$LITERAL)"
}


run
i3-msg -t subscribe -m '[ "workspace" ]' | while read _; do
	run
done
