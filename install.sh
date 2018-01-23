#!/bin/bash

for entry in ./symlink/*
do
	filename=${entry:10} # ${parameter:offset} (substring)
	if [[ -e ~/."$filename" ]]; then # if $filename exists
		mv ~/."$filename" ~/."$filename".backup # Save original file
	fi
	ln -s "$PWD"/symlink/"$filename" ~/."$filename" # Create link to ./symlink/$filename
done
