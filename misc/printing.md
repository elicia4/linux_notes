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
The generic name for a component that performs this process of rendering
something into a large bit pattern(called a *bitmap*) is *raster image
processor(RIP)*.

Modern Linux systems employ two software suites to perform and manage printing:
- Common Unix Printing System (CUPS) provides print drivers and print-job
  management
- Ghostscript, a PostScript interpreter, acts as a RIP

CUPS manages printers by creating and maintaining print queues. Since printers
are slow by nature, compared to the computers that are feeding them, printing
systems need a way to schedule multiple print jobs and keep things organized.
CUPS also has the ability to recognize different types of data and can convert
files to a printable form.

[`pr`](../text_manipulation/pr.md) can be used in conjunction with printing.

CUPS supports two programs for printing: 
- `lpr`, used in the Berkley Software Distribution of Unix
- `lp`, used in the System V version of Unix

To print the contents of `/usr/bin` arranged in 3 columns:

```bash
ls /usr/bin | pr -3 | lpr
```

The example above used the default printer. To specify a printer:

```bash
lpr -P printer_name
```

To see a list of all printers known to the system:

```bash
lpstat -a
```

---

#### Printing to PDF

You can choose to "print" your file as a PDF first instead of printing it on a
physical printer. To add a `cups-pdf` PDF printer on Arch:

    pacman -S cups cups-pdf

Enable `cups.service` and `cups.socket`:

    sudo systemctl enable --now cups.service cups.socket

After enabling and installing, it was still now showing up with `lpstat -t` or
`lpq -a`. I managed to activate the PDF printer with the CUPS web interface. 

1. Go to `localhost:631`
1. Go to the `Administration` tab at the top
1. Click `Find New Printers`
1. "Virtual PDF Printer (CUPS-PDF)" should be there, click `Add This Printer`
1. Click `Continue`
1. Choose `Generic` in `Make:`, `Continue`
1. Choose `Generic CUPS-PDF Printer (no options) (en)`
1. Finally, click `Add Printer`
1. Check it out with `'lpstat -a`
I am fairly certain this can be done a lot more easily with the command line,
but I couldn't quickly figure it out, so I chose the GUI option.

To print to PDF:

    lp -d CUPS-PDF <filename>

By default, files will be saved in `/var/spool/cups-pdf/${USER}`. To change
the path, edit the `/etc/cups/cups-pdf.conf` file. Change the `#Out
/var/spool/cups-pdf/${USER}` to `Out <Destination>`. For example, `Out
${HOME}/PDF`:

    sudo sed -i 's.^#Out /var/spool/cups-pdf/${USER}$.Out ${HOME}/PDF.' \
    /etc/cups/cups-pdf.conf

`sed` edits the `cups-pdf.conf` file itself (`-i`), `.` is used as the
delimiter.

---

#### `lpr` and `lp`

`lpr` options:
- `-# number` - set number of copies to number.
- `-p` - print each page with a shaded header with the date, time, job name,
  and page number. This so-called "pretty print" option can be used when
  printing text files.
- `-P printer` - specify the name of the printer used for output. If no printer
  is specified, the system’s default printer is used.
- `-r` - delete files after printing. This would be useful for programs that
  produce temporary printer-output files.

`lp` supports a different option set:

- `-d printer` - set the printer to `printer`. If not specified, the default
  printer is used.
- `-n number` - set the number of copies to `number`.
- `-o landscape` - set output to landscape orientation.
- `-o fitplot` - scale the file to fit the page. This is useful when printing
  images, such as JPEG files.
- `-o scaling=number` - scale file to number. The value of 100 fills the page.
  Values less than 100 are reduced, while values greater than 100 cause the
  file to be printed across multiple pages.
- `-o cpi=number` - set the output characters per inch to `number`. The default
  is 10.
- `-o lpi=number` - set the output lines per inch to `number`. The default is
  6.
- `-o page-bottom=points`, `-o page-left=points`, `-o page-right=points`, `-o
  page-top=points` - set the page margins. Values are expressed in  points, a
  unit of typographic measurement. There are 72 points to an inch.
- `-P pages` - specify the list of pages. `pages` may be expressed as a
  comma-separated list and/or a range, for example, 1,3,5,7-10

Print 12 CPI and 8 LPI with a left margin of one half inch. Adjust the `pr`
options to account for the new page size:

    ls /usr/bin | pr -4 -w 90 -l 88 | lp -o page-left=36 -o cpi=12 -o lpi=8

#### `a2ps`

`a2ps` was initially designed as a format conversion program, but it's capable
of doing printing work as well. By default, it sends its output to the system's
printer instead of STDOUT. Create a PostScript file on your desktop:

```bash
ls /usr/bin | pr -3 -t | a2ps -o ~/Desktop/ls.ps -L 66
```

- `-L` specifies the number of lines per page;
- `-t` in `pr` omits headers and footers;

View the file with `gv`:

```bash
gv ~/Desktop/ls.ps
```

You can manipulate the size of the image with `<CTRL> - <+>` and `<CTRL> +
<->`.

`a2ps` options:

- `--center-title=text` - set center page title to `text`;
- `--columns=number` - arrange pages into `number` columns. The default is 2;
- `--footer=text` - set page footer to `text`;
- `--guess` - report the types of files given as arguments;
- `--left-footer=text` - set the left-page footer to `text`;
- `--left-title=text` - set the left-page title to `text`;
- `--line-numbers=interval` - number lines of output every `interval` lines;
- `--list=defaults` - display default settings;
- `--pages=range` - print pages in `range`;
- `--right-footer=text` - set the right-page footer to `text`;
- `--right-title=text` - set the right-page title to `text`;
- `--rows=number` - arrange pages into `number` rows. The default is 1;
- `-B` - no page headers;
- `-b text` - set the page header to `text`;
- `-f size` - use `size` point font;
- `-l number` - set characters per line to `number`. This and the `-L` option
  (see next entry) can be used to make files paginated with other programs,
  such as `pr`, fit correctly on the page;
- `-L number` - set lines per page to `number`;
- `-M name` - use media `name`. For example, A4;
- `-n number` - output `number` copies of each page;
- `-o file` - send output to `file`. If file is specified as `-`, use standard
  output;
- `-P printer` - use `printer`. If not specified, the default printer is used;
- `-R` - portrait orientation;
- `-r` - landscape orientation;
- `-T number` - set tab stops to every `number` characters;
- `-u text` - underlay (watermark) pages with `text`.

`enscript` can do things similar to `a2ps`, but it only accepts text input.

#### Managing Print Jobs

To check printer queue status:
```bash
lpstat -a
```

You can specify one or multiple printers as well:
```bash
lpstat -a [printer...]
```

To get a more detailed output (a status summary):
```bash
lpstat -s
```

Other supported options are:
- `-d` shows the system's default printer;
- `-p [printer...]` shows the status of a printer. If none is specified, all
  are shown;
- `-r` displays the status of the print server;
- `-t` shows a complete status report.

To show the status of a printer queue and the print jobs it contains:
```bash
lpq
```

By defualt, the system default printer is shown. To specify a particular
printer, use `-P`.

To terminate a print job, use `lprm` or `cancel`:
```bash
lpq
cancel <job-id>
lpq
```

You can all jobs created by a user with `-u`.
