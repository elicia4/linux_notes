# 02. Searching

[***Table of Contents***](README.md)

There are a lot of different ways to search for text in vim.

Most (if not all) search functions are executed in normal mode.

- `/` allows you to search in a forward direction from where you currently are
- `n` will find the next occurance of that word
- `N` will find the previous occurance
- `//` will repeat the previous search

- `?` allows you to search in a backward direction ...
- `n` and `N` work in opposite directions respectully
- `??` - same idea as `//`

- `*` searches for the next occurance of the word you're on
- `#` searches for the previous occurance of the word you're on

How do you find and replace text?

`:%s/find/replace/options` (`g` replaces globally, `gi` replaces globally
ignoring the case, `gc` replaces globally but prompts before each replacement)

  The possible choices are:
- `y`  
  Perform the substitution.
- `n`  
  Skip this instance.
- `a`  
  Perform the substitution on this and all subsequent instances of the pattern.
- `q`  
  Quit substituting.
- `l`  
  Perform this substitution and then quit, this is short for "last."
- `Ctrl-e`, `Ctrl-y`  
  Scroll down and scroll up, respectively. This is useful for viewing the
  context of the proposed substitution.

>searching for love in all the right places  
>its wrong to eat cookies after midnight  
>windows is the wrong OS to use for programming  
>liking a perfect circle more than Tool is just WRONG

[***Go to Next Note***](03-files-and-tabs.md)
