---
layout: post
title: Understanding configuration in web.xml file
bigimg: /img/path.jpg
tags: [Java]
---



## Structure of web.xml file
The below is a content of web.xml file.

```xml
<web-app xmlns="http://java.sun.com/xml/ns/j2ee"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
version="2.4">

    <context-param>
        <param-name>sastruts.VIEW_PREFIX</param-name>
        <param-value>/WEB-INF/view</param-value>
    </context-param>
    
    <filter>
        <filter-name>encodingfilter</filter-name>
        <filter-class>org.seasar.extension.filter.EncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
    </filter>
    
    <filter>
        <filter-name>requestDumpFilter</filter-name>
        <filter-class>org.seasar.extension.filter.RequestDumpFilter</filter-class>
    </filter>

    <filter>
        <filter-name>hotdeployfilter</filter-name>
        <filter-class>org.seasar.framework.container.hotdeploy.HotdeployFilter</filter-class>
    </filter>
    
    <filter>
        <filter-name>s2filter</filter-name>
        <filter-class>org.seasar.framework.container.filter.S2ContainerFilter</filter-class>
    </filter>

    <filter>
        <filter-name>routingfilter</filter-name>
        <filter-class>org.seasar.struts.filter.RoutingFilter</filter-class>
        <init-param>
            <param-name>jspDirectAccess</param-name>
            <param-value>false</param-value>
        </init-param>
    </filter>
        
    <filter-mapping>
        <filter-name>encodingfilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <filter-mapping>
        <filter-name>hotdeployfilter</filter-name>
        <url-pattern>/*</url-pattern>
        <dispatcher>REQUEST</dispatcher>
        <dispatcher>FORWARD</dispatcher>
        <dispatcher>INCLUDE</dispatcher>
        <dispatcher>ERROR</dispatcher>
    </filter-mapping>
    
    <filter-mapping>
        <filter-name>s2filter</filter-name>
        <url-pattern>/*</url-pattern>
        <dispatcher>REQUEST</dispatcher>
        <dispatcher>FORWARD</dispatcher>
        <dispatcher>INCLUDE</dispatcher>
        <dispatcher>ERROR</dispatcher>
    </filter-mapping>
    
    <filter-mapping>
        <filter-name>routingfilter</filter-name>
        <url-pattern>/*</url-pattern>
        <dispatcher>REQUEST</dispatcher>
    </filter-mapping>
    
    <filter-mapping>
        <filter-name>requestDumpFilter</filter-name>
        <url-pattern>*.do</url-pattern>
        <dispatcher>REQUEST</dispatcher>
        <dispatcher>FORWARD</dispatcher>
        <dispatcher>INCLUDE</dispatcher>
        <dispatcher>ERROR</dispatcher>
    </filter-mapping>
    
    <servlet>
        <servlet-name>action</servlet-name>
        <servlet-class>org.apache.struts.action.ActionServlet</servlet-class>
        <init-param>
            <param-name>config</param-name>
            <param-value>/WEB-INF/struts-config.xml</param-value>
        </init-param>
        <init-param>
            <param-name>configFactory</param-name>
            <param-value>org.seasar.struts.config.S2ModuleConfigFactory</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
    
    <servlet>
        <servlet-name>s2container</servlet-name>
        <servlet-class>org.seasar.framework.container.servlet.S2ContainerServlet</servlet-class>
        <load-on-startup>2</load-on-startup>
    </servlet>
    
    <servlet-mapping>
        <servlet-name>action</servlet-name>
        <url-pattern>*.do</url-pattern>
    </servlet-mapping>

    <servlet-mapping>
        <servlet-name>s2container</servlet-name>
        <url-pattern>/s2container</url-pattern>
    </servlet-mapping>

	
    <session-config>
        <session-timeout>1</session-timeout>
    </session-config>
	

    <welcome-file-list>
        <welcome-file>index.html</welcome-file>
        <welcome-file>index.htm</welcome-file>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

     
    <error-page>
        <exception-type>java.lang.Throwable</exception-type>
        <location>/error/debug.jsp</location>
    </error-page>
   
    <error-page>
        <error-code>404</error-code>
        <location>/add.do</location>
    </error-page>
    -->

    <security-constraint> -->
        <web-resource-collection>
            <web-resource-name>
            Authentication
            </web-resource-name>
            <url-pattern>/login/*</url-pattern>
        </web-resource-collection>
        <auth-constraint>
            <role-name>tomcat</role-name>
            <role-name>role1</role-name>
        </auth-constraint>
    </security-constraint> -->
    
    <security-role>
        <role-name>tomcat</role-name>
    </security-role>

    <security-role>
        <role-name>role1</role-name>
    </security-role>
    
    <login-config>
        <auth-method>FORM</auth-method>
        <form-login-config>
            <form-login-page>/WEB-INF/view/login/login.html</form-login-page>
            <form-error-page>/WEB-INF/view/login/loginError.html</form-error-page>
        </form-login-config>
    </login-config>
    
    <jsp-config>
    	<jsp-property-group>
    		<url-pattern>*.jsp</url-pattern>
    		<el-ignored>false</el-ignored>
    		<page-encoding>UTF-8</page-encoding>
    		<scripting-invalid>false</scripting-invalid>
    		<include-prelude>/WEB-INF/view/common/common.jsp</include-prelude>
    	</jsp-property-group>
    </jsp-config>
</web-app>
```

<br>

## 



Refer:

[https://docs.oracle.com/cd/E13222_01/wls/docs81/webapp/web_xml.html#1019996](https://docs.oracle.com/cd/E13222_01/wls/docs81/webapp/web_xml.html#1019996)

