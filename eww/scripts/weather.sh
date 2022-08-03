#!/bin/bash

if [[ $1 = "location" ]]; then
	## requires API access token
#	ip=$(curl https://ipinfo.io/ip)
#	echo $ip
#	city=$(curl "https://ipinfo.io/$ip" | grep "city" | awk '{print $2}' | grep -oP '(?<=").*(?=")')
#	echo $city
#	region=$(curl https://ipinfo.io/$ip | grep "region" | awk '{print $2}' | grep -oP '(?<=").*(?=")')
#	if [[ $city = $region ]]; then location=$region
#	else location="$city, $region"; fi
	location="Singapore"
	echo $location
	exit 0
fi

loc="$(eww get weather-loc)"
cm1=$(curl wttr.in/$loc?format=%t-%c-%C 2> /dev/null)
IFS="-" read -r temp icon cond <<< "$cm1"

if [[ $icon = "" ]]; then
	icon=""
	temp=""
	cond="Weather data not available"
fi

if [[ $1 = "icon" ]]; then
    echo $icon
elif [[ $1 = "temp" ]]; then
    echo $temp
elif [[ $1 = "cond" ]]; then
	echo $cond
fi
