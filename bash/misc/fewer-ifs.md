# Never say "If" writing a Bash script! 
### (Exit codes & logical operators)

Notes on the video by Luke Smith: https://youtu.be/p0KKBmfiVl0

```
<command> && <command> 
```

Runs the second command only if the first command succeeded.

This will run only the first command:

	cat .file-that-doesnt-exist && echo "this won't run"

This will run both commands (if you have the '.bashrc' file of course):

	cat .bashrc && echo "both commands ran successfully"

```
<command> || <command> 
```

Runs the seconds command only if the first command DIDN'T succeed.

This will run both commands (first fails, will run the second after):

	cat .file-that-doesnt-exist || echo "first failed, second command ran"

This will run the first command only:

	cat .bashrc || echo "this won't run"

```
<command> ; <command> 
```

semicolon means: run a command, wait until it executes, run a command.

	echo "Hello there." ; echo "General Kenobi!"

semicolon is basically the same thing as having a new line.

```
<command> & <command> 
```

`&` starts both commands at the same time.

Let's take a look at a script you can optimize with these commands, take a look 
at the following script:

```    
#!/bin/sh
if [ "$EDITOR" = "" ]; then
    EDITOR=nano
fi
echo $EDITOR
```

You can use `-z` with strings (checks whether a variable contains nothing).  
You can use `&&` to get rid of the if statement (since the editor is unset, the 
command succeeds, therefore the second command is run).

```
#!/bin/sh
[ -z "$EDITOR" ] && EDITOR=nano
```

Another example, let's say you have a series of functions you want to run
sequentially, and run some other command, `cfail` in this case, if one of them
fails:

	c1 && c2 && c3 && c4 || cfail

If all four commands run successfully, `cfail` won't run.  
If ANY one of the four commands fails, `cfail` will run.

An interesting comment:
>I think the use of logical operators  instead of "if" statements makes sense 
>when working in a terminal. In a bash script I want others (and future me) to
>understand the code on first glance, an if statement inherently does this
>because it is the de facto way of controlling flow in most languages.  
> -- <cite>Remi Niël</cite>
