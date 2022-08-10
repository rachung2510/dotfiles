#!/bin/bash

run() {
	mode=$(i3-msg -t get_binding_state | jq '.[]')
	[ $mode = \"default\" ] && echo ""
	[ $mode = \"resize\" ] && echo -e "resz"
}

run
i3-msg -t subscribe -m '[ "mode" ]' | while read _; do
	run
done
