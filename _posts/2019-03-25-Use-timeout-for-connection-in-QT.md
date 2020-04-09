---
layout: post
title: Use timeout for connection in QT
bigimg: /img/image-header/california.jpg
tags: [Qt, C++]
---

In this article, we will try to understand about using timeout for our common problem in communicating between client and server. In QT, this bug will not resolve. So, we always look forward solution in a next update of QT.

<br>

## Table of contents
- [Context of problem](#context-of-problem)
- [Solution for timeout problem](#solution-for-timeout-problem)
- [Wrapping up](#wrapping-up)


<br>

## Context of problem
Normally, when we want to get data from server based on SOAP or RESTful API, in QT, we will use some classes to do this such as ```QNetworkRequest```, ```QNetworkReply```, and ```QEventLoop```.

```C++
QNetworkRequest req(QUrl("http://www.google.com"));
QNetworkReply *reply = nam.get(req);
QEventLoop loop;
connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
loop.exec();
```

But we will have problem in QEventLoop, mainly because this loop will work until the client receives data. So, when our computer have no internet, this loop is unlimited.

Therefore, normal solution for this problem is to set timeout for ```GET``` method in http. But in QT, it do not support the timeout. So, we have to manually implement timeout.

<br>

## Solution for timeout problem
Use ```QTimer``` to set timeout. Here are two ways to implement:

- Use ```QTimer``` with ```QEventLoop```

    ```C++
    void useReplyTimeout(QNetworkReply* reply) {
        QTimer timer;    
        timer.setSingleShot(true);

        QEventLoop loop;
        connect(&timer, SIGNAL(timeout()), &loop, SLOT(quit()));
        connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
        timer.start(30000);  // use miliseconds
        loop.exec();

        if(timer.isActive()) {
            timer.stop();

            if(m_reply->error() > 0) {
                ... // handle error
            }
            else {      
                int v = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();

                if (v >= 200 && v < 300) {  // Success
                    ...
                }
            }
        } else {
            // timeout
            disconnect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
            reply->abort();
        }
    }
    ```

    Using ```useReplyTimeout()``` function will make our program to work like a charm.

- Wrap all above things into ```ReplyTimeout``` class

    ```C++
    class ReplyTimeout : public QObject {
        Q_OBJECT
        QBasicTimer m_timer;
        HandleMethod m_method;

        public:
            enum HandleMethod { Abort, Close };

            QReplyTimeout(QNetworkReply* reply, const int timeout, HandleMethod method = Abort) :  
                QObject(reply), m_method(method)
            {
                Q_ASSERT(reply);
                if (reply && reply->isRunning()) {
                m_timer.start(timeout, this);
                connect(reply, &QNetworkReply::finished, this, &QObject::deleteLater);
            }

            static void set(QNetworkReply* reply, const int timeout, HandleMethod method = Abort) {
                new ReplyTimeout(reply, timeout, method);
            }
        protected:
            void timerEvent(QTimerEvent * ev) {
                if (!m_timer.isActive() || ev->timerId() != m_timer.timerId())
                return;
                auto reply = static_cast<QNetworkReply*>(parent());
                if (reply->isRunning()) {
                if (m_method == Close)
                    reply->close();
                else if (m_method == Abort)
                    reply->abort();
                m_timer.stop();
            }
    };
    ```

    When using ```ReplyTimeout``` class, I do not get data from server, although, I set timeout with a huge number. And I still do not understand why it is not working.

<br>

## Wrapping up
- We know about how to send request to server and get response from server.
- Using ```QTimer``` class to set timeout for our program.

<br>

Refer:

[https://stackoverflow.com/questions/13207493/qnetworkreply-and-qnetworkaccessmanager-timeout-in-http-request](https://stackoverflow.com/questions/13207493/qnetworkreply-and-qnetworkaccessmanager-timeout-in-http-request)

[https://stackoverflow.com/questions/37444539/how-to-set-qnetworkreply-timeout-without-external-timer](https://stackoverflow.com/questions/37444539/how-to-set-qnetworkreply-timeout-without-external-timer)

[http://amin-ahmadi.com/2016/04/05/check-internet-connection-availability-status-qt/](http://amin-ahmadi.com/2016/04/05/check-internet-connection-availability-status-qt/)