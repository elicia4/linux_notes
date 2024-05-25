# Vertical Movements

[***Table of Contents***](./ToC.md)

Motion: count + motion. E.g., `5j`. Relative line numbers simplify this quite a
bit.

Move by paragraph: paragraph is any contiguous non-whitespace. To go up/down by
paragraph: `{`/`}`. `{` goes to the top of every paragraph, `}` goes to the
bottom of every paragraph. This type of movement is cool, but not recommended.

You can jump half a page down/up: `Ctrl-d`/`Ctrl-u`. Remap these so that the
cursor always ends up in the middle of the screen: 

```lua
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
```

`zz` centers your view, thus centering your view after moving half a page.

`gg` to go to the top of the page, `G` to go to the bottom of it.

You can jump to a particular line number with `:<line_number>`, e.g., `:50`.

You can search for the next occurance of "search" with `/search`. `n` to go to
the next result, `N` to the previous. You can do a reverse search with `?`.
Remap these with centering as well:

```lua
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
```

`*` to search for the next instance of the word on cursor, try it out:

```bash
next 1234 1234 1234
1234
1234123412341234 next
```

`#` to invert it. Unused because you can do the same thing with `*` and `N`.
You can't master everything, please comrpomise.

Vertical motions are hard to master, you gotta get good at using half page
moving and searching.

You can develop infinitely at `vim`. :) Enjoy the editing experience!
