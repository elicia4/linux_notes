# GitHub Pull Requests

Notes on this video by Fireship: https://youtu.be/8lGpZkjnkt4

[***Contents***](README.md)

---

A pull request is a way for you to submit a contribution to another developer's
repository on GitHub.

1. Find a GitHub repo you want to contribute to.
1. Fork the repo.
1. Clone your fork to your local system.
1. Create a new branch and switch to it:

    ```
    git branch <branch-name>
    git checkout <branch-name>
    ```

   Or with a single command:

    ```
    git checkout -b <branch-name>
    ```

1. Then make changes, add and commit them.
1. Push:

    ```
    git push origin <branch-name>
    ```

1. On your GitHub page, you will now see a button to make a new pull request.
   Make sure to follow the contribution guidelines for the owner's repo. It's
   bad etiquette to submit a pull request without discussing it in the issues
   first.

TIP: When working with the fork locally, you can keep it in sync with the
original, by first adding the remote link to the upstream repo. When things 
change in that repo, you can fetch to download the changes, and then rebase to
add them on top of your existing work:  

```
git remote add upstream git://github.com/some-url
git fetch upstream
git rebase upstream/master
```
