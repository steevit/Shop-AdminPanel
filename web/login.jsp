<%-- 
    Document   : login
    Created on : 2017-05-11, 20:45:59
    Author     : steev
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <title>Logowanie</title>
    </head>
    <body>
        <div id="log">
        <form action="LoginServlet">
            
            <p>
                <label for="un">Nazwa użytkownika:</label>
                <input type="text" id="un" name="un">
            </p>
            <p>
                <label for="pw">Hasło:</label>
                <input type="password" id="pw" name="pw">
            </p>
            <div id="lower">
            <p>
                <input type="submit" value="Zaloguj">
            </p>
            </div>
            
        </form>
        </div>
    </body>
</html>
