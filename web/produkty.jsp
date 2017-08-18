<%-- 
    Document   : produkty
    Created on : 2017-05-12, 08:57:23
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
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <title>Lista produktów</title>
    </head>
    <body>
        
        <div id="header">
                <h1>Lista produktów</h1>
        </div>    
            
        <p>
            Zalogowany jako <%=username%>
        </p>
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
            SELECT * from Produkt;
         </sql:query>
            
      <table border = "1" width = "100%">
         <tr>
            <th>ID</th>
            <th>Nazwa</th>
            <th>Kategoria</th>
            <th>Cena</th>
            <th>Ilość</th>
            <th>Akcje</th>
         </tr>
         
         <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td> <c:out value = "${row.ID}"/></td>
               <td> <c:out value = "${row.Nazwa}"/></td>
               <td> <c:out value = "${row.Kategoria}"/></td>
               <td style="text-align: right;"> <c:out value = "${row.Cena}"/></td>
               <td style="text-align: right;"> <c:out value = "${row.Ilosc}"/></td>
               <td> 
                   <form action="edycja.jsp">
                       <input type="hidden" name="pid" value="<c:out value = "${row.ID}"/>">
                       <input type="submit" value="Edytuj">
                   </form>
                   <form action="usun.jsp">
                       <input type="hidden" name="pid" value="<c:out value = "${row.ID}"/>">
                       <input type="submit" value="Usuń">
                   </form>
               </td>
            </tr>
         </c:forEach>
      </table>
            
            <a href="dodaj.jsp" style="text-decoration: none;">
                <div id="dodaj">
                    Dodaj produkt
                </div>
            </a>
    </body>
</html>
