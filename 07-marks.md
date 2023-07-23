# 07. Marks

You can set marks in specific parts of files to quickly navigate to them.

Imagine marks as bookmarks. Marks are invisible. You can set a mark with the
`m` key + any letter from `a to z`, both lowercase and uppercase work, though
there is a difference. You can then jump to the mark with:

	`<key>  -- this will get you to the exact place where you placed your mark
	'<key>  -- this will get you to the exact line where you placed your mark

You can also combine some vim hotkeys with the jump-to-mark commands:

	d'a -- delete from current line to line of mark a
	d`a -- delete from current cursor position to position of mark a
	c'a -- change text from current line to line of mark a
	y'a -- yank text to unnamed buffer from cursor position to pos. of mark a
	
To view marks:

	:marks -- lists all marks
	:marks aB -- lists marks a and B

You can delete marks:

	:delmarks a -- delete mark a
	:delmarks a-h -- delete marks a through h
	:delmarks! -- delete all marks

Uppercase marks are unique across all files, lowercase marks are unique for
each file.
