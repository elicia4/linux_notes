# 05. Command Mode

[***go back to README***](README.md)

There are commands in `vim`!  
You can enter them with the colon `:` symbol.

Commands are displayed at the bottom.

Commands that were already covered:

- `:q!` = quit without saving
- `:wq` = quit with saving the document
- `:x`  = same as wq but doesn't write if no changes
- `:tabnew` = opens a new tab
- `:tabfirst` = goes to first tab
- `:tablast` = goes to last tab
- `:w <name>` = name a file

- `:e` = open a file
- `:cd` = gives the current working directory
- `:put=range(start,end)` = writes a list of numbers below the cursor, one at a
a line. `pu` == `put`, `pu=range(1,5)`

`:pu=range(start,end,jump)` = will output `start`, `start+jump`, `start+2*jump`
...  as long as `start+n*jump` <= `end`. So, to output odd numbers that are
fewer than or equal 25:

	pu=range(1,25,2)

A good example of `put` (outputs a list of 10 IP addresses):

	:for i in range(1,10) | put='192.168.0.'.i | endfor

- `:g/^/n0` = reverse all lines in the document.
- `:registers` = shows us what is in all the current registers. `vim` has many
  clipboards, they are called registers, you have a register for every 
  alphanumeric key and some others.
- `:oldfiles` = shows files that have been recently edited with vim.
- `:browse oldfiles` = lets you browse and open oldfiles.

Different file explorer modes:

- `:Sexplore` = opens a file explorer in a horizontal window
- `:Vexplore` = opens a file explorer in a vertical window
- `:Texplore` = opens a file explorer in a new tab

