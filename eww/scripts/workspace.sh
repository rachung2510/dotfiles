#!/bin/bash

run() {
	ws_info=$(i3-msg -t get_workspaces)
	LITERAL="(box :class 'bar-widget workspaces' :orientation 'v' :space-evenly 'false' :spacing '3' :width bar-width"
	NUMS=$(echo $ws_info | grep -oP '"num":\s*\K[^\s,]*(?=\s*,)')
	# NAMES=$(echo $ws_info | grep -oP '"name":"*\K[^,]*(?=",)')
	URGENTS=$(echo $ws_info | grep -oP '"urgent":\s*\K[^\s,]*(?=\s*})')
	FOCUSES=$(echo $ws_info | grep -oP '"focused":\s*\K[^\s,]*(?=\s*,)')
	len=$(echo $NUMS | wc -w)
	for i in $(seq 1 $len); do
		NUM=$(echo $NUMS | awk '{print $'$i'}')
		NAME=$(echo $ws_info | grep -oP '"name":"[0-9]\s*\K[^,]*(?=",)' | awk 'FNR == '$i)
		URGENT=$(echo $URGENTS | awk '{print $'$i'}')
		FOCUSED=$(echo $FOCUSES | awk '{print $'$i'}')
		[[ $URGENT = true ]] && MODI="urgent" || MODI=""
		[[ $FOCUSED = true ]] && MODI="focused"
		# MODI=""
		# if [[ $URGENT = true ]]; then MODI="urgent"; fi
		# if [[ $FOCUSED = true ]]; then MODI="focused"; fi
		LITERAL="$LITERAL (ws :num $NUM :name '$NAME' :modi '$MODI')"
	done

	echo "$LITERAL)"
}


run
i3-msg -t subscribe -m '[ "workspace" ]' | while read _; do
	run
done
