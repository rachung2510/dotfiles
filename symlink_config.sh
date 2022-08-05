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
	echo "> $cmd2"
	eval $cmd2
}

if [[ ${1:0:1} = "/" ]] || [[ ${1:0:2} = "~/" ]]; then
	arg=$1
else
	arg="$(pwd)/$1"
fi

if [[ -d $arg ]]; then
	for FILE in $arg/*; do
		echo FILE=$FILE;
		create_symlink $FILE;
		echo "";
	done
elif [[ -f $arg ]]; then
	create_symlink $arg
else
	echo "File does not exist."
fi
