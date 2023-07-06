#!/bin/bash

myvar=1

while [ -f ~/testfile ]
do
	echo "As of $(date), the test file exists."
	sleep 5
done

echo "As of $(date), the file no longer exists. Exiting."
