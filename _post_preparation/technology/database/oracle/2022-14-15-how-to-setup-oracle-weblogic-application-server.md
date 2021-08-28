---
layout: post
title: How to setup Oracle Weblogic application server
bigimg: /img/image-header/yourself.jpeg
tags: [Weblogic]
---


<br>

## Table of Contents
- [Introduction to Oracle Weblogic](#introduction-to-oracle-weblogic)
- [Steps to install oracle weblogic](#steps-to-install-oracle-weblogic)
- [Steps to install DataSource](#steps-to-install-datasource)
- [Steps to install WAR file](#steps-to-install-war-file)
- [Steps to configure security realms for users](#steps-to-configure-security-realms-for-users)
- [Some problems when working weblogic](#some-problems-when-working-weblogic)
- [Wrapping up](#wrapping-up)


<br>

## Introduction to Oracle Weblogic






<br>

## Steps to install oracle weblogic

1. Setup Oracle weblogic



2. Configure a new domain



<br>

## Steps to install DataSource

By default, Weblogic defines **AdminServer**. To check it, we can jump to **Domain Structure**.

![](../img/oracle/weblogic/domain-structure.png)

In **Environment > Servers**, we have:

![](../img/oracle/weblogic/admin-server.png)

Weblogic manages multiple servers, and each server will have one data source. After there was a server, we need to configure **DataSource** for it.

![](../img/oracle/weblogic/services-datasources.png)

In **Domain Structure**, go to **Services > Data Sources**, we have:

![](../img/oracle/weblogic/configure-data-source.png)

1. Naming for JDBC Data Source and JNDI

    In order to create a new DataSource, click **New** button, select **Generic Data Source** item.

    ![](../img/oracle/weblogic/configure-data-source-1.png)

    In an above image, we need to take care of something:
    - **Name**: the name of this new JDBC Data Source.

        For example, fill **newDS** into Name textbox.

    - **JNDI Name**: the JNDI name for this new JDBC Data Source.

        For example, fill **newDS** into JNDI Name textbox.

    - **Database Type**: select **Oracle** item in this drop down list.

    We can use the same name for both **Name** textbox and **JNDI Name** textbox.

2. Select driver for the selected database type

    ![](../img/oracle/weblogic/configure-data-source-2.png)

3. Configure the transaction's type

    ![](../img/oracle/weblogic/configure-data-source-3.png)
    
    Because our web application does not use distributed transactions, so we only configure **one-phase commit**, not using **two-phase commit**.

4. Configure database's information for this new data source

    ![](../img/oracle/weblogic/configure-data-source-4.png)

5. Test connection to our database

    ![](../img/oracle/weblogic/configure-data-source-5.png)

    To check connection between our computer and database, we can utilize **Test configuration** button.

    If it's successful, we can see that:

    ![](../img/oracle/weblogic/configure-data-source-6.png)

6. Select server to deploy DataSource

    ![](../img/oracle/weblogic/configure-data-source-7.png)

    This step is very important, because when we add war file in **Deployments** part, Weblogic needs to know the data source of the current server. If not defined, a javax.naming.namenotfoundexception exception will happen.


<br>

## Steps to install WAR file

Go to Deployments of Domain Structure part.

![](../img/oracle/weblogic/configure-war-file.png)

Then, we have:

![](../img/oracle/weblogic/configure-war-file-1.png)

Click **Install** button, we have:

![](../img/oracle/weblogic/configure-war-file-2.png)

We need to fill the path of war file into the **Path**'s textbox. And select this war file in radio button.

After that, we have:

![](../img/oracle/weblogic/configure-war-file-3.png)

Click **Next** button, it looks like:

![](../img/oracle/weblogic/configure-war-file-4.png)

Finally, click **Finish** button.


<br>

## Steps to configure security realms for users

0. Open Security Realms

    Go to **Domain Structure > Security Realms**.

    ![](../img/oracle/weblogic/configure-security-realms.png)

    Then, we have:

    ![](../img/oracle/weblogic/configure-security-realms-1.png)

    Click **myrealm** item in that table and select **Providers** tab.

    ![](../img/oracle/weblogic/configure-security-realms-2.png)

1. Create a new **Authentication Provider**

    After clicking **New** button, we have:

    ![](../img/oracle/weblogic/configure-security-realms-3.png)

    Then, we will choose **SQLAuthenticator** item of that drop down list. The **Name** textbox is the **Authentication Provider**'s name.

    Click OK button, we created an Authentication Provider.

    ![](../img/oracle/weblogic/configure-security-realms-4.png)

    Click **SQLAuthenticator1** authentication provider, we have:

    ![](../img/oracle/weblogic/configure-security-realms-5.png)

    Select **ProviderSpecific** tab in **SQLAuthenticator1**, we have:

    ![](../img/oracle/weblogic/configure-security-realms-6.png)

    In this tab, we have two things we need to note:
    - **Data Source Name**: the name of Data Source that we configured.
    - **Group Membership Searching**: select **unlimited** item in this drop down list.

    Click **Save** button in **Provider Specific** tab.

2. Configure the **DefaultAuthenticator**

    Continuously, configure information for **DefaultAuthenticator**. Come back to the **Providers > Authentication** tab, we have.

    ![](../img/oracle/weblogic/configure-security-realms-7.png)

    Click **DefaultAuthenticator** provider, then we have its content.

    ![](../img/oracle/weblogic/configure-security-realms-8.png)

    In **DefaultAuthenticator** provider, select **Optional** item in **Control Flag**.

3. Configure the SQLAuthenticator1

    The steps of this section is as same as an above section.

    ![](../img/oracle/weblogic/configure-security-realms-9.png)

    Select **Sufficient** item in **Control Flag**.

4. Restart servers

5. Create a new user

    Go to Security Realms > myrealm > Users and Groups.


<br>

## Some problems when working weblogic
1. Unable to resolve '...'. Resolved ''; remaining name '...' weblogic or happens javax.naming.namenotfoundexception

    - Given problem



    - Solution

        Unlike Tomcat, weblogic creates multiple servers (Usually an Admin Server, plus at least one other). Each server has to be allocated the data source. In a clustered environment, you need to apply the datasource to the cluster servers.

        - Log into the Weblogic console, and check the datasource JNDI name (don't confuse this with the datasource name, which is purely to keep the console listing looking pretty). The JNDI name should be something like jdbc/MyDB

        - Check the datasource Targets tab, and make sure it is applied to the server/cluster you are going to deploy your web app to.

        - Restart Weblogic. I find that data sources sometimes need this before they become visible to application code.

        - Deploy your web app to the correct server/cluster.


<br>

## Wrapping up






<br>

[https://stackoverflow.com/questions/25258461/javax-naming-namenotfoundexception-unable-to-resolve-mydb-resolved-weblog](https://stackoverflow.com/questions/25258461/javax-naming-namenotfoundexception-unable-to-resolve-mydb-resolved-weblog)

[https://www.oracle.com/webfolder/technetwork/tutorials/obe/fmw/wls/12c/12_2_1/01-16-001-ConfigDataSource/configds.htm](https://www.oracle.com/webfolder/technetwork/tutorials/obe/fmw/wls/12c/12_2_1/01-16-001-ConfigDataSource/configds.htm)