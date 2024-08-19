# Git Tags

Notes on the Progit book.

[***Contents***](README.md)

---

Git has the ability to tag specific points in a repository's history as being
important. Typically, people use this functionality to mark release points
(v1.0, v2.0 and so on). 

### Listing Tags

To list your tags:

```bash
git tag
```

This command lists the tags in alphabetical order. You can also search for tags
that match a pattern, e.g., to look for tags that start with `v1.8.5`:

```bash
git tag -l "v1.8.5*"
```

Note that in this case the use if `-l`/`--list` is mandatory.

### Creating Tags and Types

There are two types of tags:
- lightweight
- annotated

A lightweight tag is very much like a branch that doesn't change — it's just a
pointer to a specific commit.

Annotated tags, however, are stored as full objects in the Git database.
- they're checksummed
- contain the tagger name, email, and date
- have a tagging message
- can be signed and verified with GNU Privacy Guard (GPG)

It's generally recommended that you create annotated tags so you can have all
this information; but if you want a temporary tag or for some reason don't want
to keep the other information, lightweight tags are available too.

`-a` to create an annotated tag:

```bash
git tag -a v1.4 -m "my version 1.4"
git tag
```

`-m` specifies a message. To see the tag data along with the message:

```bash
git show v1.4
```

Another way to tag commits is with a lightweight tag. This is the commit
checksum in a file - no other information is kept. It's created by default (w/o
arguments):

```bash
git tag v1.4-lw
```

Now you won't get any extra information:

```bash
git show v1.4-lw
```

To tag a previous commit:

```bash
# git tag -a <tag> <commit-checksum>
git tag -a v1.2 9fc
git show v1.2
```

### Sharing Tags

By default, `git` doesn't push tags. You have to specify the tag to be pushed
explicitly:

```bash
git push origin v1.5
```

To push all of your tags:

```bash
git push origin --tags
```

To push only annotated tags:

```bash
git push <remote> --follow-tags
```

### Deleting Tags

To delete a local tag:

```bash
git tag -d v1.4-lw
```

To delete a remote tag:

```bash
git push origin :refs/tags/v1.4-lw 
# null value before the colon is being pushed to the remote tag name,
# effectively deleting it.
```

A better way to do it:

```bash
git push origin --delete <tagname>
```

### Checking Out Tags

To view the versions of files a tag is pointing to:

```bash
git checkout v2.0.0
```

This puts your repository in "detached HEAD" state, which has some ill side
effects. 

In "detached HEAD" state, if you make changes and then create a commit, the tag
will stay the same, but your new commit won't belong to any branch and will be
unreachable, except by the exact commit hash. 

Thus, if you need to make changes - say you're fixing a bug on an older
version, for instance - you will generally want to create a branch:

```bash
git checkout -b version2 v2.0.0
```

If you do this and make a commit, your version2 branch will be slightly
different than your v2.0.0 tag since it will move forward with your new
changes. (Maybe it's better to avoid this altogether)
