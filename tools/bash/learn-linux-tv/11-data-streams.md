# Data Streams:

[***go back to contents***](01-contents.md)

- Standard Input
- Standard Output
- Standard Error

Data streams allow us to control where normal output goes as well as where 
errors are printed. They allow us to accept input from the user as well. This
concept is very important Linux-wide.

`ls` command is an example of Standard Output. Whenever we execute a command,
and the results of that command get printed onto the screen, it is Standard
Output.  Standard Ouput is output that is printed on the screen that doesn't
constitute an error. To tell the difference between Standard Output (SO) and
Standard Error (SE):

    echo $?

Non-zero = SE, zero = SO. Let's take a look at an example of both SO and SE.
Use the `find` command, which allows you to find directories or files with a
search criteria:

    find /etc -type f 

It will return every object that is a file. There are many many SO results as
well as SE results (i.e. permisson denied results). 

To distinguish between SO and SE:

    find /etc -type f 2> /dev/null

No SE results appeared. `>` redirects stuff to a file. `/dev/null` is a special
place, everything you redirect to it gets completely wiped out. Think of it as a
black hole. `2` means all error results, any output that constitutes SE. Let's
try something else:

    find /etc -type f > /dev/null

Only the SE results appeared. Only Standard Output was sent to `/dev/null`. 
Another example:

    find /etc -type f 1> /dev/null

This will yield the same result. 1 = SO, 2 = SE. To send both to a file:

    find /etc -type f &> file.txt

You can send SO to one file and SE to another file:

    find /etc -type f 1> output.txt 2> error.txt

Let's add stuff to the `update.sh` script.

The following command shows the files updating in (almost) real time:

	tail -f <filename>

Take a look at another script `myscript.sh`.

[***Go to Next Note***](12-functions.md)
