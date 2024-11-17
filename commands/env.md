# `env`

[***Table of Contents***](/README.md)

It shows the current environment variables:

```bash
env
```

These variables have important effects on how certain programs run.

`env` can be used to run commands with overwritten environment variables:

```bash
date
env TZ='America/Los_Angeles' date
```

You can invoke commands as if they were in a different directory with `-C`:

```bash
env -C /run pwd
```

By default, `env` inherits the existing environment variables:

```bash
env FOO=VAR env
```

You can ignore them with `-i`:

```bash
env -i FOO=VAR env
```
