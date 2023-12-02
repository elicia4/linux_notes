# Bash Keyboard Shortcuts

[***go back to README***](/README.md)  

### Moving:
- `<CTRL-a>` - move cursor to the beginning of the line
- `<CTRL-e>` - move cursor to the end of the line
- `<CTRL-f>` - move cursor one character forward
- `<CTRL-b>` - move cursor one character backward
- `<ALT-f>` - move cursor one word forward
- `<ALT-b>` - move cursor one word backward
- `<CTRL-l>` - clear the screen

### Editing:
- `<CTRL-d>` - delete the character at the cursor
- `<CTRL-t>` - exchange the character at the cursor with the one before it
- `<ALT-t>` - exchange the word at the cursor with the one before it
- `<ALT-l>` - convert characters from cursor to the end of the word to
   lowercase
- `<ALT-u>` - convert characters from cursor to the end of the word to
   uppercase

### Cutting and Pasting:

- `<CTRL-k>` - cut text from the cursor to the end of line
- `<CTRL-u>` - cut text from the cursor to the beginning of the line
- `<ALT-d>` - cut text from the cursor to the end of the current word
- `<ALT-Backspace>`/`<CTRL-w>` - cut text from the cursor to the beginning of
   the current word. If the cursor is at the beginning of a word, cut the
   previous word
- `<CTRL-y>` - yank text from the cut-ring and insert it at the cursor
   
### Completion 

- `<ALT-?>` - display a list of possible completions. You can
   also do this by pressing the Tab key twice
- `<ALT-*>` - insert all possible completions

### History

- `<CTRL-p>` - move to the previous history entry
- `<CTRL-n>` - move to the next history entry
- `ALT-<` - move to the beginning of the history list
- `ALT->` - move to the end of the history list, i.e., the current command line
- `<ALT-p>` - reverse search, nonincremental. Use this shortcut, type in the
  search string and press enter
- `<ALT-n>` - forward search, nonincremental
- `<CTRL-o>` - execute the current item in the history list and advance to the
  next one, really handy to use with `ALT-p`

### History Incremental Search

- `<CTRL-r>` - start incremental search
- `<CTRL-j>` - while in incremental search, copy the line from the history list
  to the current command line
- `<CTRL-g>`/`<CTRL-c>` - quit
- `<>` - 

### History Expansion Commands

- `!string` - repeats last history list item starting with `string`
- `!?string` - repeats last history list item containing `string`
