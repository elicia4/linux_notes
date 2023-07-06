## Variables

1. Variable structure:

    ```
	myname="John"
    ```
	
	`<name>` -> `=` -> `content`  
	No spaces!
	
2. You can declare variables right on the command line, there isn't much
   difference between entering commands on the command line and adding commands
   to a script.

3. Use `$` before variable name to echo it, e.g.:
    
    ```
	echo $myname
    ```

   Bash treats names written after `$` as variables.
   
4. When you declare a variable in bash, it's tied to the session it was
   declared in. If you terminate the session, the variable will be gone.  

5. If single quotes are used for strings, contents of the variables will not be
   printed.

6. You can store output of commands in variables, e.g.:

    ```
	files=$(ls)
    ```
	
    `$()` is called a subshell.
	
7. Within your environment, there are already variables that are declared,
   `$USER` is one of those, it contains the name of the user you're currently
   logged in as. Variables like `$USER` are called system variables or
   environment variables.

8. It is a good practice to declare variables in lower case.

9. To find out what variables are defined:

    ```
    env
    ```

Let's write a script:

    #!/bin/bash
    
    myname="John"
    myage="30"
    
    echo "Hello, my name is $myname."
    echo "I am $myage years old."
    echo 'I am $myage years old.'
    
    word="great"
    
    echo "Linux is $word"
    echo "Videogames are $word"
    echo "Sunny days are $word"
    
    files=$(ls)
    echo "The contents of current directory are:"
    echo $files
    
    now=$(date)
    
    echo "The system time and date is:"
    echo $now
    
    name="Jay"
    now=$(date)
    echo "Hello $name"
    echo "The system time and date is:"
    echo $now
    echo "Your username is: $USER"
