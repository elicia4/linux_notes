## Hello World

[***go back to contents***](01-contents.md)

1. Bash is a shell.

    Any time you enter the terminal and enter commands, you interact with the 
shell. It allows you to enter commands and presents to you results of those 
commands. The shell allows you to work with the system via commands.

2. To find out what shell you're using, type:  

    ```
	echo $SHELL
    ```

   To search for the bash environment variable and display its location, type:  

    ```
	which bash
    ```

   To run a shell, input its absolute path into the terminal, for example:  

    ```
	/usr/bin/bash
    ```

3. Make a file executable:

    ```
	chmox +x file_name
    ```

4. You don't have to use an extension after the name, for example in `123.sh`
   the `sh` part isn't necessary. You can name your scripts anything.

5. Use shebang at the beginning of your scripts:

    ```
	#!/bin/bash
    ```

    It tells your script what interpreter it should use to run your script.

---

Let's write a simple script:

```
#!/bin/bash
   
# pwd

echo "Hello World!"
echo "My current working directory is:"
pwd
```

Lines started with the `#` symbol are ignored, you can write anything on these
lines, they will be ignored by the interpreter. 

[***Go to Next Note***](03-variables.md)
