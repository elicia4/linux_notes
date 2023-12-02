# 08. The `g` Key

[***Table of Contents***](README.md)

Every single key you use in vim does a thing.  
They are all special in their own little way.

One of the special and very useful ones is the `g` key.

The most basic commands with it are:

- `G` - go to the end of the file
- `gg` - go to the beginning of the file
- `number + G` - to line number. For example `64G` moves to the 64th line

`g` can be used in combination with other keys to do other things:

`g` + movement keys (`j`,`k`) - allows you to move within a multi-line
paragraph.
`g` + `$`/`^` - move to current line's beginning or end within a line in a big
multi-line paragraph.

Try it out on the text below!

	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

You can also use `gq` to reformat a multi-line paragraph so that it is neat,
looks good and is usable with regular vim movement commands:

Try it out here:

	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

You should get the following result:

	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
	tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
	veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
	commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
	velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
	cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id
	est laborum.

To redo an action you did in normal mode, just hit the period(`.`) button:

    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
    veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
    commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
    velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
    cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id
    est laborum.

To get an ASCII value for a symbol use `ga` (Hex and Octal values too!):

	!@#$%^&*()_+-=

If you have a string of text that is a path to a file, you can open up that
file in vim with `gf`:

	~/.vimrc

To go back to a previously opened file, use `CTRL+^`

`g+` and `g-` are shortcuts for redo and undo. Vim has undo branches, to
simplify their use you should probably install the "gundo.vim" plugin, it
allows you to view your changes visually.

You can subtitute words globally with:

	:s/word/changeto/g -- this will change to the first instance

Then use `g&` to apply it to all lines in the file.

You can also substitute text with `cgn`:

	/word
	cgn
	*type new word*
	Esc

This will get stored as a movement in a period command, you can substitute a
specific occurence with `<number-of-occurence>` + `.`.

You can jump to previous line (to the exact place as well) you were editing 
with `gi`.

The same applies to visual mode, use `gv`.

[***Go to Next Note***](09-vim-tips.md)
