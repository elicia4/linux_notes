# Arguments

[***go back to contents***](01-contents.md)

You can supply arguments to a script on the command line. Try the following
script:

	#!/bin/bash

	echo "You entered the argument: $1"

The script will output the first word (or argument) you wrote after the script:

	./myscript.sh Hello!
	
	>You entered the argument: Hello!

You can have more than one argument. `$1` is the first argument, `$2` is the 
second, `$3` is the third and so on:

	#!/bin/bash

	echo "You entered the arguments: $1, $2, $3, and $4."

Let's take a look at another script:

	ls -lh $1

Run it like this to list the contents of the `/etc` directory:

	./myscript.sh /etc

Imagine you have to make a backup script. You might want to give it an argument
that is a path that you want to back up.

You can use arguments in many places throughout your scripts:

	lines=$(ls -lh $1 | wc -l)

    echo "You have $(($lines-1)) objects in the $1 directory."

`wc -l` counts the number of lines. You substruct one from the number of 
objects because the output of `ls -lh` includes a line at the top of its output
that is not (obviously) an object itself. 

The script above allows you to run it with no arguments. You should limit that.
The `$#` represents the number of arguments you passed to the script:

	#!/bin/bash

	lines=$(ls -lh $1 | wc -l)

	# the number of arguments passed to this script should be exactly 1.
	# if it's not 1, print the error messages and exit the script.
	if [ $# -ne 1 ]
	then
		echo "This script requires exactly one directory path passed to it."
		echo "Please try again."
		exit 1
	fi
	echo "You have $(($lines-1)) objects in the $1 directory."

This script will output error messages in case there is more than one argument,
which is the right thing to do in this case.

[***Go to Next Note***](17-backup.md)
