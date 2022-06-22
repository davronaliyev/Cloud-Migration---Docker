[Git Sheat Sheet](/src/git_cheat_sheet.pdf)

### Install Git

    choco install git -y

### Git Commands
* git config

    This command sets the author name and email address respectively to be used with your commits.

        git config –global user.name "[name]"

        git config –global user.email "[email address]'

* git add
    
    This command adds a file to the staging area.

        git add [file]

* git commit

    This command records or snapshots the file permanently in the version history.

        git commit -m “[ Type in the commit message]”

* git diff
    This command shows the file differences which are not yet staged.

        git diff

        git diff –staged

        git diff [first branch] [second branch]

* git reset

    This command upstages the file, but it preserves the file contents.

        git reset [file]

        git reset [commit]

        git reset –hard [commit]

* git status

    This command lists all the files that have to be committed.

        git status

* git rm

    This command deletes the file from your working directory and stages the deletion.

        git rm [file]

* git log

    This command is used to list the version history for the current branch.

        git log

* git show

    This command shows the metadata and content changes of the specified commit.

        git show [commit]

* git branch

    This command lists all the local branches in the current repository.

        git branch

        git branch [branch name]

        git branch -d [branch name]

* git checkout

    This command is used to switch from one branch to another.

        git checkout [branch name]

        git checkout -b [branch name]        

Remove file from pull request branch

    git checkout pull-request-branch
    git checkout origin/master -- context/testsettings.json
    git commit -m "Removed a modified file from pull request"
    git push origin pull-request-branch

Create a new branch

    git switch -c <new-branch-name>

Delete Branch

    // delete branch locally
    git branch -d <local-branch-name>

    // delete branch remotely
    git push origin --delete <remote- branch-name>
    
    // delete with commits
    git branch -D <local-branch-name>

Viewing unpushed Git commits
	
    git log origin/master..HEAD

Git Reset

    Delete the most recent commit:

        git reset --hard HEAD~1

    Delete the most recent commit, without destroying the work you've done:

        git reset --soft HEAD~1

Git Stash

The git stash command takes your uncommitted changes (both staged and unstaged), saves them away for later use, and then reverts them from your working copy.

    - git stash
    - git stash show
    
    stash one file
    - git stash push <filename>
    - git stash push -m my-message

