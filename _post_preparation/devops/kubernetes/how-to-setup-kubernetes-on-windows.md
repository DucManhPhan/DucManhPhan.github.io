---
layout: post
title: How to setup Kubernetes on Windows
bigimg: /img/image-header/yourself.jpeg
tags: [DevOps, Kubernetes]
---



<br>

## Table of contents
- [Given problem](#given-problem)
- []()
- []()
- [Wrapping up](#wrapping-up)


<br>

## Given problem

Currently, our projects are often deployed with 3 instances by using Docker. Our problem is that how can we manage this cluster like to reduce issues such as scalability, 




<br>

## Pre-requisites

1. Installed Docker Desktop.

    In this item, we can refer to the following article: [Understanding about Docker](https://ducmanhphan.github.io/2020-05-07-understanding-about-docker/#how-to-setup-docker).


<br>

## Step 1: Install kubectl

- Firstly, go to the following page of Kubernetes: [https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/).

    ![](../../../img/devops/container-orchestrator/kubenetes/setup/kubernetes-1.png)

- Then, select [Install kubectl on Windows](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/) item.

    ![](../../../img/devops/container-orchestrator/kubenetes/setup/kubernetes-2.png)

    In this step, we will follow **Install kubectl binary curl on Windows** section.

    - Download the kubectl with version - 1.29.0.

        ![](../../../img/devops/container-orchestrator/kubenetes/setup/kubernetes-3.png)

        Then, we have:

        ![](../../../img/devops/container-orchestrator/kubenetes/setup/kubernetes-4.png)

    - Double click this executable file of kubectl to install it.

        

    - Next step is that we will add the path of kubectl to the **Environment Variables** of Windows.

        Before doing this, we need to take care the note of Kubentes about kubectl of Docker Desktop for Windows like the below image.

        ![](../../../img/devops/container-orchestrator/kubenetes/setup/kubernetes-5.png)

        Then, start to setup PATH of kubectl for Environment Variables.




<br>

## Step 2: Install Minikube






<br>

## Step 3: Setup connections for Minikube





<br>

## Wrapping up




<br>

Refer:

[]()
