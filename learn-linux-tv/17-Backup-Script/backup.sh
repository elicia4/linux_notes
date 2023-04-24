#!/bin/bash

# Check to make sure that the user has entered exactly two arguments.
if [ $# -ne 2 ]
then
	echo "Usage: backup.sh <source_directory> <target_directory>"
	echo "Please try again."
	exit 1
fi

# Check to see if rsync is installed.
# ALL output will be sent to /dev/null. I'd use &> instead of > and 2>&1, but
# this is the way it was in the original script.
if ! command -v rsync > /dev/null 2>&1
then
	echo "This script requires rsync to be installed."
	echo "Please use your distribution's package manager to install it and \
try again."
	exit 2
fi

# Capture the current date, and store it in the format YYYY-MM-DD
# This type of format is chosen because it can be easily sorted 
# alphanumerically.
current_date=$(date +%Y-%m-%d)

# -a is archive mode it tries to retain all the metadata like permissions, 
# -v is verbose, -b means that you would rather not have files replaces on the
# target. What rsync does is sync one directory to another. If you get update a
# file, the previous version will not be deleted in the destination folder.
# --backup-dir makes it so a backup file is copied somewhere else, in this case
# to $2/$current_date. --delete will delete files that are not present on the
# source, but you will still have them, since you back up previous versions
# anyway, since you have the '-b' option. --dry-run is the most important
# option of them all, it only creates a simulation of what would happen if you
# ran the command, with verbose it's going to tell you exactly what it does. It
# is a very useful thing to do when you are afraid of damaging your system.
# Always do a dry run before running something like this, watch what the
# command actually does closely and then if everything is correct run the 
# command. With dry-run, it's only a pretend back-up. MAKE SURE TO REMOVE DRY
# RUN AFTER TESTING. Your logs will be fine, but nothing will actually happen.
# In production, always test first and if all's good remove the dry run option
# later.
rsync_options="-avb --backup-dir $2/$current_date --delete --dry-run" 

# the current option will be stored in the current subdir, the backups will be 
# stored in their respective folders.
$(which rsync) $rsync_options $1 $2/current >> backup_$current_date.log

