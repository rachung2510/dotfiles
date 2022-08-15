#!/bin/bash

while true; do
	onedrive --synchronize
	onedrive --synchronize --confdir=~/.config/onedriveimperial
	sleep 300
done
