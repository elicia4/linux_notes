# Scheduling with `at`

Let's take a look at scheduling jobs with `at`. It might not be installed:

	which at

If it isn't, install it with your package manager. Create a simple script, we
will run with `at`. Check out the `myscript.sh` script, we will run that one.
Run it and check out the logfile:

	./myscript.sh
	cat job_result.log

Schedule the script to run a couple minutes from your current time:

	at 12:32 -f ./myscript.sh

The stucture is as follows:

	at <time> <file-type> <file-name>

Use full paths when scheduling scripts:

	at 12:32 -f /home/<name>/myscript.sh

Schedule another job at a later time:

	at 12:55 -f /home/name/myscript.sh

To view the jobs in the queue run:
	
	atq

To remove a job:

	atrm <job-id>

Job ID is the number at the beginning of each scheduled task in the `atq`
output. You can also add a date to the at command:

	at <time> <date> <file-type> <file-name>

For example, let's run a command on May 15th, 2023:

	at 12:32 051523 -f /home/name/myscript.sh

Scheduling jobs is incredibly useful.
