# Learn Git 

These are notes on a video by HackerSploit:  
https://youtu.be/aH5NM5B0S24

[***Contents***](README.md)

---

- Git is an extremely useful tool for working with others. 
- Git and Github are not the same thing. 
- You need to learn `git` to be effective.
- A useful book for studying `git`: https://git-scm.com/book/en/v2
- With forking, you can customize an existing repository, possibly collaborate
  with the creator of the repo, and also attribute the author.

1. Start with creating a test repository.
1. Clone your repository locally:

    ```
    git clone <link>
    ```

1. Git has two configuration modes: local and global. The information that
   mainly you put into those is your username and your email. There are some
   other options that exist, like the default editor for commit and tag
   messages:

    ```
    git config --global core.editor vim
    ```

   This is done for tracking who wrote what code.

1. To display existing config:

    ```
    git config --global --list 
    ```

1. To set default global name and email:

    ```
    git config --global user.name "Your Name"
    git config --global user.email "your_name@gmail.com"
    ```

1. You also have local configuration for a repository.
1. To initialize `git`:

    ```
    git init
    ```

1. To view the information regarding the remote origin URL:

    ```
    git config --local --list
    ```

1. Now add an example file and fill it in with something, whatever you like.

    ```
    vim 1234
    ```

1. To view the staging area, which shows you what exactly has been done:

    ```
    git status
    ```
   
1. "Untracked files" contain files that are not tracked by `git`.

1. To add files:

    ```
    git add <filename>
    # OR TO ADD ALL
    git add -A
    ```

1. To commit changes, that is, confirm that you want the changes to be made:

    ```
    git commit -m "your message"
    ```

1. In the message, describe what has been done, try to make each message unique.

1. To view your commit messages:

    ```
    git log
    ```

1. To push your changes to the remote repository:

    ```
    git push 
    ```

1. Now let's discuss branches and merging. Branches allow you to create a
   separate route based on the original branch, where you can create changes and
   then merge them with the original branch. Let's create a "development"
   branch:

    ```
    git branch development
    ```

1. To list the branches:

    ```
    git branch
    ```
    
   This will show the branches that you have, the asterisk `*` indicates what
   branch you're currently active on.

1. To switch to the 'development' branch:

    ```
    git checkout development
    ```

1. To push a branch to a remote repository:

    ```
    git push origin development
    ```

1. Make some changes to the file in the 'development' branch. You generally
   create branches when you want to deviate in terms of development, and then
   usually merge your changes to the master branch.  Generally, your master
   branch is for all your stable releases, and your development branch is for
   new features.

1. Now let's merge our branches. Switch to the master branch:

    ```
    git checkout master
    ```

   Merge the development branch:

    ```
    git merge development
    ```

   Now the contents of your file should be the same as their contents in the 
   development branch. Finally, push:

    ```
    git push
    ```

1. To delete a branch use the `-d` flag:

    ```
    git branch -d development
    ```

   On Github, this is not enough. Delete them manually by listing all your
   branches with `View all branches`, you can find the button by clicking on
   your current branch button on the Github page.
