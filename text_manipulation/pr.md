# The `pr` command

[***Table of Contents***](/README.md)

`pr` is used to convert text files for printing. Create a file:

    info pr > pr.txt

`pr` is used to *paginate* text, *pagination* or *paging* is the process of
dividing a document into pages. When printing text, it is often desirable to
separate the pages of output with several lines of whitespace, to provide a
top margin and a bottom margin for each page. Further, this whitespace can be
used to insert a header and footer on each page.

Format the file:

    pr -l 15 -w 65 pr.txt

This defined a page that is 15 lines long and 65 characters wide.

- `-l PAGE_LENGTH` sets the page length to `PAGE_LENGTH`
- `-w PAGE_WIDTH` sets page width to `PAGE_WIDTH`

`pr` is used to adjust text to fit on a specific page size, with optional
headers and margins. Common `pr` options are:

- `+first[:last]` - output a range of pages starting with `first` and,
  optionally, ending with `last`.
- `-columns` - organize the content of the page into the number of columns
  specified by `columns`.
- `-a` - by default, multicolumn output is listed vertically. By adding the
  `-a` (across) option, content is listed horizontally. 
- `-d` - double-space output.
- `-D "format"` - format the date displayed in page headers using `format`. See
  the man page for `date` for the format string.
- `-f` - use form feeds rather than carriage returns to separate pages.
- `-h "header"` - in the center portion of the page header, use `header` rather
  than the name of the file being processed.
- `-l length` - set page length to `length`. The default is 66 (US letter at
  six lines per inch)
- `-n` - number lines.
- `-o offset` - create a left margin `offset` characters wide.
- `-w width` - set the page width to `width`. The default is 72.

List the contents of `/usr/bin` in 3 columns 65 characters wide:

```bash
ls /usr/bin | pr -3 -w 65 | head
```
