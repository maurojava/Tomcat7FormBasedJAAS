<%-- 
    Document   : protected
    Created on : 11-mar-2014, 16.34.03
    Author     : utente_javaee7
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>Insert title here</title>
</head>
<body>
 
Hello <%= request.getUserPrincipal().getName().toString() %>
You are able to view this page because you are authenticated user.
 
</body>
</html>