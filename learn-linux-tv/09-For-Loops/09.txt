###############################################################################
								FOR LOOPS
###############################################################################
1. A for loop allows you to perform a task repeatedly for every item in a set.
2. An if statement does a task once if a set of conditions evaluates as true,
whereas a while loop performs a set of tasks until a particular state is
reached. A for loop is a concept of executing a command or set of commands
against each item is a set.
3. Let's take a look at the following script:

		#!/bin/bash

		for current_number in 1 2 3 4 5 6 7 8 9 10
		# below is the 'body' of the for loop
		do
			echo $current_number
			sleep 0.25 # In the guide it's 1 instead of 0.25, this will execute
			# four times faster
		done
		# end of body
		echo "This is outside the for loop."

It iterates through a set of numbers, 1 through 10, doing the 'body'. It stops 
when the list of numbers ends.
4. You can substitute 1 through 10 as {1..10}.
5. You can substitute current_number for n.
6. Let's take a look on another script. Be careful what you run this script
against:

		#!/bin/bash

		for file in logfiles/*.log
		do
			tar -czvf $file.tar.gz $file
		done

For every file in logfiles directory that ends with .log, it's going to run the
tar command with options "czvf" (v stands for verbose to see what we're doing) 
in order to create a tarball(compressed file) for every log file. 
7. Create the folder and get some log files into it.

		mkdir logfiles
		cp /var/log/*.log logfiles/

Also create a random file inside the folder that won't match the criteria.

		touch logfiles/random.txt

8. Try the script out! It's quite useful, run 'ls -l' after and look
at the file sizes. It seems like a reasonable idea to tar log files and delete
the original files to save up disk space. (or any files that take up a lot of
space)

