---
layout: post
title: Some latency numbers that we need to know
bigimg: /img/image-header/yourself.jpeg
tags: [Distributed System]
---

In order to design our system, we need to know exactly how many requests that our system can receive from clients, the total time to process requests, and how much memory that we need, ... But in this article, we will have some reference latency numbers to apply for creating better programs.

|                        Action                   |                            Time                          |
| ----------------------------------------------- | -------------------------------------------------------- |
| L1 cache reference                              | 0.5 ns                                                   |
| CPU Branch mispredict                           | 5 ns                                                     |
| L2 cache reference                              | 7 ns                                                     |
| Mutex lock / unlock                             | 25 ns                                                    |
| Main memory reference                           | 100 ns                                                   |
| Syscall on Intel 5150                           | 105 ns                                                   |
| Compress 1K bytes with Zippy                    | 3,000 ns = 3 us                                          |
| Context switch on Intel 5150                    | 4,300 ns = 4 us                                          |
| Send 2K bytes over 1 Gbps network               | 20,000 ns = 20 us                                        |
| SSD random read                                 | 150,000 ns = 20 us                                       |
| Read 1MB sequentially from memory               | 250,000 ns = 250 us                                      |
| Round trip within same data center              | 500,000 ns = 500 us                                      |
| Read 1 MB sequentially from SSD                 | 1,000,000 ns = 1 ms                                      |
| Disk seek                                       | 10,000,000 ns = 10 ms                                    |
| Read 1 MB sequentially from disk                | 20,000,000 ns = 20 ms                                    |
| Send packet from California to the Netherlands and receive a reply | 150,000,000 ns = 150 ms               |


Refer:

[https://medium.com/@hondanhon/more-latency-numbers-every-programmer-should-know-3142f0cf614d](https://medium.com/@hondanhon/more-latency-numbers-every-programmer-should-know-3142f0cf614d)

[https://colin-scott.github.io/personal_website/research/interactive_latency.html](https://colin-scott.github.io/personal_website/research/interactive_latency.html)

[http://highscalability.com/blog/2011/1/26/google-pro-tip-use-back-of-the-envelope-calculations-to-choo.html](http://highscalability.com/blog/2011/1/26/google-pro-tip-use-back-of-the-envelope-calculations-to-choo.html)