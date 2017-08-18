<%-- 
    Document   : usun
    Created on : 2017-05-17, 13:56:37
    Author     : steev
--%>

<%@page import="db.ManageDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="model.Admin"%>
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

<%
            Statement stmt=null;
            Connection con=null;
            ResultSet rs = null;  
            String id = null;
            String nazwa = null;
            String kategoria = null;
            String cena = null;
            String ilosc = null;
            
            //POBRANIE ID PRODUKTU
            String pid = request.getParameter("pid");

            try 
            {
                //POŁĄCZENIE Z BAZĄ DANYCH
                ManageDB db=new ManageDB("baza", "host.pl", 3306 , "user","pw");
                con = db.getConnection();
                stmt=con.createStatement();
                
                //OBSŁUGA ZAPYTANIA
                rs = stmt.executeQuery("SELECT * FROM Produkt WHERE ID="
                                    + pid);
                boolean more = rs.next();
                if (more) 
                {
                    //POBRANIE WARTOŚCI
                    id = rs.getString("ID");
                    nazwa = rs.getString("Nazwa");
                    kategoria = rs.getString("Kategoria");
                    cena = rs.getString("Cena");
                    ilosc = rs.getString("Ilosc");
                }
            }catch (Exception ex) 
            {
               System.out.println(ex);
            } 
            finally 
            {
                //ZAMKNIĘCIE POŁĄCZENIA
                if (rs != null)	{
                    try {
                        rs.close();
                    } catch (Exception e) {}
                        rs = null;
                    }

                if (stmt != null) {
                    try {
                        stmt.close();
                    } catch (Exception e) {}
                        stmt = null;
                    }

                if (con != null) {
                    try {
                        con.close();
                    } catch (Exception e) {}
                    con = null;
               }
            }
        %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <title>Potwierdzenie usunięcia</title>
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
        
        <div id="panel">
            <h1>Czy napewno chcesz usunąć ten produkt?</h1>
            <table>
                <tr>
                    <td>ID:</td><td><%=id%></td>
                </tr>
                <tr>
                    <td>Nazwa:</td><td><%=nazwa%></td>
                </tr>
                <tr>
                    <td>Kategoria:</td><td><%=kategoria%></td>
                </tr>
                <tr>
                    <td>Cena:</td><td><%=cena%></td>
                </tr>
                <tr>
                    <td>Ilość:</td><td><%=ilosc%></td>
                </tr>
            </table>

            <form action="DeleteProduct">
                           <input type="hidden" name="pid" value="<%=id%>">
                           <input type="submit" value="Usuń" style="margin-top: 50px; margin-left: auto; margin-right: auto;">
            </form>
        </div>
        
    </body>
</html>
