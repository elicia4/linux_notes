Why use vim?

Most common editor, most available editor
Most powerful editor
Dates back to 1976, vim is here to stay

Vim is a modal text editor, by default it opens in the normal mode

Normal mode - navigating through the document
Insert mode - editing text
Visual mode - copying/deleting text

i - enter insert mode before the current symbol
I - enter insert mode at the beginning of the line
o - enter insert mode on the line below current line
O - enter insert mode on the line above current line
a - enter insert mode after the current symbol
A - enter insert mode at the end of the line
C - delete from cursor to the end of the line and enter insert

Esc - enter normal mode 
ctrl + [ - enter normal mode, lets you stay on home row

Moving around

    k
    ^
h <   > l
    v
	j

You can also pass arguments to movement commands

WORDS = combinations of all symbols except for the whitespace,
words = combinations of all symbols except for the whitespace and the
punctuation symbols

w - forward to the beginning of the next word
W - forward to the beginning of the next WORD
b - backward to the beginning of the next word
B - backward to the beginning of the next WORD
e - forward to the end of the next word
E - forward to the end of the next WORD

You can repeat the command by entering the number of times you'd like a command
to be repeated: [n]<command>
