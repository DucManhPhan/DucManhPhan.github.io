---
layout: post
title: Dealing with change preventers
bigimg: /img/image-header/yourself.jpeg
tags: [Java, Refactoring]
---




<br>

## Table of contents
- [Defining Change Preventers](#defining-change-preventers)
- [Changes to the Project](#changes-to-the-projects)
- [Divergent Change](#divergent-change)
- [Solution sprawl and Shotgun survey](#solution-sprawl-and-shotgun-survey)
- [Parallel Inheritance Hierarchies](#parallel-inheritance-hierarchies)


<br>

## Defining Change Preventers

Change Preventers means when code change in one place forces we to change code in many other places. Refactoring is difficult, adding a new feature is also difficult, and we don't want that for obvious reasons. So, this is the list of change preventers that we need to know:
- Divergent change
- Solution sprawl and shotgun survey
- parallel inheritance hierarchies


<br>

## Changes to the Project

For example:

```java
public class SimpleCurrencyConverter {
    private String currencyTo;

    public SimpleCurrencyConverter() {}

    public SimpleCurrencyConverter(String currencyTo) {
        this.currencyTo = currencyTo;
    }

    public double convert(double price) {
        if (currencyTo.equalsIgnoreCase("EUR")) {
            return price * 0.9;
        } else if (currencyTo.equalsIgnoreCase("CAD")) {
            return price * 1.35;
        } else {
            throw new IllegalArgumentException("Unrecognized currency: " + currencyTo);
        }
    }
}
```

We can realize that currency rates change over time and having hard-coded values in our conversion method isn't a very good idea. So our colleagues made some changes and we now pull up to date exchange rates from a web service. So, we have:

```java
public class SimpleCurrencyConverter {

    public double convert(double price) {
        String rates = getCurrencyRate("USD");
        if (currencyTo.equalsIgnoreCase("EUR")) {
            return price * getRate(rates, "EUR");
        } else if (currencyTo.equalsIgnoreCase("CAD")) {
            return price * getRate(rates, "CAD");
        } else {
            throw new IllegalArgumentException("Unrecognized currency: " + currencyTo);
        }
    }

    private double getRate(String rates, String currencyTo) {
        return Double.valueOf(rates.substring(rates.lastIndexOf(currencyTo)).substring(5, 9));
    }

    public String getCurrencyRate(String baseCurrency) {
        HttpClient httpClient = new Builder().build();
        HttpRequest request = HttpRequest.newBuilder()
                                         .uri(URI.create("https://api.exchangeratesapi.io/latest?base=" + baseCurrency))
                                         .build();

        HttpResponse<String> response = null;
        try {
            response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        } catch(IOException | InterruptedException e) {
            e.printStackTrace();
        }

        return response.body();
    }
}
```




<br>

## Divergent Change






<br>

## Solution sprawl and Shotgun survey






<br>

## Parallel Inheritance Hierarchies






<br>

## Wrapping up




<br>

Refer:

[https://aboullaite.me/cdi-20-java-se/](https://aboullaite.me/cdi-20-java-se/)

[https://docs.jboss.org/weld/reference/latest/en-US/html/environments.html#weld-se](https://docs.jboss.org/weld/reference/latest/en-US/html/environments.html#weld-se)

[http://www.mastertheboss.com/jboss-frameworks/cdi/building-a-cdi-2-standalone-java-application](http://www.mastertheboss.com/jboss-frameworks/cdi/building-a-cdi-2-standalone-java-application)