---
layout: post
title: Custom authentication with Spring Boot
bigimg: /img/image-header/home-office-1.jpg
tags: [Java, Spring]
---


- Custom Authentication
    
     ```UserDetails``` class and ```User``` class.

    ```java
    public interface UserDetailsService {
        UserDetails loadUserByUsername(String username) throws UsernameNotFoundException;        
    }

    public interface UserDetails extends Serializable {
        Collection<? extends GrandtedAuthority> getAuthorities();
        String getPassword();
        String getUsername();
        boolean isAccountNonExpired();
        boolean isAccountNonLocked();
        boolean isCredentialsNonExpired();
        boolean isEnabled();
    }

    @Entity
    public class User implements Serializable {
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        private Long id;
        private String firstName;
        private String lastName;
        private String email;
        private String password;
        ...
    }
    ```

    Based on ```UserDetails``` class and ```User``` class, we can custom authentication.

    ```java
    public class CustomUserDetials extends User implements UserDetails {
        public CustomUserDetials(User u){
            super(user);
        }

        public Collection getAuthorities() {
            return AuthorityUtils.createAuthorityList("ROLE_USER");
        }

        public String getUsername() {
            return getEmail();
        }

        public boolean isEnabled() {
            return true;
        }

        ...
    }

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(username);
        if (user == null) {
            throw new UsernameNotFoundException(...);
        }

        return new CustomUserDetails(user);
    }
    ```



Refer:

[https://insource.io/blog/articles/custom-authentication-with-spring-boot.html](https://insource.io/blog/articles/custom-authentication-with-spring-boot.html)

[http://herogtech.com/pass-extra-parameter-spring-security-login-page/](http://herogtech.com/pass-extra-parameter-spring-security-login-page/)

[https://leaks.wanari.com/2017/11/28/how-to-make-custom-usernamepasswordauthenticationfilter-with-spring-security/](https://leaks.wanari.com/2017/11/28/how-to-make-custom-usernamepasswordauthenticationfilter-with-spring-security/)

**Custom successful authentication**

[https://github.com/eugenp/tutorials/blob/master/spring-security-mvc-custom/src/main/java/org/baeldung/spring/SecSecurityConfig.java](https://github.com/eugenp/tutorials/blob/master/spring-security-mvc-custom/src/main/java/org/baeldung/spring/SecSecurityConfig.java)