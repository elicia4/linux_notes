### These are notes on the "Git Essentials" video by Learn Linux TV ###
### 	Here is the link to it: https://youtu.be/u1Zvkqjx0Ik	    ###
Git is a version control utility.
It helps to keep track of files and changes to them.

#######################################################################
1. To create a repository with git, type:
	git init name-of-repo
	(you can use 'git init' from inside of a folder to 
	initialize it)
#######################################################################
2. There is a feature called "branch" in git. It allows a user to take
a project to a different direction without creating it on the 'main'
branch (that is, the main part of the project) and test it.
#######################################################################
3. Don't delete the .git repository, it contains all git-related
information inside
#######################################################################
4. Output current status of your repository:
	git status
#######################################################################
5. Add file to version control:
	git add name-of-file ...
#######################################################################
6. You should set up your user info to indicate what part of the 
project you're working on:
	NOTE: These settings will be global, they will
	apply to all projects

	# your name
	git config --global user.name "Phone Headphone"
	# your email
	git config --global user.email "phone@headpho.ne"
#######################################################################
7. "git add" doesn't actually add file to version
control, but instead adds it to the current commit
you're working on. Commit is more like a packaging 
of changes. To commit, type:
	git commit -m "add message here"
#######################################################################
8. If you make changes to a file, its status
will be changed to 'modified'. Try 'git status', then
add a couple lines to a file and then run 'git status'
again.
#######################################################################
9. To check what changed in a file since the last
commit, use:
	git diff file-name
The ability to track changes, for example, to config
files, is extremely useful. Instead of
reading through the entire file and FIGURING OUT
what changed, you can simply use 'git diff' and
SEE EXACTLY what changed. This is particularly
useful for system administators.
#######################################################################
10. If you run git commit without the '-m' option,
a text editor will be opened and you can type your
commit message there. This can be useful if your commit message consists
of multiple lines, you want to think about it, you like working in text 
from a text editor and so on.
#######################################################################
11. To revert things back to a previous commit,
follow this process:
	list commits one line at a time:
	git log --oneline
	The command will list hashes and commit
	messages.
	To revert, type git revert hash-of-the-CURRENT-version

	For example:

	git log --oneline
	>dadadad (HEAD -> main) Update hello.txt
	>aaaaaaa initial commit (you want to return to
	this commit)
	git revert dadadad 
#######################################################################
12. To download an existing repository from git:
	1) Go to that repository's page
	2) Click on green 'Code' button
	3) Copy the 'https' link
	4) In terminal, navigate to the folder you'd like to copy the 
	repository to
	5) Use command:
		git clone COPIED-LINK-HERE
#######################################################################
13. To view the url changes will be sent to, view .git/config:
	...
	url = ...
	...
#######################################################################
14. Push an existing repository to github:
	1) Log in to github
	2) Plus sign top right, click on 'New repository'
	3) Fill in the form
	4) Instructions will be provided there, currently they are:
	
	git remote add origin git@github.com:user-name/sample-name.git
	git branch -M master
	git push -u origin master

