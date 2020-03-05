---
layout: post
title: Some useful git commands
bigimg: /img/image-header/california.jpg
tags: [git]
---

Git is the popular source control system in Software development. Mastering it will make our life easier to live. So, we can completely concentrate on programming software.

This article will talk about some common or useful git commands that we always need to know, to use everytime.

Let's get started.

<br>

## Table of contents
- [Open git bash](#open-git-bash)
- [Create patch file](#create-patch-file) 
- [Clear screen in git bash](#clear-screen-in-git-bash)
- [Discard all changes in specific file](#discard-all-changes-in-specific-file)
- [Discard all changes in a branch](#discard-all-changes-in-a-branch)
- [See all changes](#see-all-changes)
- [Create patch file from commits](#create-patch-file-from-commits)
- [Apply a patch file to our branch](#apply-a-patch-file-to-our-branch)
- [Create a new branch](#create-a-new-branch)
- [Delete a branch](#delete-a-branch)
- [Push commits to specific branch](#push-commits-to-specific-branch)
- [Delete local's all removed files in repository](#delete-local-all-removed-files-in-repository)
- [Fetch data from all branches](#fetch-data-from-all-branches)
- [Delete all untracked files](#delete-all-untracked-files)
- [Unstage all files](#unstage-all-files)
- [List all branches that we are utilizing with latest order](#list-all-branches-that-we-are-utilizing-with-latest-order)
- [Find conflicts](#find-conflicts)
- [Merge other branch to our specific branch](#merge-other-branch-to-our-specific-branch)
- [Revert one commit, push it](#revert-one-commit-push-it)
- [Revert to the moment before one commit](#revert-to-the-moment-before-one-commit)
- [Undo the last commit, preserving local changes](#undo-the-last-commit-preserving-local-changes)
- [Undo the last commit, without preserving local changes](#undo-the-last-commit-without-preserving-local-changes)
- [Stop tracking a tracked file](#stop-tracking-a-tracked-file)
- [Update origin/master branch with our branch that is separated from local/master branch](#update-originmaster-branch-with-our-branch-that-is-separated-from-localmaster-branch)
- 
- [Wrapping up](#wrapping-up)


<br>

## Open git bash

```javascript
// from cmd 
start "" "C:\Program Files\Git\bin\sh.exe" --login

// open from context menu
```

<br>

## Create patch file

```javascript
git diff > file_name.patch

// push file into specific folder of patch file
git diff > ./patch_folder/file_name.patch
```

<br>

## Clear screen in git bash

```javascript
// clear Unix or Windows
clear

// or
Ctrl + L
```

<br>

## Discard all changes in specific file in our workspace
Problem: If we are typing something in a file. And then we save it to prepare commit/push it to Github. But we do not want to commit this file because it can make conflicts to a file in remote repository. So, we want to revert all changes in this file that we have not committed or pushed to remote repository.

```javascript
git checkout -- <file_name>
```

```git checkout``` alters files in the working directory to a state previously known to Git. We could provide a branch name or specific SHA we want to go back or, by default, Git will assume we want to checkout HEAD, the last commit on the currently checked-out branch.

Any changes we undo this way are really gone. They were never committed, so Git can't help us recover them later.

We need to check all changes with ```git diff > patch_file_name.patch``` before ```git checkout -- file_name```.

<br>

## Discard all changes in a branch

```javascript
// first way: discard any local changes which are not committed in ALL branches and master.
git checkout -f 

// second way: throw away everything since our last commit.
git reset --hard

```

<br>

## See the all changes

```javascript
// Check the all changes in a file, between current state and a branch
git diff branch_name path-to-file

// See differences between two commit 
git diff COMMIT_ID_1 COMMIT_ID_2

// See the files that changed between two commit
git diff --name-only COMMIT_ID_1 COMMIT_ID_2

// See the files changed in a specific commit
git diff-tree --no-commit-id --name-only -r COMMIT_ID

// or 

git show --pretty="format:" --name-only COMMIT_ID

// See diff with only the changed lines (no context)
git diff --unified=0

// See details (log message, text diff) of a commit
git show COMMIT_ID

// Count the number of commits
git rev-list HEAD --count
git rev-list COMMIT_ID --count
```

<br>

## Create patch file from commits

```javascript
// from one commit
git format-patch COMMIT_HASH_ID

// from the last two commit
git format-patch HEAD~2

// from all commits that have not push to remote branch yet
git format-patch origin/master

// Create patch file contains binary data
git format-patch --binary --full-index origin/master
```

<br>

## Apply a patch file to our branch

```javascript
git apply -v patch-name.patch

// apply a patch that is created from format-patch
git am patch-name.patch

// apply patch file that do not use git
patch < patch-name.patch
```

<br>

## Create a new branch

```javascript
// first way: use git checkout
git checkout -b new_branch_name     // --> create new branch and switch to it

// second way: use git branch
git checkout master // --> create new branch from master branch
git branch new_branch_name  // --> we are in master branch
git checkout new_branch_name
```

<br>

## Delete a branch

```javascript
git branch -d branch_name
```

<br>

## Push commits to specific branch

```javascript
git push -u origin branch_name
```

<br>

## Delete local's all removed files in repository

```javascript
git rm $(git ls-files --deleted)
```

<br>

## Fetch data from all branches

```javascript
git fetch origin
```

<br>

## Delete all untracked files

```javascript
git clean -f

// delete folder
git clean -f -d

// watch files before deleting
git clean -n -f -d
```

<br>

## Unstage all files

```javascript
git reset HEAD file.txt
```

<br>

## List all branches that we are utilizing with latest order

```javascript
git for-each-ref --sort=-committerdate refs/heads/ | head
```

<br>

## Find conflicts

```javascript
grep -H -r "<<<"
grep -H -r ">>>"
grep -H -r '^=======$' *
```

<br>

## Merge other branch to our specific branch

```javascript
git checkout our_branch_name       // switch to our branch
git merge other_branch             // merge other_branch into our_branch_name
```

<br>

## Revert one commit, push it
Problem: We have just ran ```git push``` to send all our changes to Github. And then, we find that we have some mistake about this commit. We want to revert this commit immediately.

```javascript
git revert COMMIT_ID
git push origin master
```

```git revert``` will create a new commit that's the opposite (or inverse) of the given SHA. If the old commit is "matter", the new commit is "anti-matter" — anything removed in the old commit will be added in the new commit and anything added in the old commit will be removed in the new commit.

So, we will use ```git push``` to send the new inverse commit to undo our mistaken commit.

<br>

## Revert to the moment before one commit

```python
# reset the index to the desired tree
git reset 56e05fced

# move the branch pointer back to the previous HEAD
git reset --soft HEAD@{1}

git commit -m "Revert to 56e05fced"

# Update working copy to reflect the new commit
git reset --hard
```

<br>

## Undo the last commit, preserving local changes
Problem: We have some commits locally (means that we have not pushed yet), and now, we want revert everything the last commit or some previous commits that specifies by using SHA

```javascript
// undo the last commit
git reset --soft HEAD~1

// undo the specify commit by using SHA
git reset --soft COMMIT_SHA

// finally, call it
git push -f origin branch_name
```

```git reset``` rewinds your repository's history all the way back to the specified SHA. It’s as if those commits never happened. By default, ```git reset``` preserves the working directory. The commits are gone, but the contents are still on disk. This is the safest option, but often, you'll want to "undo" the commits and the changes in one move—that's what ```--hard``` does

<br>

## Undo the last commit, without preserving local changes

```javascript
git reset --hard HEAD~1
git push -f origin branch_name
```

Source: [https://superuser.com/questions/523963/how-can-i-revert-back-to-a-git-commit](https://superuser.com/questions/523963/how-can-i-revert-back-to-a-git-commit)

<br>

## Stop tracking a tracked file
Problem: We accidentally added ```application.log``` to the repository, now every time you run the application, Git reports there are unstaged changes in application.log. You put ```*.log``` in the ```.gitignore``` file, but it's still there—how do you tell git to to "undo" tracking changes in this file?

```javascript
git rm --cached application.log
```

While ```.gitignore``` prevents Git from tracking changes to files or even noticing the existence of files it's never tracked before, once a file has been added and committed, Git will continue noticing changes in that file. Similarly, if you've used ```git add -f``` to "force", or override, ```.gitignore```, Git will keep tracking changes. You won't have to use ```-f``` to add it in the future.

If you want to remove that should-be-ignored file from Git's tracking, ```git rm --cached``` will remove it from tracking but leave the file untouched on disk. Since it's now being ignored, you won't see that file in git status or accidentally commit changes from that file again.

<br>

## Update origin/master branch with our branch that is separated from local/master branch
Problem: We have created a new branch ```feature``` from ```master``` branch, but ```master``` branch was pretty far behind ```origin/master```.

Now that ```master``` branch is in sync with ```origin/master```, we wish commits on ```feature``` were starting now, instead of being so far behind.

- ```origin``` is a remote.
- ```master``` is a local branch.
- ```origin/master``` is a remote branch (which is a local copy of the branch named "master" on the remote named "origin").

```javascript
git checkout feature
git rebase master
```

You could have done this with git reset (no ```--hard```, intentionally preserving changes on disk) then ```git checkout -b <new branch name>``` and then re-commit the changes, but that way, you'd lose the commit history. There’s a better way.

```git rebase master``` does a couple of things:
- First it locates the common ancestor between your currently-checked-out branch and master.
- Then it resets the currently-checked-out branch to that ancestor, holding all later commits in a temporary holding area.
- Then it advances the currently-checked-out-branch to the end of master and replays the commits from the holding area after master's last commit.

<br>

## Show URL of the remote repository
Problem: We want to check URL of our remote repository.

```python
# first way
git config --get remote.origin.url

# 2nd way
git remote show origin
```


<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

[https://viblo.asia/p/tap-hop-nhung-cau-lenh-git-huu-dung-dWrvwWr2vw38#_tao-mot-patch-37](https://viblo.asia/p/tap-hop-nhung-cau-lenh-git-huu-dung-dWrvwWr2vw38#_tao-mot-patch-37)

[https://orga.cat/posts/most-useful-git-commands](https://orga.cat/posts/most-useful-git-commands)