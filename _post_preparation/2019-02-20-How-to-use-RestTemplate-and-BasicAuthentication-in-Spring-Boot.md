---
layout: post
title: How to use RestTemplate and BasicAuthentication in Spring Boot
bigimg: /img/path.jpg
tags: [Java, Http Client, Spring]
---



## Source code


```java
@RestController
public class RestItemController {
    @Autowired
    ItemService itemService;
    
//    static final String URL_ITEMS = "http://localhost:8080";
    
//    @GetMapping("/allItems")
//    ResponseEntity<List> getAllItems() {
//        List<Item> items = Lists.newArrayList(itemService.findAll());
//        return ((items == null) || items.isEmpty()) ?  new ResponseEntity<List>(NO_CONTENT)
//                : new ResponseEntity<List>(items, OK);    
//    }
    
    @GetMapping("/api/all-items")
    public ResponseEntity<List<Item>> restAllItems() {                 
//        RestTemplate restTemplate = new RestTemplate();
//        HttpEntity<String> request = new HttpEntity<String>(AuthenUtils.createHeaders());        
//        
//        ResponseEntity<List<Item>> response = restTemplate.exchange(URL_ITEMS + "/allItems", HttpMethod.GET, request, new ParameterizedTypeReference<List<Item>>(){});
//        
//        return response.getBody();
        
        List<Item> items = Lists.newArrayList(itemService.findAll());
        return ((items == null) || items.isEmpty()) ?  new ResponseEntity<List<Item>>(NO_CONTENT)
                : new ResponseEntity<List<Item>>(items, OK); 
    }
}
```


<br>

## Wrapping up



<br>

Thanks for your reading.

<br>

Refer:

