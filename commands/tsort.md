# `tsort`

[***Table of Contents***](/README.md)

Perform a topological sort:

```bash
cat dependencies.txt
```
```
c d
a b
b c
f g
e f
d e
```
```bash
tsort dependencies.txt
```
```
a
b
c
d
e
f
g
```

A topological sort is a type of ordering that can be applied to a set of edges
in a directed graph. In the context of graph theory, a set of directed edges
can be described as topologically sorted when the source vertex always comes
before the destination vertex. Above, the first entry is the source vertex and
the second is the destination vertex.

Topological sorting may not be possible if the graph contains cycles.

According to `info`, `tsort` exists because early version of the Unix linker
required object symbols to be topologically sorted. However, this requirement
has been obsolete since the early 1980's!!!
