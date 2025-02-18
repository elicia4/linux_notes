# Hashing Algorithms and Security

[***Table of Contents***](/README.md)

Whenever you want to transfer a file from one machine to another and it's
important to know it transferred fully, a hash algorithm can help.

It's kind of like a check digit in a bar code or a credit card. The last digit
is determined by all the other digits on it. So if you change one of those
digits, the last one changes as well.

The hash algorithm is something like that, but for an entire file that might be
megabytes or gigabytes in size. It returns a 16/32/64 characters long code,
generally hexadecimal, that is a "sum up" of everything in the file.

You can't pull out the data from the number itself, but it's a confirmation
that the file is really what it's supposed to be.

Hash algorithms have three main requirements:
- speed. It should be able to work through big amounts of data quickly. If it's
too quick, it's easy to break
- if you change one bit in the file, it should produce a radically different
result
- you have to be able to avoid hash collisions. E.g., when two documents have
the same hash. The odds of this happening should be so unlikely that is should
never happen naturally. This is needed to avoid information forgery

These are used for verifying transmitted files. That's all they should be used
for.
