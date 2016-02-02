#!/bin/bash

for entry in ./symlink/*
do
	filename=${entry:10}
	if [[ -e ~/."$filename" && -e ~/."$filename".backup ]]; then # if $filename and its backup exist
		mv ~/."$filename".backup ~/."$filename" # Restore backup file
	fi
done
