#!/bin/bash

# there is a file on the majority of Linux distributions (or all of them) that
# has information on what distribution is currently running. It's called:
# /etc/os-release
release_file=/etc/os-release

# checks if release-file contains 'arch', if it does, it's Arch
# grep looks for the word 'arch' inside the release_file
if grep -q "arch" $release_file
then
	sudo pacman -Syyu 
fi

# checks if release-file contains 'ubuntu', if it does, it's Ubuntu 
if grep -q "ubuntu" $release_file
then
	sudo apt update
	sudo apt dist-upgrade
fi

# checks if release-file contains 'debian', if it does, it's Debian
if grep -q "debian" $release_file
then
	sudo apt update
	sudo apt dist-upgrade
fi

# Note to the video: I made 'ubuntu' and 'arch' lowercase on purpose, it allows
# the grep command to work with the ID_LIKE variable from the 'os-release'
# file, take a look at the file, you will understand.
