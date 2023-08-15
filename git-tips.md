# Git Tips

Notes taken on info from many places, mainly from this video by Fireship:  
https://youtu.be/ecK3EnyGD8o

[***go back to README***](README.md)

1. Stage all (new, modified, deleted) files:
    
    ```sh
    git add -A
    ```

2. Stage modified and deleted files only:

    ```sh
    git add -u
    ```

3. You can do add+commit without doing `add` first like so:

    ```sh
    git commit -am "that was easy"
    ```

4. Create an alias for it so that it's even faster:

    ```sh
    git config --global alias.ac "commit -am'
    ```

5. If you made a typo on your last commit message, you can change message of
   last commit:

    ```sh
    git commit --amend -m "nice!"
    ```

1. You can also update the last commit with new file by using the `--amend
   flag`, if you want to keep the same commit message, add the `--no-edit`
   flag.

    ``` sh
    git commit --amend --no-edit
    ```

1. You can overwrite history on remote by using the `--force` flag. This will
   overwrite the remote commit with the state of your local code. If there are
   commit on the remote branch that you don't have, you will lose them forever.

    ``` sh
    git push origin main --force
    ```

   An even better way to do it is to use `--force-with-lease`, this will only
   allow you to push the code if there are no conflicting changes with the
   current parent branch.

1. What if you push some garbage code to a remote repository and realize that
   it's complete garbage? You can undo a commit with a new commit by using:

    ```sh
    git revert <commit-id>
    ```

   That way you can go back to a state that was there previously. It's like
   `undo`, but it doesn't remove the original commit from the history.

   A useful way to display your commits:

    ```sh
    git log --oneline
    ```

1. If you don't have access to your local machine, all you need are your login
   credentials and a computer with a web browser. Go to GitHub, find the repo
   that you need and press the `.` button. That will pull up the browser
   version of VSCode, where you can edit your code, use `git` and so on...
   Except for run the terminal. If you need to run the terminal, you need to
   set up GitHub codespace in the cloud. 

1. Imagine you've done some changes, but they are not finished yet, you don't
   want to push them, but still want to save them, AND you need to restore your
   repo to its last state. That's when `git stash` comes in handy, it will save
   your changes. Then run `git pop` to add those changes back into your code.
   You can also give names to your stashed code:

    ```sh
    git stash save coolstuff
    ```
   
   Then when you're ready to work on it again, run `git stash list` to list the
   stashes, and then run `git stash apply <index>` to restore it.

1. To change the name of your branch from `master` to something else (like
   `main`), run:

     ```sh
     git branch -M main
     ```

1. A better way to display Git logs:
    ```sh
    git log --graph --oneline --decorate
    ```

1. Imagine there'a commit that's breaking your app, but it worked fine a couple
   hours ago. That's when you use `git bisect`. Point bisect to the last working
   commit:
    ```sh
    git bisect start
    ```
   Then it performs a binary search to walk you through commits in between. If 
   the commit is good, that is, everything is working properly, type `git
   bisect good`, if it's bad, type `git bisect bad`. Eventually you will find
   the bad one and find out which code needs to be fixed.

