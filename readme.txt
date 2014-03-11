Tomcat7FormBasedJAAS
====================

a sample of web application with Realm jdbc with datasource .

THis is a sample modified from the following website:


http://www.thejavageek.com/2013/07/07/configure-jdbcrealm-jaas-for-mysql-and-tomcat-7-with-form-based-authentication/

i have use derby and not mysql .
Next i have used a datasource with realm and the realm and datasource are declared into context.xml and not into server.xml 

n.b: i have used   <!-- Realm declared only for that web application and not into server.xml! -->
    <Realm className="org.apache.catalina.realm.DataSourceRealm"
         localDataSource="true"
         dataSourceName="jdbc/foo4"
        
         userTable="users" 
         userNameCol="username" 
         userCredCol="password"
         userRoleTable="users_roles" 
         roleNameCol="rolename"/>
-----------------------------------------------
and not  like from the original tutorial from http://www.thejavageek.com/2013/07/07/configure-jdbcrealm-jaas-for-mysql-and-tomcat-7-with-form-based-authentication/
............

<Realm  className="org.apache.catalina.realm.JDBCRealm"
 driverName="com.mysql.jdbc.Driver"
 connectionURL="jdbc:mysql://localhost:3306/tutorialsdb"
 connectionName="root"
 connectionPassword="root"
 userTable="users"
 userNameCol="username"
 userCredCol="password"
 userRoleTable="users_roles"
 roleNameCol="rolename" />

i have modified with a hint from the :

http://stackoverflow.com/questions/12333039/how-to-set-up-a-jdbcrealm-in-apache-tomcat-7

read from section DataSource Database Realm - org.apache.catalina.realm.DataSourceRealm 

http://tomcat.apache.org/tomcat-7.0-doc/config/realm.html


Remembre to reference the datasource from the web.xml 
--------------------------------------------------------------------------------------------------
the final configuration are: 

<Context antiJARLocking="true" path="/Tomcat7FormBasedJAAS">

    <!-- works! -->
    <Resource name="jdbc/foo4"
            type="javax.sql.DataSource"
            factory="org.apache.tomcat.jdbc.pool.DataSourceFactory"
            driverClassName="org.apache.derby.jdbc.ClientDriver"
            url="jdbc:derby://localhost:1527/nuovodb"
            username="myusername"
            password="mypassword"
            maxActive="8" 
            maxIdle="4" 
            maxWait="10000"
            auth="Container"
    />
    <!-- Realm declared only for that web application and not into server.xml! -->
    <Realm className="org.apache.catalina.realm.DataSourceRealm"
         localDataSource="true"
         dataSourceName="jdbc/foo4"
        
         userTable="users" 
         userNameCol="username" 
         userCredCol="password"
         userRoleTable="users_roles" 
         roleNameCol="rolename"/>
</Context>
---------------------------------------------------------------------------------------------------------------
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="3.0" xmlns="http://java.sun.com/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd">
    <display-name>Tomcat7FormBasedJAAS</display-name>
    <security-constraint>
        <web-resource-collection>
            <web-resource-name>secured</web-resource-name>
            <url-pattern>/protected/*</url-pattern>
        </web-resource-collection>
        <auth-constraint>
            <role-name>user</role-name>
        </auth-constraint>
    </security-constraint>
    <security-role>
        <role-name>user</role-name>
    </security-role>
    <login-config>
        <auth-method>FORM</auth-method>
        <form-login-config>
            <form-login-page>/login.jsp</form-login-page>
            <form-error-page>/login_failure.jsp</form-error-page>
        </form-login-config>
    </login-config>
    <resource-ref>
        <res-ref-name>jdbc/foo4</res-ref-name>
        <res-type>javax.sql.DataSource</res-type>
        <res-auth>Container</res-auth>
        <res-sharing-scope>Shareable</res-sharing-scope>
    </resource-ref>
</web-app>
-----------------------------------------------------------------------------------------------------------------
if you have  into tomcat/lib the derbyclient.jar, you not have to put it into web.inf/lib 


try it. 
Mauro
