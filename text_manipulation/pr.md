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
