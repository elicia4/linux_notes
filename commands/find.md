# The "find" file-searching tool

Notes taken on this video by LearnLinuxTV: 
https://youtu.be/skTiK_6DdqU

[***go back to README***](/README.md)  

The `find` command has many options you can use that are not included in these
notes. A simple example of the `find` command:

    find /home/admin -name *.txt 

You might want to avoid viewing hidden files. You can do it by piping commands
together, use `grep`:

    find /home/admin -name *.txt | grep -v .cache
    
Now the results that contain `.cache` will be ignored. Let's say you are only
interested in files or only in directories. Create a file named "Documents"
inside the "Documents" folder. 

To return files only, use the `-type f` option:

    find . -name Documents -type f

To return directories only, use the `-type d` option:

    find . -name Documents -type d 

Let's say you want to remove the "Documents" file now. To do that:

    find . -name Documents -type f -exec rm {} +
    
Now check if the "Documents" file exists. It doesn't, it's been removed!
`-exec` means that you want to execute a command against every item in the
result. In this context, `rm` is the command you want to execute. The `{}` is
the placeholder for the actual item itself. The `+` is the terminator, it's the
end of the command, it's closing each iteration off. Another variation of the 
terminator is `\;`. The `\` is used to escape the `;` character, that's an issue
with the shell.

Let's say you have a gigantic list of pictures and you want to add some
permissions to them in one shot. Of course, you can do it with the `chmod`
command itself:

    chmod -R 600 Pictures

But... It's gonna have a terrible consequence. The `600` permission is fine for
files, but it's going to mess your directory up, it will be missing the `x` bit,
thus making it unaccessible, you DO need the execute bit on it in order to get
inside that directory. You can fix it by running:

    chmod u+x Pictures

But what if you had more directories inside the "Pictures" directory? Things get
annoying pretty fast, and these annoyances can be avoided by using the `find`
command:

    find Pictures/ -type f -exec chmod 600 {} +

Now the permissions of your directories are not changed and your files are.

If you want to do something similiar to your directories:

    find Pictures/ -type d -exec chmod 700 {} +

It is actually a lot easier to use the `find` command to add file permissions.
Doing so is a good habit, especially when you're managing a file server. 

Let's say your server is full and you want to clear up some space by deleting
`.log` files. Remember that when you're on a production server, you want to make
sure that the files you're deleting are the right ones:

    sudo find /var/log -type f -name '*.log'

If you're satisfied with the output:

    sudo find /var/log -type f -name '*.log' -exec truncate -s 0 {} +

The `truncate -s 0` command will set the size of the files to exactly 0.

You can also pipe the results of `find` into a file:

    find -name '*.mp3' > results.txt

That's it :)

P.S. if for some reason `*` is not working, use `''` with it, so if you want to
look for all `.log` files, type `'*.log'`.
