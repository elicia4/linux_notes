#!/bin/bash

release_file=/etc/os-release
# two new variables
logfile=/var/log/updater.log
errorlog=/var/log/updater_errors.log

if grep -q "arch" $release_file
then
	# append SO to updater.log and SE to updater_errors.log
	sudo pacman -Syyu --noconfirm 1>>$logfile 2>>$errorlog
	# if an error occurred (errorcode non-zero)
	if [ $? -ne 0 ]
	then
		echo "An error occurred, please check the $errorlog file."
	fi
fi

if grep -q "ubuntu" $release_file || grep -q "debian" $release_file
then
	# append SO to updater.log and SE to updater_errors.log
	sudo apt update 1>>$logfile 2>>$errorlog
	# if an error occurred (errorcode non-zero)
	if [ $? -ne 0 ]
	then
		echo "An error occurred, please check the $errorlog file."
	fi
	sudo apt dist-upgrade -y 1>>$logfile 2>>$errorlog
	# if an error occurred (errorcode non-zero)
	if [ $? -ne 0 ]
	then
		echo "An error occurred, please check the $errorlog file."
	fi
fi

