---
layout: post
title: The differences between rebase and merge commands in Git
bigimg: /img/image-header/yourself.jpeg
tags: [Git]
---




<br>

## Table of contents
- [Git rebase](#git-rebase)
- [Git merge](#git-merge)
- [The differences between rebase and merge commands](#the-differences-between-rebase-and-merge-commands)
- [Wrapping up](#wrapping-up)

<br>

## Given the problem
Assuming that we have two branches: feature and master. Of course, feature branch is separated from master branch at a specific commit. feature branch is used to develop some new functionalities.

So, our responsibility is to merge master branch to feature branch. 

![](../img/Git-guide/merge-rebase/summary-rebase-merge.png)

<br>

## Git rebase


![](../img/Git-guide/merge-rebase/git-rebase.png)


<br>

## Git merge


![](../img/Git-guide/merge-rebase/git-merge.png)

<br>

## The differences between rebase and merge commands



<br>

## Wrapping up
- Use ```git rebase``` carefully because it can make our source code that is remove completely. Especially, when we use rebase for sub-branch, not master branch or parent branch.

<br>

Thanks for your reading.

<br>

Refer:

[https://www.atlassian.com/git/tutorials/merging-vs-rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)

[https://viblo.asia/p/git-merging-vs-rebasing-3P0lPvoGKox](https://viblo.asia/p/git-merging-vs-rebasing-3P0lPvoGKox)

[https://git-scm.com/book/vi/v1/Ph%C3%A2n-Nh%C3%A1nh-Trong-Git-Rebasing](https://git-scm.com/book/vi/v1/Ph%C3%A2n-Nh%C3%A1nh-Trong-Git-Rebasing)

[https://medium.com/@lvhan/merge-v%C3%A0-rebase-e72236c40368](https://medium.com/@lvhan/merge-v%C3%A0-rebase-e72236c40368)

[https://backlog.com/git-tutorial/vn/stepup/stepup2_8.html](https://backlog.com/git-tutorial/vn/stepup/stepup2_8.html)

[https://www.codehub.vn/Tim-Hieu-Ve-Rebase-Trong-Git](https://www.codehub.vn/Tim-Hieu-Ve-Rebase-Trong-Git)

[https://viblo.asia/p/3-phut-de-hieu-ro-git-rebase-va-merge-khac-nhau-gi-vyDZOXnQlwj](https://viblo.asia/p/3-phut-de-hieu-ro-git-rebase-va-merge-khac-nhau-gi-vyDZOXnQlwj)

[https://viblo.asia/p/git-merging-vs-rebasing-3P0lPvoGKox](https://viblo.asia/p/git-merging-vs-rebasing-3P0lPvoGKox)

[https://lcdung.top/su-khac-biet-giua-git-merge-va-git-rebase-la-gi/](https://lcdung.top/su-khac-biet-giua-git-merge-va-git-rebase-la-gi/)

[https://manhhomienbienthuy.bitbucket.io/2017/Apr/21/how-git-rebase-works.html](https://manhhomienbienthuy.bitbucket.io/2017/Apr/21/how-git-rebase-works.html)

[https://techblog.vn/3-phut-de-hieu-ro-git-rebase-va-merge-khac-nhau-gi](https://techblog.vn/3-phut-de-hieu-ro-git-rebase-va-merge-khac-nhau-gi)