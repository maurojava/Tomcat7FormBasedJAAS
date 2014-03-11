<%-- 
    Document   : login
    Created on : 11-mar-2014, 16.36.15
    Author     : utente_javaee7
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <title>Insert title here</title>
    </head>
    <body>

        <form method=post action="j_security_check">
            <p>
                <span>Username:</span> <br /> <input type="text" name="j_username">
            </p>
            <p>
                <span>Password:</span> <br /> <input type="password"
                                                     name="j_password">
            </p>
            <p>
                <input type="submit" value="Login">
            </p>
        </form>


    </body>
</html>