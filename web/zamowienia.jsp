<%-- 
    Document   : zamowienia
    Created on : 2017-05-12, 12:41:20
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
        <title>Niezrealizowane zamówienia</title>
    </head>
    <body>
            
        <div id="header">
                <h1>Niezrealizowane zamówienia</h1>
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
            SELECT z.ID,Imie, Nazwisko, Adres, Miasto, Kod, Telefon, Nazwa, zp.Ilosc
            FROM Zamowienie z, ZamowienieProdukty zp, Klient k, Produkt p
            WHERE k.ID = z.Id_klienta AND z.ID = zp.Id_zamowienia AND zp.Id_produktu = p.ID AND z.Zrealizowane=0
            ORDER BY z.ID;
         </sql:query>
            
      <table border = "1" width = "100%">
         <tr>
            <th>ID</th>
            <th>Imie</th>
            <th>Nazwisko</th>
            <th>Adres</th>
            <th>Miasto</th>
            <th>Kod</th>
            <th>Telefon</th>
            <th>Nazwa</th>
            <th>Ilość</th>
            <th>Akcje</th>
         </tr>
         
         <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td> <c:out value = "${row.ID}"/></td>
               <td> <c:out value = "${row.Imie}"/></td>
               <td> <c:out value = "${row.Nazwisko}"/></td>
               <td> <c:out value = "${row.Adres}"/></td>
               <td> <c:out value = "${row.Miasto}"/></td>
               <td style="text-align: right;"> <c:out value = "${row.Kod}"/></td>
               <td style="text-align: right;"> <c:out value = "${row.Telefon}"/></td>
               <td> <c:out value = "${row.Nazwa}"/></td>
               <td style="text-align: right;"> <c:out value = "${row.Ilosc}"/></td>
               <td> 
                   <form action="SubmitOrder">
                       <input type="hidden" name="zid" value="<c:out value = "${row.ID}"/>">
                       <input type="submit" value="Zatwierdź" style="width: 100px;">
                   </form>
               </td>
            </tr>
         </c:forEach>
      </table>
    </body>
</html>
