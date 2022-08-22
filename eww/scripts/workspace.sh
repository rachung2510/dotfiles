#!/bin/bash

run() {
	ws_info=$(i3-msg -t get_workspaces)
	LITERAL="(box :class 'bar-widget workspaces' :orientation 'v' :space-evenly 'false' :spacing '3' :width bar-width"
	NUMS=($(echo $ws_info | grep -oP '"num":\s*\K[^\s,]*(?=\s*,)'))
	NAMES=($(echo $ws_info | grep -oP '"name":"[0-9]*\s*\K[^,]*(?=",)'))
	URGENTS=($(echo $ws_info | grep -oP '"urgent":\s*\K[^\s,]*(?=\s*})'))
	FOCUSES=($(echo $ws_info | grep -oP '"focused":\s*\K[^\s,]*(?=\s*,)'))
	len=${#NUMS[@]}
	for i in $(seq 0 $((len-1))); do
		# t1=$(date +%s%3N)
		NUM=${NUMS[$i]}
		# t2=$(date +%s%3N)
		NAME=${NAMES[$i]}
		# t3=$(date +%s%3N)
		URGENT=${URGENTS[$i]}
		# t4=$(date +%s%3N)
		FOCUSED=${FOCUSES[$i]}
		# t5=$(date +%s%3N)
		[[ $URGENT = true ]] && MODI="urgent" || MODI=""
		[[ $FOCUSED = true ]] && MODI="focused"
		LITERAL="$LITERAL (ws :num $NUM :name '$NAME' :modi '$MODI')"
	done

	echo "$LITERAL)"
}

get_scratch() {
	echo "$(i3-msg -t get_tree | grep -oP '"scratchpad_state":"(?!none).*?"' | wc -l)"
}

if [[ $1 = "" ]]; then
	run
	i3-msg -t subscribe -m '[ "workspace" ]' | while read _; do
		run
	done
elif [[ $1 = "scratch" ]]; then
	get_scratch
	i3-msg -t subscribe -m '[ "window" ]' | while read _; do
		get_scratch
	done
fi
