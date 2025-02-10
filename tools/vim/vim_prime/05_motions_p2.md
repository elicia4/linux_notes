# Advanced Motions P2

[***Table of Contents***](./ToC.md)

1. Use relative line numbers, they make your life easier.

1. Navigate with `Ctrl-d` and `Ctrl-u`, they may seem disorienting at first but
   one you get used to them, you'll be a lot better off.

1. To go to the corresponding bracket, use `%`. It doesn't matter whether
   you're on the opening or closing one.

1. If you do `=` on some selected text, it will indent depending on the rules.
   You can do it with motions as well, `=ap` will align an entire paragraph.

1. You can have function headers be on the first line in the buffer with neovim
   treesitter context (plugin).

1. To delete an entire function you can either:
    - go to the function header line, and then: `Vf{%d`
    - or you can just: `va{Vd`
        - `V` turns it into line mode and selects the function header as well

1. While in visual mode, you can go between the end and the beginning of the
   selection with `o`.

1. You can increment numbers with `Ctrl-a`

## Fast Search & Replace

1. Say you want to put the following array into an array:

   ```
   Foo
   Bar
   Baz
   Buzz
   ```

   `yip` copies contiguous (connecting, without breaking) code. If you want to
   copy the contiguous code & the new line character after it, do `dap`. If
   you're on a newline above the contiguous code, it will only copy the current
   whitespace line AND the contiguous code, without the newline after it.

1. To intend four lines one time based on indentation rules: `>4j`

1. Add the array header above the data:

   ```rust
   const data = [];
   Foo
   Bar
   Baz
   Buzz
   ```

1. Do it with multi-cursors, increment with `g Ctrl-a`:

   ```rust
   const data = [];
   data[0] = "Foo
   data[1] = "Bar
   data[2] = "Baz
   data[3] = "Buzz
   ```

1. You can append the remaining `";` by:
    1. Selecting the `data[]` lines
    1. Entering command mode `:`
    1. Entering after the existing text: `s/$/";`

    ```rust
    const data = [];
    data[0] = "Foo";
    data[1] = "Bar";
    data[2] = "Baz";
    data[3] = "Buzz";
    ```

You can do all this a lot faster.

1. `vip` the data:


   ```rust
   Foo
   Bar
   Baz
   Buzz
   ```

1. Do `:` -> `s/\(\w.*\)/data[0] = "\1";`

   ```rust
   data[0] = "Foo";
   data[1] = "Bar";
   data[2] = "Baz";
   data[3] = "Buzz";
   ```

1. You can increment with `g Ctrl-a` by only selecting entire lines, if the
   values that need to be incremented go first in those lines, everything will
   work.

## More Tips

1. `Ctrl-u/d` always moves by the same value, `{}` are unpredictable, since
   code or any other text can be separated in a non-regular manner.

1. If you need to quickly get to the bottom of a really big function, you can
   do `vi{` and then leave the visual mode. You'll be at the end of the
   function. You can then go to the bracket and go between the beginning and
   the end of the function with `%`. This gets more useful the bigger the
   function is. :)

1. Try to drive towards simplicity. The less overhead there is for editing, the
   more energy you have on truly important stuff. Try to minimize the cognitive
   overhead. :)
