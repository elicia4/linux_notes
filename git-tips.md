# Git Tips

Notes taken on info from many places, mainly from this video by Fireship:  
https://youtu.be/ecK3EnyGD8o

[***Contents***](README.md)

---

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

1. Imagine you're working on a `feature` branch that has many different commits,
   and you're ready to merge it with the `main` branch. But all these commit
   messages are kind of pointless and it would be better if there was just one
   commit message. You can do it with:

    ```sh
    git rebase --interactive
    ```

   That will pull up a file with commits and commands before them, such as
   `pick`. If you want to use that commit, you keep `pick`. If you want to
   change a message, use `reword`. You can combine everything into that
   original commit with `squash`. Once you save it, another file will pop up
   prompting you to update that commit message. It will be a combination of all
   the commit messages that you squashed. 

   You can also use `fixup` instead of `squash`. The difference between them is
   that during the rebase, the `squash` operation will prompt you to combine
   the messages of the original and the `squash` commit, whereas the `fixup`
   operation will keep the original message and discard the message from the
   `fixup` commits.

   To be even more productive with your `squash`es and `fixup`s, you can use
   them as flags when making commits on your branch:

    ```sh
    git commit --fixup <commit-id>
    git commit --squash <commit-id>
    ```
   
   So that when you do a `rebase` after:

    ```sh
    git commit -i -autosquash
    ```
   
   It can handle all the squashing automatically.

1. Another useful tool is `git hooks`. Whenever you perform an operation with
   `git`, like a `commit`, it creates an event, and hooks allow you to run some
   code either before or after that event happens. If you look into the hidden
   `.git` directory, inside of there you'll see many different scripts that can
   be configured to run when different events in `git` happen. For instnace,
   you can run tests before a commit happens.

1. Let's imagine you have a remote repository on GitHub and a local version
   that you've been making changes to, but things haven't been going too well,
   and you just want to go back to the original state in the remote repo. First,
   do `fetch` from a remote repo:

    ```sh
    git fetch origin
    ```

   Then to overwrite your local code with the remote code (your local changes
   will be lost **FOREVER**):

    ```sh
    git reset --hard origin/master
    ```

   If you're still left with some random untracked files or build artifacts
   here and there, use the `clean` command to remove those files as well:

    ```sh
    git clean -df
    ```

1. If you recently switched out of a branch and forgot its name, you can switch
   back to your previous branch with:

    ```sh
    git checkout -
    ```
