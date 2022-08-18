#!/bin/bash

create_symlink() {
	file=$1
	filename=${file##*/}
	filedir=${file%/*}
	dir=$(echo $filedir | grep -oP "(?<=.config/).*")
	linkdir="/home/$USER/dotfiles"
	link="$linkdir/$dir/$filename"
	cmd1="mkdir -p $linkdir/$dir"
	cmd2="ln $file $link"

	#echo file=$file
	#echo filename=$filename
	#echo filedir=$filedir
	#echo dir=$dir
	#echo link=$link

	if [[ ! -d $linkdir/$dir ]]; then
		echo "> $cmd1"
		eval $cmd1
	fi
	[[ -f $link ]] && echo "> Link already exists. rm $link" && rm $link
	echo "> $cmd2"
	eval $cmd2
}

parse_dir() {
	if [[ -d $1 ]]; then
		echo -e "\nDIR=$1"
		for FILE in $1/*; do parse_dir $FILE; done
	elif [[ -f $1 ]]; then
		echo FILE=$1;
		create_symlink $1;
	else
		echo "File does not exist."
	fi
}

if [[ ${1:0:1} = "/" ]] || [[ ${1:0:2} = "~/" ]]; then
	arg=$1
else
	arg="$(pwd)/$1"
fi

arg=$(echo $arg | sed "s:/$::")
parse_dir $arg
echo ""
