# 03. Files and Tabs

[***Table of Contents***](README.md)

You can open multiple files at the same time:

    vim f1.txt f2.txt ...

To switch from one file to another:

    :bn # go to next file (buffer)
    :bp # go to previous file (buffer)

To view the files (buffers) being edited:

    :buffers

To switch to buffer number N:

    :buffer N

To open a new tab:

	:tabnew

To go to the previous/next tab:

	:tabprevious OR :tabp
	:tabnext OR :tabn

You can also use commands to move between tabs:

	gt - move to the next tab
	gT - move to the previous tab
	<num>gt - move to the n-th tab

To give a name to a new file:

	:write <name> OR :w <name>

(make sure to add some text to the file, otherwise the tab name at the top
won't change, though the file itself will appear in the directory you're in)

To edit a new file use:

	:edit <name> OR :e <name>

If you don't remember what the name of the file is, you can list all of them
while doing the edit command and then select the file you need:

	:e <CTRL+d>

To move your tabs around:

	:tabmove <index> OR tabm <index>

Indices start with `0`, so if you wanted to move current tab to the first
place:

	:tabmove 0

To save your file:

	:w

To quit vim:

	:q

To save & quit:

	:wq OR :x

The difference between `:x` and `:wq` is that `:x` will only write if changes
have been made, thus not updating the modification time as opposed to `:wq`.

You type `ZZ` to quit as well.

[***Go to Next Note***](04-visual-mode.md)
