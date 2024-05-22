# Vim Registers

[***Table of Contents***](./ToC.md)

These are notes on [this video by
Beginbot](https://www.youtube.com/watch?v=I5QGlfbuCfs).

### Introduction

Registers allow you to save multiple snippets of text. To see what's stored in
your registers:

```vim
:registers
```

Or just:

```vim
:reg
```

You can store things in many registers:
- [`""` - unnamed register](#the-unnamed-register)
- [`"[0-9]` - numbered registers](#the-numbered-registers)
- [`"-` - small delete register](#the-small-delete-register)
- [`"[a-z]`, `"[A-Z]` - named registers](#the-named-registers)
- [`":,`, `".,` `"%` - read-only registers](#read-only-registers)
- [`"#` - alternative buffer register](#alternative-file-register)
- [`"=` - expression register](#expression-register)
- [`"_` - black hole register](#the-black-hole-register)
- [`"*`, `"+` - selection registers](#selection-registers)
- [`"/` - last search pattern register](#last-search-register)

To access a register:
- In normal mode: `"<Register Key>`
- In insert mode: `CTRL-r <Register Key>`

To copy something to a register:
1. Access the register
1. Copy/Paste to/from that register

---
To reset all of your registers:
```vim
let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"' | let i=0 | while (i<strlen(regs)) | exec 'let @'.regs[i].'=""' | let i=i+1 | endwhile | unlet regs
```
---

### The Unnamed Register

The `""` register is the one you interact with all the time. Things that
populate the unnamed register:

- d/D
- c/C
- s/S
- x/X
- y/Y

- p/P pastes from the unnamed register

### The Numbered Registers

You are using these all the time as well. Whenever you copy something, the
number 0 register always contains your last copied text.

Whenever you delete something, the first unnamed register gets populated with
whatever you deleted last, while all the previously deleted numbered registers
get "pushed down" (1 -> 2, 2 -> 3 etc.). This is especially useful whenever you
delete lots of stuff and you suddenly remember that you need one of the deleted
blocks of text. `vim` is keeping your delete history in case you forget
something.

They are useful for:
- `"0` always has the last yank
- `"1` always has the last delete (`d`, `c`, `s`, `x`)
- Nice for finding that item you deleted 3 commands ago and forgot

An exception is made for the delete operator with these movement commands,
register `"2` is always used then:

```vim
% ) ( ` / ? n N { }
```

---
You can always access the documentation:

```vim
:help registers
```
---

### The Small Delete Register

The `"-` register contains text from commands that delete less than one line,
except when the command specifies a register with `"x`...but these are
contained in your other delete registers. This one confuses me.

### The Named Registers

- Store whatever you want!
- Your macros are stored *here* automatically
- You can edit your macros! Instead of rerecording them, you can just edit
them.
- Storing snippets of common snippets of text
- Saving things on the fly, that you don't want clobbered

To rerecord a macro:

```vim
:let @a='<CTRL-r> + <register>'
```

To insert your macro in insert mode, use `<CTRL-r> + <register>`. To insert an
escape character in insert mode, use `<CTRL-v> + <Esc>`.

### Read Only Registers

They are: 
- `"%` - current file
- `".` - last insert mode
- `":` - last command

To insert any of them, use `<CTRL-r> + <register>`. 

You can also use filename modifiers:

```vim
:help filename-modifiers
```

- `%:p` -> Make file name a full path
- `%:h` -> Head of the Filename
- `%:t` -> Tail of the Filename
- `%:r` -> Root
- `%:e` -> Extension

Let's say you created a new file in a new folder:

```vim
!vs new_folder/cool_work.txt
```

Once you're finished with it, you won't be able to save it. The reason is that
you opened a folder that doesn't exist and a file that doesn't exist. To fix
this, you need to create the folder first.

```vim
:!mkdir %:h
```

And now you can save! Read the manual for more info on these.

### Alternative File Register

The `"#` register can be useful for:

- navigating between 2 files
- remembering what file you were just on

The alternative file is always the file you were last on. You can go to the
alternative file with `Ctrl+^`. So if you're ever in a need to switch between
two last opened files, you now know how to do it.

### Expression Register

Save or insert something into a document as a result of an expression you
calculate on the fly. The register is `"=`.

1. `"=`
1. Do a calculation: `1337 * 69`
1. Paste: `p`

You can also run system commands and insert their results into your files:

```vim
=system('ls')
```

### The Black Hole Register

The key is `"_`. 

When writing to this register, nothing happens. This can be used to delete text
without affecting the normal registers. When reading from this register,
nothing is returned.

You can use this register to work with sensitive information, like passwords,
keys etc.

For example, to delete a line and not have it saved: `"_dd`.

You can also clear existing registers with the black hole register:

```vim
:let @2=@_
```

### Selection Registers

The keys: `"+` `"*`

Set these up correctly, if you don't, life can be very annoying. This lets you
copy and paste from programs other than vim.

If you copy something from a different program, for example a link from your
web browser, the information will be saved to the register.

To always use the clipboard for ALL operations, instead of interacting with the
`+` and/or `*` register explicitly:

```vim
:set clipboard+=unnamedplus
```

Take a look at the documentation to understand this deeper:

```
:help clipboard
```

### Last Search Register

The key: `"/`

The register saves the last search you did. It can be used for:

- correcting a search
- insert last search as you are typing
- using the last search for search and replace functions

To correct a search: 
- in search  mode: `/ Ctrl-r /`
- in insert mode: `Ctrl-r /`
- in execute mode: `/ Ctrl-r /`

Always use `Ctrl-r /`! Really useful!
