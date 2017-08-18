<%-- 
    Document   : dostepnosc
    Created on : 2017-05-12, 12:42:18
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
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <title>Dostępność</title>
    </head>
    <body>
        
        
        <%!
            int level = 0;
            public void jspInit() { 
                ServletConfig cfg = this.getServletConfig(); 
                level = Integer.parseInt(cfg.getInitParameter("level"));
            }
        %>
        
        <div id="header">
                <h1>Kończące się produkty</h1>
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
        <br />
        
         <sql:setDataSource var = "ds" driver = "org.mariadb.jdbc.Driver"
         url = "jdbc:mariadb://host.pl:3306/baza"
         user = "user"  password = "pw"/>
        
        <sql:query dataSource = "${ds}" var = "result">
            SELECT * from Produkt WHERE Ilosc <= <%=level%>;
         </sql:query>
            
            <table border = "1" width = "90%" style="margin-left: auto; margin-right: auto;">
         <tr>
            <th>ID</th>
            <th>Nazwa</th>
            <th>Kategoria</th>
            <th>Cena</th>
            <th>Ilość</th>
         </tr>
         
         <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td> <c:out value = "${row.ID}"/></td>
               <td> <c:out value = "${row.Nazwa}"/></td>
               <td> <c:out value = "${row.Kategoria}"/></td>
               <td style="text-align: right;"> <c:out value = "${row.Cena}"/></td>
               <td style="color: red; font-weight: 700; text-align: right;"> <c:out value = "${row.Ilosc}"/></td>
            </tr>
         </c:forEach>
      </table>
                       
    </body>
</html>
