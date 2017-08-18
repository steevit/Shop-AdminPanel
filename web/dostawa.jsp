<%-- 
    Document   : dostawa
    Created on : 2017-05-12, 12:41:43
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

<%@page import="model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <title>Dostawa</title>
    </head>
    <body>
        
        <div id="header">
                <h1>Realizacja dostawy</h1>
        </div>
        
        <p>Zalogowany jako <%=username%></p>
        <div>
            <a href="LogoutServlet" style="text-decoration: none;">
                    <div id="wyloguj" style="margin-left: 10px; float: left;">
                        Wyloguj się
                    </div>
            </a>
            <a href="panel.jsp" style="text-decoration: none;">
                <div id="wyloguj" style="float: left; margin-left: 10px;">
                        Wróć
                </div>
            </a>    
            <div style="clear: both;"></div>
        </div>
        
        <p style="text-align: center; color: red; font-weight: 700;">Plik musi znajdować się w lokalizacji "C:\"</p>
        
        <div id="log">
        <form action="SubmitSupply">
            
            <p>
                <label for="un">Wybierz plik:</label>
                <input type="file" id="un" name="plik">
            </p>
            
            <div id="lower">
            <p>
                <input type="submit" value="Załaduj">
            </p>
            </div>
            
        </form>
        </div>
        
    </body>
</html>
