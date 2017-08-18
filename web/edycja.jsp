<%-- 
    Document   : edycja
    Created on : 2017-05-12, 13:22:40
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
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.ManageDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <title>Edycja produktu</title>
    </head>
    <body>
        
        <% 
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            String nazwa="";
            String kategoria="";
            String cena="";
            String ilosc="";
           
            //POBRANIE ID EDYTOWANEGO PRODUKTU
            String pid = request.getParameter("pid");
           
            
            
            try{
                //POŁĄCZENIE Z BAZĄ DANYCH
                ManageDB db=new ManageDB("baza", "host.pl", 3306 , "user","pw");
                con = db.getConnection();
                stmt=con.createStatement();
                
                //OBSŁUGA ZAPYTANIA
                String query = "SELECT * from Produkt where ID='"
                    + pid
                    + "'";
                rs = stmt.executeQuery(query);
                boolean more = rs.next();   

                if (!more) 
                {
                   System.out.println("Brak produktu o ID: "+pid);
                } 
                else if (more) 
                {
                    //POBRANIE WARTOŚCI
                    nazwa = rs.getString("Nazwa");
                    kategoria = rs.getString("Kategoria");
                    cena = rs.getString("Cena");
                    ilosc = rs.getString("Ilosc");
                }
            }catch (Throwable e) 	    
                {
                    System.out.println(e); 
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
        <form action="EditProduct">
            
            <p>
                <label for="name">Nazwa</label>
                <input type="text" id="name" name="name" value="<%=nazwa%>">
            </p>
            <p>
                <label for="cat">Kategoria</label>
                <input type="text" id="cat" name="cat" value="<%=kategoria%>">
            </p>
            <p>
                <label for="price">Cena</label>
                <input type="text" id="price" name="price" value="<%=cena%>">
            </p>
            <p>
                <label for="quan">Ilość</label>
                <input type="number" id="quan" name="quan" value="<%=ilosc%>">
            </p>
            <input type="hidden" name="pid" value="<%=pid%>">
            <div id="lower">
            <p>
                <input type="submit" value="Zapisz">
            </p>
            </div>
            
        </form>
        </div>
    </body>
</html>
