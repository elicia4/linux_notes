# Wildcards / Globbing

[***go back to README***](/README.md)  

Wildcards are special characters that help us specify groups of filenames.
Using wildcards (which is also known as globbing) allows us to select filenames
based on patterns of characters.

Wildcards:

- `*` matches any characters
- `?` matches any single character
- `[characters]` matches any character that is a member of the set `characters`
- `[!characters]` matches any character that is not a member of the set
  characters
- `[[:class:]]` matches any character that is a member of the specified class

Character classes:

- `[:alnum:]` matches any alphanumeric character
- `[:alpha:]` matches any alphabetic character
- `[:digit:]` matches any numeral
- `[:lower:]` matches any lowercase letter
- `[:upper:]` matches any uppercase letter
