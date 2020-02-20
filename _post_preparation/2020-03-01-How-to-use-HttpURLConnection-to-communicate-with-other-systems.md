---
layout: post
title: How to use HttpURLConnection to communicate with other systems
bigimg: /img/path.jpg
tags: [Java]
---





<br>

## Table of contents
- [Introduction to HttpURLConnection](#introduction-to-httpurlconnection)
- 
- [Benefits and Drawbacks](#benefits-and-drawbacks)
- [Wrapping up](#wrapping-up)

<br>

## Introduction to HttpURLConnection





<br>

## Preparing parameter headers for HttpURLConnection

In our requests, we have so many parameters of Http Header, RequestBody. So, in this section, we will create some methods to take on the parameters of Http Header.

```java
public void createParamHeaders(String param1, String param2) {
    Map<String, String> keyValueHeaders = new HashMap<String, String>();
    keyValueHeaders.put("param1", param1);
    keyValueHeaders.put("param2", param2);

    return keyValueHeaders;
}

public void setParamHeadersForRequest(HttpURLConnection conn,
                                      Map<String, String> keyValueHeaders) {
    for (Map.Entry<String, String> me : keyValueHeaders.entrySet()) {
        conn.setRequestProperty(me.getKey().toString(), me.getValue().toString());
    }
}

public void setAuthorizationForRequest(HttpURLConnection conn, String token) {
    if (StringUtils.isNotEmpty(token)) {
        conn.setRequestProperty("Authorization", token);
    }
}
```

<br>

## Implementing with Post request

- With request body that is formatted in json

    ```java
    public static final String host = "";

    public void postRequest(String path, String requestBody) {
        URL url = new URL(host + path);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");

        setParamHeadersForRequest(conn, createParamHeaders());
        setAuthorizationForRequest(conn, token);

        if (StringUtils.isNotEmpty(requestBody)) {
            OutputStream os = conn.getOutputStream();
            os.write(requestBody.getBytes());
            os.flush();
            os.close();
        }

        // To work with response
        // (1) - we only get response code
        // int responseCode = conn.getResponseCode();
        // System.out.println("Response code is: " + responseCode);

        // (2) - we can get all information of response
        BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
        String output, response = "";
        System.out.println("Output from Server .... \n");
        while ((output = br.readLine()) != null) {
            response += output;
        }
        JSONObject js = XML.toJSONObject(response);
    }
    ```

- With request body that is formatted xml (use SOAP)

    ```java
    public static List<DataPackageDto> postRequest(InvitationDto dto) {
        ResourceBundle resource = ResourceBundle.getBundle("config/globalConfig");
        String test = resource.getString("test");
        if ("1".equals(test)) {
            return CallApiDataPackage_87(dto);
        }
        
        List<DataPackageDto> list = new ArrayList<>();
        String URL_DATAPACKAGE = resource.getString("URL_DATAPACKAGE");
        try {
            URL obj = new URL(URL_DATAPACKAGE);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "text/xml;charset=UTF-8");
            String xml
                    = //"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                    //+ " <?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                    "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.ussd098.viettel.com/\">"
                    + " <soapenv:Header/>"
                    + " <soapenv:Body>"
                    + " <ws:getUssdMenu>"
                    + " <!--Optional:-->"
                    + " <user>" + new SecurityUtil().decrypt(Config.getInstance().getUserWs()) + "</user>"
                    + " <!--Optional:-->"
                    + " <password>" + new SecurityUtil().decrypt(Config.getInstance().getPassWs()) + "</password>"
                    + " <!--Optional:-->"
                    + " <msisdn>" + "84" + DataUtil.FormatIsdn(dto.getIsdnB()) + "</msisdn>"
                    + " <!--Optional:-->"
                    + " <type>INTERNET,COMBO,HOT,DATAPLUS,EVENT</type>"
                    + " </ws:getUssdMenu>"
                    + " </soapenv:Body>"
                    + "</soapenv:Envelope>";
            
            con.setDoOutput(true);
            String encoded = Base64.getEncoder().encodeToString((new SecurityUtil().decrypt(Config.getInstance().getUserAuth())
                    + ":" + new SecurityUtil().decrypt(Config.getInstance().getPasswsAuth())).getBytes(StandardCharsets.UTF_8));  //Java 8
            con.setRequestProperty("Authorization", "Basic " + encoded);
            logger.info("CallApiDataPackage Authorization info: " + encoded);
            //formart user, pass ve ***
            String requestCallDataPackageHideUser = hideSensitiveInfo(xml, "user");
            String requestCallDataPackage = hideSensitiveInfo(requestCallDataPackageHideUser,"password");
            logger.info("CallApiDataPackage request " + "isdnB :" + dto.getIsdnB() + requestCallDataPackage);
            
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(xml);
            wr.flush();
            wr.close();
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            String jsonxml = response.toString();
            logger.info("CallApiDataPackage response " + "isdnB : "+ dto.getIsdnB() + " " + jsonxml);
            
            JSONObject jsonObject = XML.toJSONObject(jsonxml);
            JSONArray jsonArray = jsonObject.getJSONObject("S:Envelope").getJSONObject("S:Body")
                    .getJSONObject("ns2:getUssdMenuResponse")
                    .getJSONObject("return").getJSONArray("product");
            for (int i = 0; jsonArray != null && i < jsonArray.length(); i++) {
                JSONObject json = jsonArray.getJSONObject(i);
                DataPackageDto tmp = new DataPackageDto();
                JsonUtil.fillObject(json.toString(), tmp);
                list.add(tmp);
            }
            con.disconnect();
        } catch (Exception e) {
            logger.error("CallApiDataPackage Error IsdnB : " + dto.getIsdnB() + " ", e);
        }
        return list;
    }
    ```

<br>

## Implementing with Get request

```java
public void getRequest(String path, String requestBody) {
    URL url = new URL(host + path);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setDoOutput(true);
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Content-Type", "application/json");

    setParamHeadersForRequest(conn, createParamHeaders());
    setAuthorizationForRequest(conn, token);

    if (StringUtils.isNotEmpty(requestBody)) {
        OutputStream os = conn.getOutputStream();
        os.write(requestBody.getBytes());
        os.flush();
        os.close();
    }

    int responseCode = conn.getResponseCode();
    System.out.println("Response code is: " + responseCode);
}
```


<br>

## Implementing with Put request

First, we will use put request for object.

```java
public void putRequest(String path, String requestBody) {
    URL url = new URL(host + path);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setDoOutput(true);
    conn.setRequestMethod("PUT");
    conn.setRequestProperty("Content-Type", "application/json");

    setParamHeadersForRequest(conn, createParamHeaders());
    setAuthorizationForRequest(conn, token);

    if (StringUtils.isNotEmpty(valueInput)) {
        OutputStream os = conn.getOutputStream();
        os.write(valueInput.getBytes());
        os.flush();
        os.close();
    }

    int responseCode = conn.getResponseCode();
    System.out.println("Response code is: " + responseCode);
}
```

<br>

## Implementing with Delete request

```java
public void deleteRequest(String path) throws IOException {
    URL url = new URL(host + path);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setDoOutput(true);
    conn.setRequestMethod("DELETE");
    conn.setRequestProperty("Content-Type", "application/json");

    setParamHeadersForRequest(conn, createParamHeaders());
    setAuthorizationForRequest(conn, token);

    int responseCode = conn.getResponseCode();
    System.out.println("Response code is: " + responseCode);
}
```


<br>

## Benefits and Drawbacks
1. Benefits



2. Drawbacks

    - It's just a very old API.
    
        The first version of Java was released more than 20 years ago in 1996. HttpURLConnection was added to Java in JDK 1.1, which was released in 1997. It's designed around the HTTP/1.1 timeframe. Things weren't clear-cut as they are now in terms of modeling HTTP requests and responses and typical interaction patterns.

        And it doesn't include generics, enums, and lambdas, so it feels really clunky to use in modern Java. Even though, HttpURLConnection is being replaced with HttpClient in Java 11.

    - In HttpURLConnection's code, we can find some weird things that we need to know

        ```java
        try {
            URL url = new URL("http://google.com");
            HttpURLConnection conn = (HttpURLConnection) conn.openConnection();     // (1)
            conn.setRequestMethod("GET");   // (2)
            conn.setRequestProperty("User-Agent", "...");
            if (conn.getResponseCode() == 200) {
                System.out.println(readInputStream(conn.getInputStream()));     // (3)
            } else {
                System.out.println("Something wrong there");
            }
        } catch(IOException ex) {
            System.out.println("Something wrong there");
        }
        ```

        At (1) line, when we call openConnection() method on the URL, we get back a URL connection. However, we know the URL points to an HTTP server, so we want to configure it as such. Therefore, we need to first cast it to HttpURLConnection.
        
        At (2) line, when configuring the HTTP RequestMethod pass in a string because there were no enums when this API was designed. However, we could easily pass in a malformed string.

        At (3) line, it's difficult to realize that it's the actual handling of the response body. There we see that we can ask the connection for the input stream. But that's a raw input stream. Therefore, we need to write a helper method, in this case, readInputStream() to take that raw input stream and turn it into something useful. That's pretty low-level code that we have to write there with lots of possibilities.for subtle errors.

    - The Http method **PATCH** does not support.

    - An exception is thrown directly when encountering errors such as 400 Bad Request, 404 Not Found. So, we need to use exception handling try/cathch to handle our exceptions.

<br>

## Wrapping up
- If our project do not use JDK 11, to communicate with other systems, we can use other third-party libraries such as the Apache HttpComponents project, which also offers an HttpClient API, and OkHttp from Square, which is another opensource HttpClient for Java, and there's also even higher-level libraries like the JAX-RS Rest client. This REST client doesn't only perform HTTP requests, but it also knows about REST principles, and can, for example, automatically map JSON responses to Java objects. 







<br>

Refer:

[https://www.javacodegeeks.com/2014/09/caveats-of-httpurlconnection.html](https://www.javacodegeeks.com/2014/09/caveats-of-httpurlconnection.html)