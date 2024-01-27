---
layout: post
title: Some AWS CLI commands for S3
bigimg: /img/image-header/yourself.jpeg
tags: [AWS, S3]
---



<br>

## Table of contents
- [The structure of AWS CLI command](#the-structure-of-aws-cli-command)
- [Important files of IAM](#important-files-of-iam)
- [Commands with CLI](#commands-with-cli)
- [Wrapping up](#wrapping-up)


<br>

## The structure of AWS CLI command

```bash
aws <command> <subcommand> [options and parameters]
```

**command** is the service name that we want to interact such as dynamodb, s3, cloudformation, ... **parameters** can take various types of input values including numbers, strings, lists, maps, and JSON structures.


<br>

## Important files of IAM

![](../../../../img/cloud/aws/cli/cli-1.png)

AWS provides the two necessary files: **config** and **credentials**. They are located in the **.aws** directory.

Below are their paths that depends on OS.
- Linux and MacOS.

    - `~/.aws/config`.
    - `~/.aws/credentials`.

- Windows.

    - `C:\Users\USERNAME\.aws\config`
    - `C:\Users\USERNAME\.aws\credentials`.

From [the documentation of AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html), we have:

- The **config** and **credentials** files are organized into sections. Sections include **profiles**, **sso-sessions**, and **services**. A section is a named collection of settings, and continues until another section definition line is encountered. Multiple profiles and sections can be stored in the config and credentials files.

- These files are plaintext files that use the following format:

    - Section names are enclosed in brackets [ ] such as **[default]**, **[profile user1]**, and **[sso-session]**.
    - All entries in a section take the general form of **setting_name=value**.
    - Lines can be commented out by starting the line with a hash character (**#**).

According to [the documentation of AWS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-where), we can put our credentials in **config** file. But AWS suggests keeping credentials in the **credentials** file.

In the article, we only focus on the **profile** section.

Normally, when we log into AWS, it will check information such as **aws_access_key_id**, **aws_secret_access_key** and in some files such as **config** and **credentials** in **.aws** directory.

Below is the content of these files:

- **config** file.

    ```properties
    [default]
    region={OUR-REGION}
    output=json
    ```

- **credentials** file.

    ```properties
    [default]
    aws_access_key_id={OUR-AWS-ACCESS-KEY-ID}
    aws_secret_access_key={OUR-SECRET-ACCESS-KEY}

    [profile_1]
    aws_access_key_id={OUR-AWS-ACCESS-KEY-ID-1}
    aws_secret_access_key={OUR-SECRET-ACCESS-KEY-1}
    ```

By default, AWS provides the **default** profile. If we want to have more profile for different account on different environments, we can define additional profile looks like the above **credentials** file. To specify which profile we use in a command, we need to utilize the option **--profile**.


<br>

## Commands with CLI

1. Get the specific information: Using `aws configure get` command.

    ```bash
    $ aws configure get region --profile profile_1

    ap-southeast-1
    ```

2. Set the specific information: Using `aws configure set` command.

    ```bash
    $ aws configure set region us-west-2 --profile profile_1
    ```

    To remove a setting, use an empty string as the value.

    ```bash
    $ aws configure set region "" --profile profile_1
    ```

3. Configure credentials manuall: Using `aws configure` command.

    ```bash
    $ aws configure

    AWS Access Key ID [None]: xxx
    AWS Secret Access Key [None]: xxx
    Default region name [None]: us-west-2
    Default output format [None]: json
    ```

4. Configure credentials by using csv file from IAM.

    ```bash
    aws configure import --csv file://credentials.csv
    ```

5. List all configuration data.

    ```bash
    $ aws configure list
    ```

6. List all profiles in our machine.

    ```bash
    $ aws configure list-profiles
    ```


<br>

## Wrapping up



