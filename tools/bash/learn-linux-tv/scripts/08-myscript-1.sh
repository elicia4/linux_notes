#!/bin/bash

# checks for the existance of the pacman.d directory that is unique to arch
if [ -d /etc/pacman.d ]
then
	#the host is based on Arch, run the pacman update command
	sudo pacman -Syyu # -Syyu is different from the video
	# Passing two -y flags will force a refresh of all package 
	# databases, even if they appear to be up-to-date.
fi

# checks for the existance of the apt directory that is unique to debian/ubuntu
if [ -d /etc/apt ]
then
	# the host is based on Debian or Ubuntu,
	# run the apt version of the command
	sudo apt update
	sudo apt dist-upgrade
fi
