---
layout: post
title: Uploading files with AWS S3 in Spring Boot
bigimg: /img/path.jpg
tags: [java]
---






## Common Problems
- Region problem

    ```
    The bucket is in this region: ap-southeast-1. Please use this region to retry the request.
    ```

    This problem occurs when our AmazonS3Client is set to a different region, then, the bucket we are calling.

    So, we have to change our old region into correct region.

    Or 

    When we are using code:

    ```java
    AmazonS3 s3Client = new AmazonS3ClientBuilder()
            .withEndpointConfiguration(
                    new EndpointConfiguration("s3-us-west-2.amazonaws.com", ""us-west-2"))
            .build());
    ```

    Also we recommend configuring just a region rather than endpoint and region. The SDK will automatically compute the endpoint for you.

    Use this [link](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/services/s3/AmazonS3Builder.html#enableForceGlobalBucketAccess--) to reference ```enableForceGlobalBucketAccess()```.

    ```java
    AmazonS3 s3Client = new AmazonS3ClientBuilder()
            .withRegion(Regions.US_WEST_2)
            .enableForceGlobalBucketAccess()
            .build());
    ```

- Key problem

    ```
    The specified key does not exist.
    ```

    This problem happens when we download files form AWS S3.

- Uploaded files path problem

    When we want to know about URL of files that has just uploaded in AWS S3, we have to know about our endpoint that is correponsed to our region, bucket's name, and file's name.

    For example: 

        ```
        Bucket's name: AMAZON_S3_BUCKET 
        File's name: our-file

        Our region: ap-southeast-1
        => endpoint: apigateway.ap-southeast-1.amazonaws.com
        or https://s3.amazonaws.com        

        => URL of our file will be: 
        apigateway.ap-southeast-1.amazonaws.com/AMAZON_S3_BUCKET/our-file
        
        or 

        https://s3.amazonaws.com /AMAZON_S3_BUCKET/our-file

        or

        https://AMAZON_S3_BUCKET.OUR_BUCKET_REGION.s3.amazonaws.com/our-file

        ```


<br>

Refer:

[https://grokonez.com/spring-framework/spring-cloud/amazon-s3-uploaddownload-files-springboot-amazon-s3-application](https://grokonez.com/spring-framework/spring-cloud/amazon-s3-uploaddownload-files-springboot-amazon-s3-application)

[https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region)