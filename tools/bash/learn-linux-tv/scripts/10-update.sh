#!/bin/bash

# You can simplify the previous version of the script by using '||', which is
# OR.

release_file=/etc/os-release

if grep -q "arch" $release_file
then
	sudo pacman -Syyu 
fi

# Check if it contains ubuntu OR debian.
if grep -q "ubuntu" $release_file || grep -q "debian" $release_file
then
	sudo apt update
	sudo apt dist-upgrade
fi

