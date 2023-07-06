Where exactly should you store all your scripts?

Storing your scripts in your home directory is not a good idea if you need
somebody else to run it. If your script performs an important business 
function, your coworkers won't be able to run it. For that reason (and some 
other reasons), it's better to have a central location to run your scripts.

Take a look at FHS (Filesystem Hierarchy Standard):

	https://wiki.linuxfoundation.org/lsb/fhs

It exists to clarify what the purpose is of typical directories found on most
or all distributions of Linux.

The FHS document points out the '/usr/local/' directory for locally installed
programs that sysadmins use. Specifically, the ./bin directory is where you
should store your scripts. As an added bonus, when you use commands it will
look in that directory anyway, so you don't actually have to run your scripts
from a specific folder, you can run them anywhere.

	sudo mv update.sh /usr/local/bin/update

You should probably assign root user and group to it, so that a user cannot
modify it:

	sudo chown root:root /usr/local/bin/update

Check if it went well with:

	ls -l /usr/local/bin/update

Why drop the .sh? It's not required. File extensions are not required in Linux
at all. You can use them to clarify stuff.

To find out where a particular binary or script is located, run:

	which <binary-name>

In our case:

	which update

So why does running update from anywhere actually work? There is a very special
variable called $PATH which contains all of the directories that can 
potentially store binaries or scripts the shell can run. Take a look at it:

	echo $PATH

It contains a list of paths separated by a colon. To look at all your 
environment variables:

	env

Since you put your script in one of those directories listed in $PATH, the
shell found it and ran it from there.

To add another directory to path run:

	export PATH=<new-path>:$PATH

For example:

	export PATH=/usr/local/bin:$PATH
