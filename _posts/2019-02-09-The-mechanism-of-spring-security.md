---
layout: post
title: The mechanism of Spring security
bigimg: /img/image-header/home-office-1.jpg
tags: [java]
---



## Table of Contents




<br>

## Introduction to Spring security





<br>

## Mechanism of Spring security




<br>

## Some important note in Spring security
- The difference between ```loginPage()``` and ```loginProcessingURL()```

    The method ```loginPage("/login")``` instructs Spring security:
    - when authentication is required, redirect the browser to ```/login```.
    - we are in charge of rendering the login page when ```/login``` is requested
    - when authentication attempt fails, redirect the browser to ```/login?error``` (since we have not specified otherwise)
    - we are in charge of rendering a failure page when ```/login?error``` is requested
    - when we successfully logout, redirect the browser to ```/login?logout``` (since we have not specified otherwise)
    - we are in charge of rendering a logout confirmation page when /login?logout is requested

    With method ```loginProcessingURL("/login/process")```:
    - this url is used to submit the username and password to ```defaultSuccessUrl()``` - the landing page after a successful login.
    - tells Spring security to process the submitted credentials when sent the specified path and, by default, redirect user back to the page user came from. It will not pass the request to Spring MVC and controller.

- Explain about ```customlogin.html```

    ```html
    <html xmlns:th="http://www.thymeleaf.org">
        <head th:include="layout :: head(title=~{::title},links=~{})">
            <title>Please Login</title>
        </head>
        <body th:include="layout :: body" th:with="content=~{::content}">
            <div th:fragment="content">
                <form name="f" th:action="@{/login}" method="post">     <!--(1)-->          
                    <fieldset>
                        <legend>Please Login</legend>
                        <div th:if="${param.error}" class="alert alert-error">    <!--(2)-->
                            Invalid username and password.
                        </div>
                        <div th:if="${param.logout}" class="alert alert-success">   <!--(3)-->
                            You have been logged out.
                        </div>
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username"/>        <!--(4)-->
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password"/>    <!--(5)-->
                        <div class="form-actions">
                            <button type="submit" class="btn">Log in</button>
                        </div>
                    </fieldset>
                </form>
            </div>
        </body>
    </html>
    ```

    - (1) - The URL we submit our username and password to is the same URL as our login form (i.e. /login), but a POST instead of a GET.
    - (2) - When authentication fails, the browser is redirected to /login?error so we can display an error message by detecting if the parameter error is non-null.
    - (3) - When we are successfully logged out, the browser is redirected to /login?logout so we can display an logout success message by detecting if the parameter logout is non-null.
    - (4) - The username should be present on the HTTP parameter username
    - (5) - The password should be present on the HTTP parameter password

