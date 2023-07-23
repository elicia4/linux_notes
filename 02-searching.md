# 02. Searching

[***go back to README***](README.md)

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

Whenever you're prompted, `Y` will apply to all and not a single instance.

>searching for love in all the right places  
>its wrong to eat cookies after midnight  
>windows is the wrong OS to use for programming  
>liking a perfect circle more than Tool is just WRONG
