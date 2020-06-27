---
layout: post
title: Logout in Spring Boot
bigimg: /img/path.jpg
tags: [Spring]
---

In web development, we usually cope with some problems about logging out a website. After logging out, we have to set the invalidation state of session, and delete our cookies ...

But in Spring Boot, we do not have a specific solution for this problem. 

So, in this article, we will discuss about logout problem in spring boot. 

## Table of contents
- [Solution](#solution)
- [The meanings of source code](#the-meaning-of-source-code)
- [Wrapping up](#wrapping-up)

<br>

## Solution

- First solution, define in ```configure()``` method directly.

    We can use the following code segment:

    ```java
    @Configuration
    @EnableWebSecurity
    public class WebSecurityConfig extends WebSecurityConfigurerAdapter implements WebMvcConfigurer {

        ...

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.authorizeRequests()
                    .antMatchers("/").access("hasRole('USER')")
                    .antMatchers("/admin/**").access("hasRole('ADMIN')")
                    .and()
                .formLogin()
                    .loginProcessingUrl("/login")       // link to submit username-password
                    .loginPage("/login")
                    .usernameParameter("username")      // username field in login form
                    .passwordParameter("password")      // password field in login form
                    .defaultSuccessUrl("/")             
                    .failureUrl("/login?error")
                    .and()
                .logout()
                    .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))            
                    .logoutSuccessUrl("/login")
                    .invalidateHttpSession(true)        // set invalidation state when logout
                    .deleteCookies("JSESSIONID")        
                    .and()
                .exceptionHandling()
                    .accessDeniedPage("/403");
        }

        ...
    }
    ```

    So, we will explain how Spring Security logout based on ```AntPathRequestMatcher``` class.

    While going to the URL ```/logout```, an object of ```AntPathRequestMatcher``` class will compare its link with link that is routed. If matched, Spring security will log out and implement sequence actions such as ```invalidateHttpSession()```, ```deleteCookies()```, and ```logoutSuccessUrl()```.

- Second solution

    We will not set up for logout information in ```configure()``` method of WebSecurityConfig class.

    Then, we will process ```/logout``` in handling method of ```Controller```.

    ```java
    @Configuration
    @EnableWebSecurity
    public class WebSecurityConfig extends WebSecurityConfigurerAdapter implements WebMvcConfigurer {
        ...

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.authorizeRequests()
                    .antMatchers("/api/**").permitAll()
                    .antMatchers("/").access("hasRole('USER')")
                    .antMatchers("/admin/**").access("hasRole('ADMIN')")
                    .and()
                .formLogin()
                    .loginProcessingUrl("/login") // link to submit username-password
                    .loginPage("/login")
                    .usernameParameter("username")
                    .passwordParameter("password")
                    .defaultSuccessUrl("/")
                    .failureUrl("/login?error")
                    .and()
                .exceptionHandling()
                    .accessDeniedPage("/403");
        }

        ...        
    }
    ```

    ```java
    @Controller
    public class LoginController {
        ...

        @GetMapping("/logout")
        public String fetchSignoutSite(HttpServletRequest request, HttpServletResponse response) {        
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null) {
                new SecurityContextLogoutHandler().logout(request, response, auth);
            }
            
            return "redirect:/login?logout";
        }

        ...
    }
    ```

    With this way, we will get information about user's authentication by using ```SecurityContextHolder.getContext().getAuthentication()```.

    If user was, then, we called ```SecurityContextLogoutHandler().logout(request, response, auth)``` to logout user properly.

    The ```logout``` call performs following:
    - Invalidates HTTP session, then unbinds any objects bound to it. 
    - Removes the Authentication from the SecurityContext to prevent issues with concurrent requests. 
    - Explicitly clears the context value from the current thread.

- Third solution

    In this solution, we will still use ```configure()``` method, but there are some changes in ```fetchSignoutSite()``` method in ```Controller``` class.

    ```java
    @RequestMapping(value = {"/logout"}, method = RequestMethod.GET)
    public String fetchSignoutSite(HttpServletRequest request, HttpServletResponse response){
        
        HttpSession session = request.getSession(false);
        SecurityContextHolder.clearContext();

        session = request.getSession(false);
        if(session != null) {
            session.invalidate();
        }

        for(Cookie cookie : request.getCookies()) {
            cookie.setMaxAge(0);
        }

        return "redirect:/login?logout";
    }
    ```

    If we are using this ```fetchSignoutSite()``` method, we don't need to include the first solution in Spring security config. By using this solution, we can add extra action to do before and after logout done. But, to use this solution, just call the ```/logout``` url and user will be logout manually. This solution will invalidate session, clear spring security context and cookies. 

    If we are using ```RequestMethod.POST```, we need to include the ```csrf``` key as a post. The alternative way is to create a form with hidden input ```csrf``` key. This is some example of auto generated logout link with JQuery.

    ```javascript
    $("#Logout").click(function(){
        $form=$("<form>").attr({"action":"${pageContext.request.contextPath}"+"/logout","method":"post"})
        .append($("<input>").attr({"type":"hidden","name":"${_csrf.parameterName}","value":"${_csrf.token}"}))
        $("#Logout").append($form);
        $form.submit();
    });
    ```

    We just need to create hyperlink ```\<a\> id="Logout">Logout\</a\> to use it.

    If we are using ```RequestMethod.GET```, just include a ```csrf``` key as a parameter in our link like this:

    ```html
    <a href="${pageContext.request.contextPath}/logout?${_csrf.parameterName}=${_csrf.token}">Logout</a>
    ```

Note: We have to go to a page with link ```/logout```. 

We can do that by defining anchor with the ```href = "@{/logout}"``` in thymeleaf:

```html
<a th:href="@{/logout}">Logout</a>
```


<br>

## The meanings of source code
- Using ```AntPathRequestMatcher``` class

    ```java
    public final class AntPathRequestMatcher
    extends java.lang.Object
    implements RequestMatcher, RequestVariablesExtractor
    ```

    Matcher will compares a pre-defined ant-style pattern against the URL (servletPath + pathInfo) of an ```HttpServletRequest```. The query string of the URL is ignored and matching is case-insensitive or case-sensitive depending on the arguments passed into the constructor. 

     Using a pattern value of /** or ** is treated as a universal match, which will match any request. Patterns which end with /** (and have no other wildcards) are optimized by using a substring match — a pattern of /aaa/** will match /aaa, /aaa/ and any sub-directories, such as /aaa/bbb/ccc.

    For all other cases, Spring's ```AntPathMatcher``` is used to perform the match.

    Note: Use ```org.springframework.security.web.util.matcher.AntPathRequestMatcher```, and not the deprecated ```org.springframework.security.web.util.AntPathRequestMatcher``` class.    

- Use ```SecurityHolderContext```, ```SecurityContext``` class

    We will have two declarations of ```SecurityHolderContext```, ```SecurityContext``` class.

    ```java
    public interface SecurityContext {

        // --> Obtains the currently authenticated principal, or an authentication request token.
        Authentication getAuthentication();  

        // --> changes the currently authenticated principal, or removes the authentication information.
        void setAuthentication(Authentication authentication);  
    }
    ```

    ```java
    public class SecurityContextHolder extends java.lang.Object {

        // Obtain the current SecurityContext.
        // returned value is never null
        public static SecurityContext getContext();

        // Associates a new SecurityContext with the current thread of execution.
        // context may be not null
        public static void setContext(SecurityContext context);
    }    
    ```

    The ```interface SecurityContext``` will define the minimum security information associated with the current thread of execution.

    And the security context is stored in a ```SecurityContextHolder``` class.

    ```SecurityContext``` is centering interface of Spring Security, saves all information that is relevant to the security in application. When we start Spring Security, ```SecurityContext``` will be initialize.

    We can not access directly into ```SecurityContext```, but we can use ```SecurityContextHolder``` class. This class will contain the current ```SecurityContext``` of application, which includes ```principal``` that is interacting with application.

    Spring Security will use ```Authentication``` object to represent their information. The following code will help us get ```username``` and ```password``` that is typed from a user.

    ```java
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

    if (principal instanceof UserDetails) {
        String username = ((UserDetails) principal).getUsername();
    } else {
        String username = principal.toString();
    }
    ```

<br>

## Wrapping up
- In reality, we have two ways to logout in Spring security. It includes to set information in ```configure()``` method and use ```SecurityContextHolder``` class.
- We can not access directly into ```SecurityContext``` object, we have to get it to depend on ```SecurityContextHolder```.

<br>

Thanks for your reading.

Refer:

[https://www.messycola.com/new-blog/2017/5/24/part-vi-integrating-spring-security-with-spring-boot](https://www.messycola.com/new-blog/2017/5/24/part-vi-integrating-spring-security-with-spring-boot)

[https://www.concretepage.com/spring-boot/spring-boot-mvc-security-custom-login-and-logout-thymeleaf-csrf-mysql-database-jpa-hibernate-example](https://www.concretepage.com/spring-boot/spring-boot-mvc-security-custom-login-and-logout-thymeleaf-csrf-mysql-database-jpa-hibernate-example)

[https://docs.spring.io/spring-security/site/docs/3.2.4.RELEASE/reference/htmlsingle/#what-is-acegi-security](https://docs.spring.io/spring-security/site/docs/3.2.4.RELEASE/reference/htmlsingle/#what-is-acegi-security)

[https://stackoverflow.com/questions/23661492/implement-logout-functionality-in-spring-boot](https://stackoverflow.com/questions/23661492/implement-logout-functionality-in-spring-boot)

[https://www.baeldung.com/spring-security-logout](https://www.baeldung.com/spring-security-logout)

[https://developer.okta.com/blog/2017/12/04/basic-crud-angular-and-spring-boot](https://developer.okta.com/blog/2017/12/04/basic-crud-angular-and-spring-boot)

[http://websystique.com/spring-security/spring-security-4-logout-example/](http://websystique.com/spring-security/spring-security-4-logout-example/)

[https://stackoverflow.com/questions/36557294/spring-security-logout-does-not-work-does-not-clear-security-context-and-authe](https://stackoverflow.com/questions/36557294/spring-security-logout-does-not-work-does-not-clear-security-context-and-authe)