- The meaning of some methods in ```configure()``` method of ```WebSecurityConfigurerAdapter``` class

    - ```loginPage("/login")```: The url which points to a ```@RequestMapping which returns the login form.
    - ```loginProcessingUrl("/login")```: The url which triggers the ```UsernamePasswordAuthenticationFilter```. It is equivalent to build a POST processing controller method.
    - ```defaultSuccessUrl("/user")```: The default page where the user will be redirected after providing a valid user credentials.
    - ```failureUrl("/login?error=true")```: The url where user will be redirected in case of trying to login with invalid credentials.

- Why to use POST method with URL is "/login" as parameter of ```loginPage("/login")``` in login.html, it can not be called.

    ```java
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView doLogin() {
        System.out.println("***LOGIN_POST***");
        return new ModelAndView("users/home");
    }
    ```

    So, the above code won't be reached.

    When mapping a post to ```/login``` uri, the ```UsernamePasswordAuthenticationFilter``` will perform it's ```doFilter()``` method to catch the user provided credentials, build a ```UsernamePasswordAuthenticationToken``` and delegate it to the ```AuthenticationManager```, where this ```Authentication``` will be executed in the matching ```AuthenticationProvider```.

- ```UsernamePasswordAuthenticationFilter``` class

    It is extended from ```AbstractAuthenticationProcessingFilter``` class and some other interfaces.

    When the url in ```loginProcessingURL("/login")``` is implemented, this class will process an authentication form submission. And login form must present two parameters to this filter: a username and password. 

    So, this class's responsibility is to get username and password from login form.

    We can refer this [link](https://docs.spring.io/spring-security/site/docs/4.2.11.BUILD-SNAPSHOT/apidocs/org/springframework/security/web/authentication/UsernamePasswordAuthenticationFilter.html) to read about some methods of this class.


- ```UsernamePasswordAuthenticationToken``` class

    It is extended from the abstract class ```AbstractAuthenticationToken``` and implemented interfaces such as ```Serializable```, ```Principal```, ```Authentication```, ```CredentialsContainer```. 

    **An ```Authentication``` implementation that is designed for simple presentation of a username and password.**

    In the ```UsernamePasswordAuthenticationToken``` class, we can see that it has two constructor:

    ```java
    UsernamePasswordAuthenticationToken(java.lang.Object principal, java.lang.Object credentials);
    UsernamePasswordAuthenticationToken(java.lang.Object principal, java.lang.Object credentials, java.util.Collection<? extends GrantedAuthority> authorities);
    ```
    In the above two constructors, we have to pass ```principal``` and ```credentials``` objects, or authorities of user.

    And this class also support some method to make an action with ```principal``` and ```credentials```.

    ```java
    void eraseCredentials();
    Object getCredentials();
    Object getPrincipal();
    void setAuthenticated(boolean isAuthenticated);
    ```

    So, we have two questions: 
    - *What is principal and credential?* 
    - *When/How are two object - principal and credentials created?*
    
    To end up this class, we have conclusion - ```UsernamePasswordAuthenticationToken``` class will contain all information about ```principal``` (the principal can be username), ```credentials``` (the credentials are a password) and ```authorities```.

- ```AuthenticationManager``` class

    It is an interface class, has derived class that is ```ProviderManager``` class.

    This class has only one method:

    ```java
    Authentication authenticate(Authentication authentication) throws AuthenticationException;
    ```

    ```authenticate()``` method will attempts to authenticate the passed ```Authentication``` object, returning a fully populated ```Authentication``` object (including granted authorities) if successful.

    
- ```AuthenticationProvider``` class

    It is also interface class and some classes implementing this interface are ```AbstractJaasAuthenticationProvider, AbstractLdapAuthenticationProvider, AbstractUserDetailsAuthenticationProvider, ActiveDirectoryLdapAuthenticationProvider, AnonymousAuthenticationProvider, AuthenticationManagerBeanDefinitionParser.NullAuthenticationProvider, CasAuthenticationProvider, DaoAuthenticationProvider, DefaultJaasAuthenticationProvider, JaasAuthenticationProvider, LdapAuthenticationProvider, OpenIDAuthenticationProvider, PreAuthenticatedAuthenticationProvider, RememberMeAuthenticationProvider, RemoteAuthenticationProvider, RunAsImplAuthenticationProvider, TestingAuthenticationProvider```.

    It also provides a method for performing authentication with the same contracts as ```AuthenticationManager.authenticate(Authentication)```.

    ```java
    Authentication authenticate(Authentication authentication) throws AuthenticationException;
    ```

- ```ProviderManager``` class

    It is extended from Object class and implemented from some interfaces such as ```AuthenticationManager```, ...

    We can see some constructors to know about it.

    ```java
    ProviderManager(List<AuthenticationProvider> providers);
    ProviderManager(List<AuthenticationProvider> providers, AuthenticationManager parent);
    ```

    So, ```ProviderManager``` will manage the list of ```AuthenticationProvider```. 

    And it also provides an ```authenticate()``` method that do the same meaning with an ```authenticate()``` method of ```AuthenticationManager``` and ```AuthenticationProvider``` classes.

    ```java
    public Authentication authenticate(Authentication authentication) throws AuthenticationException;
    ```

    This method will attempt to authenticate the passed ```Authentication``` object.

    The list of ```AuthenticationProvider```s will be successively tried until an ```AuthenticationProvider``` indicates it is capable of authenticating the type of ```Authentication``` object passed. ```Authentication``` will then be attempted with that ```AuthenticationProvider```.

    If more than one ```AuthenticationProvider``` supports the passed ```Authentication``` object, the first one able to successfully authenticate the ```Authentication``` object determines the result, overriding any possible ```AuthenticationException``` thrown by earlier supporting ```AuthenticationProvider```s. On successful authentication, no subsequent ```AuthenticationProvider```s will be tried. If authentication was not successful by any supporting ```AuthenticationProvider``` the last thrown ```AuthenticationException``` will be rethrown.

- 

<br>

## Recap




<br>

Refer:

[https://www.dineshonjava.com/spring-security-take-baby-step-to-secure/](https://www.dineshonjava.com/spring-security-take-baby-step-to-secure/)

[https://en.wikipedia.org/wiki/Spring_Security](https://en.wikipedia.org/wiki/Spring_Security)

[https://docs.spring.io/spring-security/site/docs/4.2.2.RELEASE/guides/html5/hellomvc-javaconfig.html#security-config-java](https://docs.spring.io/spring-security/site/docs/4.2.2.RELEASE/guides/html5/hellomvc-javaconfig.html#security-config-java)

[https://stackoverflow.com/questions/53140629/spring-security-loginpage-vs-loginprocessingurl](https://stackoverflow.com/questions/53140629/spring-security-loginpage-vs-loginprocessingurl)


**Creating the custom login page**

[https://docs.spring.io/spring-security/site/docs/current/guides/html5/form-javaconfig.html](https://docs.spring.io/spring-security/site/docs/current/guides/html5/form-javaconfig.html)

[https://docs.spring.io/spring-security/site/migrate/current/3-to-4/html5/migrate-3-to-4-xml.html#m3to4-xmlnamespace-form-login](https://docs.spring.io/spring-security/site/migrate/current/3-to-4/html5/migrate-3-to-4-xml.html#m3to4-xmlnamespace-form-login)

[https://www.baeldung.com/spring-security-login](https://www.baeldung.com/spring-security-login)

**Spring security overview**

[https://docs.spring.io/spring-security/site/docs/3.2.x/reference/htmlsingle/html5/#technical-overview](https://docs.spring.io/spring-security/site/docs/3.2.x/reference/htmlsingle/html5/#technical-overview)

**Send information username and password from form-submit to Server**

[https://stackoverflow.com/questions/7562675/proper-way-to-send-username-and-password-from-client-to-server](https://stackoverflow.com/questions/7562675/proper-way-to-send-username-and-password-from-client-to-server)

[https://docs.spring.io/spring-security/site/docs/current/reference/html/overall-architecture.html#core-services-authentication-manager](https://docs.spring.io/spring-security/site/docs/current/reference/html/overall-architecture.html#core-services-authentication-manager)

**SecurityContext and SecurityContextHolder**
[https://www.javacodegeeks.com/2018/02/securitycontext-securitycontextholder-spring-security.html](https://www.javacodegeeks.com/2018/02/securitycontext-securitycontextholder-spring-security.html)