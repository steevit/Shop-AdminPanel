<%-- 
    Document   : panel.jsp
    Created on : 2017-05-11, 22:07:20
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

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.Admin"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel administracyjny</title>
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <link rel="stylesheet" href="css/fontello.css" type="text/css">
    </head>
    <body>
               
            
            <div id="header">
                <h1>panel administracyjny</h1>
            </div>
            
            <div id="info">
                <p>Zalogowany jako <%=username%></p>
                <a href="LogoutServlet" style="text-decoration: none;">
                    <div id="wyloguj">
                        Wyloguj się
                    </div>
            </a>    
            </div> 
			
            <div id="panel">
                
                <a href="produkty.jsp">
                <div class="button">
                    <p style="text-align: center; font-size: 28px; margin-top: 15px; margin-bottom: 15px;">PRODUKTY</p>
                    <i class="icon-basket" style="margin-left: 15px;"></i>
                </div>
                </a>
                
                <a href="zamowienia.jsp">
                <div class="button">
                    <p style="text-align: center; font-size: 28px; margin-top: 15px; margin-bottom: 15px;">ZAMÓWIENIA</p>
                    <i class="icon-list-alt" style="margin-left: 15px;"></i>
                </div>
                </a>
                
                <a href="dostawa.jsp">
                <div class="button">
                    <p style="text-align: center; font-size: 28px; margin-top: 15px; margin-bottom: 15px;">DOSTAWA</p>
                    <i class="icon-truck" style="margin-left: 15px;"></i>
                </div>
                </a>
                
                <a href="dostepnosc.jsp">
                <div class="button">
                    <p style="text-align: center; font-size: 28px; margin-top: 15px; margin-bottom: 15px;">DOSTĘPNOŚĆ</p>
                    <i class="icon-cancel-circled" style="margin-left: 15px;"></i>
                </div>
                <div style="clear:both;"></div>
                </a>
                
            </div> 
         
    </body>
</html>
