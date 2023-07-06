# Git Tips

1. Imagine you have a lot of changes done to many files and you want to add 
them all to staging without doing a lot of work. You can update all your
changes with:
    
    ```
    git add -u
    ```

    Note that this removes as well as modifies index entries to match the working
tree, but adds no new files.  

2. To add all new files:
    ```
    git add -A
    ```
