---
layout: post
title: MapReduce in Hadoop
bigimg: /img/image-header/factory.jpg
tags: [Big Data, Hadoop]
---



<br>

## Table of contents





<br>

## 






<br>

## 





<br>

## Using Python to run MapReduce
1. Installing package MRJob

    - With HDP 2.6.5

        ```python
        # utility for installing Python packages
        yum install python-pip

        pip install mrjob==0.5.11

        yum install nano

        # Data files and the script
        wget http://media.sundog-soft.com/hadoop/ml-100k/u.data
        wget http://media.sundog-soft.com/hadoop/RatingsBreakdown.py
        ```
    
    - With HDP 2.5

        ```python
        # PIP
        cd /etc/yum.repos.d
        cp sandbox.repo /tmp
        rm sandbox.repo
        cd ~
        yum install python-pip

        # MRJob
        # we need to install a specific version of the Google API Python client
        pip install google-api-python-client==1.6.4
        pip install mrjob==0.5.11

        # Nano
        yum install nano

        # Data files and the script
        wget http://media.sundog-soft.com/hadoop/ml-100k/u.data
        wget http://media.sundog-soft.com/hadoop/RatingsBreakdown.py
        ```

2. Source code Python

    ```python
    from mrjob.job import MRJob
    from mrjob.step import MRStep

    class RatingsBreakdown(MRJob):
        def steps(self):
            return [
                MRStep(mapper=self.mapper_get_ratings,
                       reducer=self.reducer_count_ratings)
            ]

        def mapper_get_ratings(self, _, line):
            (userID, movieID, rating, timestamp) = line.split('\t')
            yield rating, 1

        def reducer_count_ratings(self, key, values):
            yield key, sum(values)

    if __name__ == '__main__':
        RatingsBreakdown.run()

    ```

3. Running with MRJob

    - Run locally

        ```
        python RatingsBreakdown.py u.data
        ```

    - Run with Hadoop

        ```
        python MostPopularMovie.py -r hadoop --hadoop-streaming-jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-streaming.jar u.data
        ```

<br>

## 






<br>

## Wrapping up






<br>

Refer:

[MapReduce Design pattern book]()

