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
- [Find conflits](#find-conflicts)
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

## Discard all changes in specific file

```javascript
git checkout -- <file_name>
```

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

## Find conflits

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

## Rever one commit, push it

```javascript
git revert COMMIT_ID
git push origin master
```

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

```javascript
git reset --soft HEAD~1
```

<br>

## Undo the last commit, without preserving local changes

```javascript
git reset --hard HEAD~1
```

<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

[https://viblo.asia/p/tap-hop-nhung-cau-lenh-git-huu-dung-dWrvwWr2vw38#_tao-mot-patch-37](https://viblo.asia/p/tap-hop-nhung-cau-lenh-git-huu-dung-dWrvwWr2vw38#_tao-mot-patch-37)

[https://orga.cat/posts/most-useful-git-commands](https://orga.cat/posts/most-useful-git-commands)