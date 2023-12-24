# Printing

A page description language is a programming language that describes the
contents of a page. It works like so:

> Go to this position, draw the character 'a' in 10 point Helvetica, go to this
> position...

The first major PDL was PostScript which is still in wide use today. The
PostScript language is a complete programming language tailored for typography
and other kinds of graphics and imaging. 

A PostScript interpreter is a special program that reads the incoming
PostScript program and renders the results into the printer's internal memory,
thus forming the pattern of bits (dots) that would be transferred to the paper.
The generic name for this process of rendering something into a large bit
pattern (called a *bitmap*) is *raster image processor (RIP)*.

Modern Linux systems employ two software suites to perform and manage printing:
- Common Unix Printing System (CUPS) provides print drivers and print-job
  management
- Ghostscript, a PostScript interpreter, acts as a RIP

CUPS manages printers by creating and maintaining print queues. Since printers
are slow by nature, compared to the computers that are feeding them, printing
systems need a way to schedule multiple print jobs and keep things organized.
CUPS also has the ability to recognize different types of data and can convert
files to a printable form.
