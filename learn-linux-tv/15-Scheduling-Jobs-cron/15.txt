You can schedule jobs with cron, which is actually the most popular way. Use 
the same script.

You should use fully qualified commands in your scripts. For example, instead
of:

	echo "123"

Do:
	
	/usr/bin/echo "123"

To find the full path to the needed command use:

	which <command>

It is considered a bad practice to not include the full path to the command.
There's two reasons for this: security and your path variable. Your path 
variable may not be set up the way it is on other systems and environments, and
it might not be able to find the commands. If you use a simple 'echo' in your
script, the script might not work and fail. Regarding security, imagine that a
malicious user creates a script called 'echo' and puts it somewhere. The script
might run that instead of the needed 'echo' program and damage your system.

To schedule jobs with cron:

	crontab -e

Add a line like this:

	30 1 * * 5 /usr/local/bin/script
	# m h dom mon dow command

m means minute, h means hour, dom means day of the month, mon means month, dow 
means day of the week. The line above will run the script every friday at 1:30.

To edit a crontab for another user:

	sudo crontab -u username -e 
