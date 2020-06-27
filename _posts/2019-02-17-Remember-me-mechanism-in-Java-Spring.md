---
layout: post
title: Remember-me mechanism in Java Spring
bigimg: /img/path.jpg
tags: [Spring]
---

Before discussing about Remember-Me mechanism in Spring, we should read about [The mechanism of Spring Security](https://ducmanhphan.github.io/2019-02-09-The-mechanism-of-spring-security) to understand the way that Spring Security does. 

Then, we will find out about Remember-Me mechanism in Spring Security.

<br>

## Table of contents
- [Problem](#problem)
- [Solution](#solution)
- [Remember-me mechanism](#remember-me-mechanism)
- [Source code for remember-me mechanism](source-code-for-remember-me-mechanism)
- [Wrapping-up](#wrapping-up)

<br>

## Problem
When a user accesses a website and login by their account. After a long time, they do not logout this account, and turn off their browser. At the some time, they want to access this website again. But they have to login, it causes annoying for user.

<br>

## Solution
So, to solve this problem, Remember-Me is a convenient mechanism that remembers the authentication of the user next time,when they use the application, so that they do not have to login again.

<br>

## Remember-me mechanism 
To understand Remember-Me mechanism deeper, we should read about this article: [The mechanism of Spring Security](https://ducmanhphan.github.com/2019-02-09-The-mechanism-of-spring-security).

Spring Security provides two implementation for Remember-Me:
- Simple Hash-Based Token Approach: use hashing to preserve the security of cookie-based tokens.
- Persistent Token Approach: use a database or other persistent storage mechanism to store the generated tokens.

Remember-me or persistent-login authentication refers to web sites being able to remember the identity of a principal between sessions. 

This is typically accomplished by sending a cookie to the browser, with the cookie being detected during future sessions and causing automated login to take place. 

Spring Security provides the necessary hooks for these operations to take place, and has two concrete remember-me implementations. 

One uses hashing to preserve the security of cookie-based tokens and the other uses a database or other persistent storage mechanism to store the generated tokens.

Note that both implemementations require a ```UserDetailsService```. If we are using an ```AuthenticationProvider``` which doesn't use a ```UserDetailsService``` (for example, the LDAP provider) then it won't work unless you also have a ```UserDetailsService``` bean in our application context. 

Remember-Me authentication is not used with basic authentication, given it is often not used with ```HttpSession```s. Remember-Me is used with ```UsernamePasswordAuthenticationFilter```, and is implemented via hooks in the ```AbstractAuthenticationProcessingFilter``` superclass. The hooks will invoke a concrete ```RememberMeServices``` at the appropriate times.

The interface looks like this:

```java
Authentication autoLogin(HttpServletRequest request, HttpServletResponse response);

void loginFail(HttpServletRequest request, HttpServletResponse response);

void loginSuccess(HttpServletRequest request, HttpServletResponse response, Authentication successfulAuthentication);
```

```AbstractAuthenticationProcessingFilter``` only calls the ```loginFail()``` and ```loginSuccess()``` methods. 

The ```autoLogin()``` method is called by ```RememberMeAuthenticationFilter``` whenever the ```SecurityContextHolder``` does not contain an ```Authentication```.

This interface, therefore, provides the underlying remember-me implementation with sufficient notification of authentication-related events, and delegates to the implementation whenever a candidate web request might contain a cookie and wish to be remembered. This design allows any number of remember-me implementation strategies.

<br>

There are two implementations for ```RememberMeServices```:
- TokenBaseRememberMeServices
- PersistentTokenBasedRememberMeServices

Next, we will discuss about ```TokenBaseRememberMeServices```.

This implementation supports the simpler approach - ```Simple Hash-Based Token Approach```.

```TokenBasedRememberMeServices``` generates a ```RememberMeAuthenticationToken```, which is processed by ```RememberMeAuthenticationProvider```. 

A key is shared between this authentication provider and the ```TokenBasedRememberMeServices```.

In addition, ```TokenBasedRememberMeServices``` requires a ```UserDetailsService``` from which it can retrieve the ```username``` and ```password``` for signature comparison purposes, and generate the ```RememberMeAuthenticationToken``` to contain the correct ```GrantedAuthority[]```s. 

Some sort of logout command should be provided by the application that invalidates the cookie if the user requests this. 

```TokenBasedRememberMeServices``` also implements Spring Security's ```LogoutHandler``` interface so can be used with ```LogoutFilter``` to have the cookie cleared automatically. 

Then, we will discuss about ```PersistentTokenBasedRememberMeServices```.

This class can be used in the same way as TokenBasedRememberMeServices, but it additionally needs to be configured with a PersistentTokenRepository to store the tokens. 

The database should contain a persistent_logins table, created using the following SQL (or equivalent): 

```sql
create table persistent_logins (
    username varchar(64) not null, 
    series varchar(64) primary key, 
    token varchar(64) not null, 
    last_used timestamp not null);
```

<br>

## Source code for remember-me mechanism
- First step - configure information in ```configure()``` method in ```WebSecurityConfig``` class

    There are two common ways for the Spring to save this information: 
    - Memory
    - Database

    But we will save information in database.

    ```java
    @Configuration
    @EnableWebSecurity
    public class WebSecurityConfig extends WebSecurityConfigurerAdapter implements WebMvcConfigurer {

        @Autowired
        private UserDetailsService userDetailService;
        
        @Autowired
        private DataSource dataSource;
        
        @Bean
        public PasswordEncoder passwordEncoder() {
            return new BCryptPasswordEncoder();
        }

        @Autowired
        public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
            auth.userDetailsService(userDetailService).passwordEncoder(passwordEncoder());                
        }
        
        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.authorizeRequests()
                    .antMatchers("/api/**").permitAll()
                    .antMatchers("/").access("hasAnyRole('USER', 'ADMIN')")
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
                .rememberMe()
                    .key("rem-me-key")
                    .rememberMeCookieName("remember-me-cookie")
                    .rememberMeParameter("remember-me")  // remember-me field name in form.
                    .tokenRepository(this.persistentTokenRepository())
                    .tokenValiditySeconds(1*24*60*60)
                    .and()
                .logout()
                    .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                    //.logoutUrl("/logout")              
                    .logoutSuccessUrl("/login")
                    .invalidateHttpSession(true)
                    .deleteCookies("JSESSIONID")
                    .and()
                .exceptionHandling()
                    .accessDeniedPage("/403");           
        }        
        
        // Token stored in Table - persistent_logins
        @Bean
        public PersistentTokenRepository persistentTokenRepository() {
            JdbcTokenRepositoryImpl db = new JdbcTokenRepositoryImpl();
            db.setDataSource(dataSource);
            
            return db;
        }        

        // Token stored in Memory (Of Web Server).
        @Bean
        public PersistentTokenRepository persistentTokenRepository() {
            InMemoryTokenRepositoryImpl memory = new InMemoryTokenRepositoryImpl();
            return memory;
        }
    }
    ```

    The meaning of some methods of ```remember-me``` configuration:
    - rememberMe(): It returns ```RememberMeConfigurer``` class using which remember-me configuration is done.
    - key(): It specifies the key to identify tokens. The key is important - it is a private value secret for the entire application and it will be used when generating the contents of the token.
    - rememberMeParameter(): It specifies the name attribute which we use to create HTML checkbox. Then, we can custom path based on this option.
    - rememberMeCookieName(): It specifies the cookie name stored in the browser.
    - tokenValiditySeconds(): It specifies the time in seconds after which is token is expired.
    - tokenRepository(): It specifies ```PersistentTokenRepository``` which is used to query ```persistent_logins``` table.

    The ```Remember-Me``` cookie contains the following data:
    - username: to identify the logged in principal.
    - expirationTime: to expire the cookie; default is 2 weeks.
    - MD5 hash: of the previous 2 values - ```username``` and ```expirationTime```, plus the ```password``` and the predefined ```key```.

    First thing to notice here is that both the username and the password are part of the cookie – this means that, if either is changed, the cookie is no longer valid. Also, the username can be read from the cookie.

    Additionally, it is important to understand that this mechanism is potentially vulnerable if the remember me cookie is captured. The cookie will be valid and usable until it expires or the credentials are changed.

- Second step - Because we use persistent approach, we need to create a table with name ```persistent_logins```.

    ```sql
    create table `persistent_logins` (
	`username` varchar(64) COLLATE utf8_unicode_ci not null, 
    `series` varchar(64) COLLATE utf8_unicode_ci not null, 
    `token` varchar(64) COLLATE utf8_unicode_ci not null, 
    `last_used` timestamp not null DEFAULT CURRENT_TIMESTAMP, 
    primary key (`series`)
    )ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
    ```

- Third step - Create checkbox ```Remember-me``` in UI.

    ```html
    <label>
        <input name="remember-me" type="checkbox" value="Remember Me"> Remember me
    </label>
    ```

- Final step - run application    

<br>

## Wrapping up
- Remember-Me mechanism also has the other services as same as authentication functionality.

- There are two implementations for Remember-Me mechanism:
    - TokenBaseRememberMeServices
    - PersistentTokenBasedRememberMeServices

- In ```PersistentTokenBasedRememberMeServices``` has two standard implementations:
    - InMemoryTokenRepositoryImpl which is intended for testing only.
    - JdbcTokenRepositoryImpl which stores the tokens in a database. 

<br>

Thanks for your reading.

<br>

Refer:

[https://docs.spring.io/spring-security/site/docs/3.0.x/reference/remember-me.html](https://docs.spring.io/spring-security/site/docs/3.0.x/reference/remember-me.html)

[https://grokonez.com/spring-framework/spring-security/configure-persistent-token-remember-me-authentication-persistent-token-approach-spring-boot](https://grokonez.com/spring-framework/spring-security/configure-persistent-token-remember-me-authentication-persistent-token-approach-spring-boot)

[https://www.concretepage.com/spring/spring-security/remember-me-in-spring-security-example](https://www.concretepage.com/spring/spring-security/remember-me-in-spring-security-example)

[https://www.jeejava.com/spring-security-remember-me-persistent-token-approach/](https://www.jeejava.com/spring-security-remember-me-persistent-token-approach/)