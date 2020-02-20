---
layout: post
title: How to use Spring RestTemplate to communicate with other systems
bigimg: /img/path.jpg
tags: [Java, Spring]
---





<br>

## Table of contents





<br>

## Introduction to Spring RestTemplate





<br>

## Implementing with Post request

First, we will do something with post request for file.

```java
public void postFileRequest(String path, FilePart file) throws IOException {
    // save file in local server
    String pathLocal = pathUpload;
    File fileLocal = new File(path);
    if (!fileLocal.exists())
        fileLocal.mkdirs(); // or file.mkdir()

    fileLocal = new File(pathLocal + "/" + file.filename());
    fileLocal.createNewFile();
    file.transferTo(fileLocal);

    // work with headers
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.MULTIPART_FORM_DATA);
    setParamHeaders(headers, keyValueHeader);
    headers.set("Authorization", token);

    // prepate for request body
    Resource resource = new FileSystemResource(fileLocal);
    MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
    body.add("filePart", resource);

    HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
    String serverUrl = host + path;
    RestTemplate restTemplate = new RestTemplate();

    // send file
    try {
        ResponseEntity<String> response = restTemplate.postForEntity(serverUrl, requestEntity, String.class);
        System.out.println("Response: " + response);
    } catch (HttpStatusCodeException exception) {
        System.out.println("Response: " + exception.getStatusCode().value());
    }
}
```

<br>

## Implementing with Put request

We will use put request to push file to server to save it.

```java
private static final String pathUpload = "";

// if not exist, creating new file
private void checkExistFile(FilePart file) {

}

public void putRequest(String path, FilePart file) {
    // save file to local server
    String pathLocal = pathUpload;
    File fileLocal = new File(path);
    if (!fileLocal.exists())
        fileLocal.mkdirs(); // or file.mkdir()

    fileLocal = new File(pathLocal + "/" + file.filename());
    fileLocal.createNewFile();
    file.transferTo(fileLocal);

    // Prepare for request body
    Resource resource = new FileSystemResource(fileLocal);
    MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
    body.add("filePart", resource);

    // save headers
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.MULTIPART_FORM_DATA);
    setParamHeaders(headers, keyValueHeader);
    headers.set("Authorization", Constants.SESSION_TOKEN);

    // use with RestTemplate
    HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
    RestTemplate restTemplate = new RestTemplate(requestFactory);
    List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
    messageConverters.add(new FormHttpMessageConverter());
    messageConverters.add(new MappingJackson2HttpMessageConverter());
    restTemplate.setMessageConverters(messageConverters);

    // send request
    HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
    try {
        ResponseEntity<String> response = restTemplate.exchange(host + path, HttpMethod.PUT, requestEntity, String.class);
        System.out.println("Response: " + response);
    } catch (HttpStatusCodeException exception) {
        System.out.println("Response: " + exception.getStatusCode().value());
    }
}
```

<br>

## Implementing with Patch request

```java
public void setParamHeaders(HttpHeaders headers, Map<String, String> keyValueHeader) {
    for (Map.Entry<String, String> me : keyValueHeader.entrySet()) {
        headers.set(me.getKey().toString(), me.getValue().toString());
    }
}

public void patchRequest(String path, Object nsd) throws IOException {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_JSON);
    headers.set("Authorization", Constants.SESSION_TOKEN);

    setParamHeaders(headers, keyValueHeader);

    HttpEntity<?> httpEntity = new HttpEntity<Object>(nsd, headers);
    URL url = new URL(host + path);
    RestTemplate restTemplate = new RestTemplate();
    HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
    restTemplate.setRequestFactory(requestFactory);

    try {
        ResponseEntity<String> response = restTemplate.exchange(host + path, HttpMethod.PATCH, httpEntity,
                String.class);
        System.out.println("Response: " + response);
    } catch (HttpStatusCodeException exception) {
        System.out.println("Response: " + exception.getStatusCode().value());
    }
}
```



<br>

## Wrapping up








<br>

Refer:

[]()