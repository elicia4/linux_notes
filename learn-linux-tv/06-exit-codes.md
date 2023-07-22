# Exit Codes

1. Exit codes allow us to determine whether a command was successful or not.

2. To determine last command's exit code, use `$?`

3. A `0` exit code means success, any other value means failure. Try running
   any command with determined results, one success and one failure, run `echo
   $?` after each one to see their exit codes for yourself.

4. Keep track of commands you're running, if you want to do something with the
   exit code of a command, make sure that no command runs after it OR that you
   store the needed command's exit code somewhere. For instance, imagine you're
   running the following script:

   ```
   if [ -d /non-existant-folder ]
   then
        echo "the dir. exists"
   fi

   echo "The exit code for this script is $?."
   ```

   What exit code do you think will be displayed at the end? If you guessed
   that it's `0`, you're correct. Despite the fact that the directory doesn't
   exist and the test command failed (therefore the exit code should be
   non-zero), the output is `0`, since the `echo` statement succeeded. Make
   sure you're checking for the exit code at the appropriate time.

5. You can manipulate exit codes with the `exit <number>` command. Run the
following script:

   ```
   echo "Hello World!"
   exit 1
   ```
	
   If you type `echo $?` after executing the script, the output will be `1`,
   even thought the command succeeeded. You can do the opposite too, running a
   command that will fail and setting the exit code to `0` :)  Note that
   nothing will run after the exit command.

6. By setting your own exit codes you can manipulate your scripts in different
   ways.
