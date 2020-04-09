---
layout: post
title: Why the total number of bitcoin is limited?
bigimg: /img/path.jpg
tags: [Blockchain]
---

When I have just began to find out something in blockchain, especially bitcoin, I read the way that bitcoin works. Looking at the information 'There are approximately only 21 millions bitcoin that is mined in the world.", I'm always curious about why they can calculate this number. 

After arduous days, I have dig into the bitcoin. I think I know about why to have the number of bitcoin.

<br>

## Table of Contents
- [Given Problem](#given-problem)
- [Solution](#solution)

## Given Problem

With bitcoin, each 10 minutes, there is a block mined from miners all over the world. The origin value of bitcoin is 50 bitcoin. After each 4 years, the value of bitcoin will reduce two times. So, calculate the total number of bitcoin?

<br>

## Solution

Because in 10 minutes, one block will be mined. So in 1 hour, there will be 6 blocks to be mined. 

In addition, after each 4 years, the value of bitcoin will be reduce 2 times. The below we have the mathematic: 

Money_bitcoins = number_blocks_in_hour * number_hours_in_one_day * number_days * number_years * value_bitcoins * sum(all_changes_value_bitcoin)

Then, we have: 

Money_bitcoins = 6 * 24 * 365 * 4 * 50 * (1 + 1/2 + 1/4 + 1/8 + ...) (1)

=> 2 * Money_bitcoins = 6 * 24 * 365 * 4 * 50 * (2 + 1 + 1/2 + 1/4 + ...) (2)

Take the expression in (2) extract to expression in (1), we have; 

Money_bitcoins = 6 * 24 * 365 * 4 * 50 * 2 = 21,024,000 (bitcoin)


So, we can talk that the total number of bitcoin is approximately 21 milliions bitcoin.

Thanks for your reading.