# `printenv`

[***Table of Contents***](/README.md)

> Just use `env` instead

Print environment variables:

```bash
printenv
```

By default, it prints all of them. But you can also specify a select subset:

```bash
printenv DISPLAY TERM
```

The program first appeared in 1979 as a contribution by Bill Joy to **BSD**.

The purpose is exclusively to print the environment variables, which can also
be done by `env`. However, `env` also includes a number of other features that
`printenv` doesn't, making `printenv` effectively redundant.

The reason why `printenv` exists could be attributed to the fact that `env` was
created independently around the same time and appeared as early as 1980. Both
were subsequently implemented by GNU.
