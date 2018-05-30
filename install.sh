#!/bin/bash

# Place dotfiles that should be installed in symlink

# Create backup dir where we'll store previous dotfiles
mkdir -p ~/.dotfiles_backup

# Loop on all the files to be moved to your home folder
for entry in ./symlink/*; do
	# Extract filename from full path (https://linuxgazette.net/18/bash.html)
	filename=${entry##*/}

	# If $filename (original file) exists and is not a symlink
	if [[ -e ~/."$filename" && ! -h ~/."$filename" ]]; then
		# Save original file to backup folder
		mv ~/."$filename" ~/.dotfiles_backup/"$filename"
	fi

	# If ~/.filename is not a symbolic link
	if [[ ! -h ~/."$filename" ]]; then
		# Create a link to ./symlink/$filename
		ln -s "$PWD"/symlink/"$filename" ~/."$filename"
	fi
done
