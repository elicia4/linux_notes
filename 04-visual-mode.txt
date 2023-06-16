Visual mode is useful for editing arbitrary trunks of text inside of a file.
There are three different subtypes to visual mode:

visual mode = v = select text character by character
visual line = V = select text line by line
visual block = ctrl+v

move with regular movement keys (h/j/k/l, w/b, $/^, etc.)
you can copy with 'y' (y=yank), paste with 'p'
you can 'd' to delete and copy the deleted text into your register 
OR 
'x' to just delete, without copying the text into your register

anything you do to selected text on one line will be done to text on the other

try editing the following lines,
remove all hyphons from all of them and add +1 to the beginning of the lines:

123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234

(use visual block, x OR d, and I)
