# The `uniq` command

[***go back to README***](/README.md)

Say you had a sorted list `list.txt` with duplicate lines, to remove the
duplicates:

    cat list.txt | sort | uniq    

To only see the duplicates, use `-d`:

    cat list.txt | sort | uniq -d
