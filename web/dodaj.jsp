<%-- 
    Document   : dodaj
    Created on : 2017-05-12, 20:10:15
    Author     : steev
--%>

<% 
    // WYMUSZENIE ZALOGOWANIA   
    if(session.getAttribute("currentSessionUser")==null)
    {
        response.sendRedirect("login.jsp");
    }
    
    Admin currentUser = (Admin)(session.getAttribute("currentSessionUser"));
    String username = null;
                
    try{username = currentUser.getUsername();}
    catch(Exception e){System.out.println(e);}
%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <title>Dodawanie produktu</title>
    </head>
    <body>
        
        
        <p>Zalogowany jako <%=username%></p>
        <div>
            <a href="LogoutServlet" style="text-decoration: none;">
                    <div id="wyloguj" style="margin-left: 10px; float: left;">
                        Wyloguj się
                    </div>
            </a>
            <a href="produkty.jsp" style="text-decoration: none;">
                <div id="wyloguj" style="float: left; margin-left: 10px;">
                        Wróć
                </div>
            </a>    
            <div style="clear: both;"></div>
        </div>
        
       <div id="log">
        <form action="AddProduct">
            
            <p>
                <label for="name">Nazwa</label>
                <input type="text" id="name" name="name">
            </p>
            <p>
                <label for="cat">Kategoria</label>
                <input type="text" id="cat" name="cat">
            </p>
            <p>
                <label for="price">Cena</label>
                <input type="text" id="price" name="price">
            </p>
            <p>
                <label for="quan">Ilość</label>
                <input type="number" id="quan" name="quan">
            </p>
            <div id="lower">
            <p>
                <input type="submit" value="Zapisz">
            </p>
            </div>
            
        </form>
        </div>
    </body>
</html>
