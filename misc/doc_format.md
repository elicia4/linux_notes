# Document Formatting

[***Table of Contents***](/README.md)

Two main families of document formatters are prevalent, those based on:
- "TeX" (tek) typesetting system
- and on the original `roff` program

- `nroff` is used for devices that use monospaced (all characters occupy the
  same width) fonts, such as character terminals and typewriter-style printers.
- `troff` formats documents for typesetters, devices used to produce type for
  commercial(and other) printing. Largely displaced by TeX.
- `eqn` is used for mathematical equations
- `tbl` is used for tables
- `groff` is the GNU `troff`

### `groff`

Includes the functionality of all the `roff` tools. Documents are produces in
two steps:
1. Composition with a text editor
1. Processing with a processor (such as `troff`) to apply the formatting

Instructions are embedded in text with a markup language. Take a look at the
`ls` man page:

    zcat /usr/share/man/man1/ls.1.gz | head
    man ls | head

Note the correlation between a normal presentation and the markup language.
`man` pages are rendered by `groff`, using the `mandoc` macro package. You can
simulate the `man` command with `groff`:

    zcat /usr/share/man/man1/ls.1.gz | groff -mandoc -T ascii | head

We specified the `mandoc` macro package and the output driver for ASCII.
`groff` can output in multiple formats, if none is specified PostScript is
used:

    zcat /usr/share/man/man1/ls.1.gz | groff -mandoc | head

PostScript is a page description language used to describe a page to a
typesetter-like device. On most Linux distributions, if you save a PostScript
file (`.ps`) and open it manually (for example from you Desktop), a GUI will
show it rendered form:

    zcat /usr/share/man/man1/ls.1.gz | groff -mandoc > ~/Desktop/ls.ps

You can convert `.ps` files to `.pdf`:

    ps2pdf ~/Desktop/ls.ps ~/Desktop/ls.pdf

There are many format conversion programs, check them out:

    ls /usr/bin/*[[:alpha:]]2[[:alpha:]]* # format2format
    ls /usr/bin/*[[:alpha:]]to[[:alpha:]]* # formattoformat

Create a sample file:

```
echo ".TS
center box;
cb s s
cb cb cb
l n c.
Vegetable List 
=
Name	Freshness	Age
_
Cucumber	Fresh	1 hour
Tomato	Rotten	2 weeks
.TE
" > veggies.txt
```

Make sure that `Name`, `Freshness`, and `Age` are separated by tabs, as well as
the values themselves. `tbl` uses `.TS` and `.TE` as "table start" and "table
end". The row following `.TS` define global properties of the table, they are
centered horizontally and surrounded by a box. The remaining lines describe the
layout of each table row. Apply the formatting:

```bash
cat veggies.txt | groff -t -T ascii
```

The `-t` option instructs `groff` to preprocess the text stream with `tbl`.
`-T` is used to specify output to ASCII (`ascii`). You can view it with a GUI
as well:

```bash
cat veggies.txt | groff -t > ~/Desktop/veggies.ps
```
