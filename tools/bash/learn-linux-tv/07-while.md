# While Loops 

[***go back to contents***](01-contents.md)

1. While loops allows us to continuously do something until a certain condition
   is met. For example:

   ```
   #!/bin/bash
   # declare variable as 1
   myvar=1
   # while myvar is less than or equal 10, do the things in the body
   while [ $myvar -le 10 ]
   # this is the body
   do
      # output current value of myvar, increment(increase by 1) myvar,
      # sleep for half a second
      echo $myvar
      myvar=$(( $myvar + 1 ))
      sleep 0.5
   done
   ```

   The script above will run until `myvar` is 10.

2. This will run for as long as `testfile` exists:

    ```
    #!/bin/bash
    
    myvar=1
    
    while [ -f ~/testfile ]
    do
        echo "The test file exists."
		# sleep 3
    done
   
    echo "The file no longer exists. Exiting."
    ```
    It makes sense to run `sleep 3` after the `echo "The test file exists"`.

3.  Let's make the script a bit more useful:

    ```
    #!/bin/bash

    myvar=1

    while [ -f ~/testfile ]
    do
        echo "As of $(date), the test file exists."
	sleep 5
    done
   
    echo "As of $(date), the file no longer exists. Exiting."
    ```

4. `$(<command>)` is called a subshell.

[***Go to Next Note***](08-update-script.md)
