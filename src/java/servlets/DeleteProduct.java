/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.ManageDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author steev
 */
@WebServlet(name = "DeleteProduct", urlPatterns = {"/DeleteProduct"})
public class DeleteProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteProduct</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteProduct at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Statement stmt=null;
        Connection con=null;
        
        //POBRANIE ID PRODUKTU
        String pid = request.getParameter("pid");
        
                try
                {	
                    //POŁĄCZENIE Z BAZĄ DANYCH
                    ManageDB db=new ManageDB("baza", "host.pl", 3306 , "user","pw");
                    con = db.getConnection();
                    stmt=con.createStatement();
                    
                    //OBSŁUGA ZAPYTANIA
                    stmt.executeQuery("delete from Produkt where ID='"
                                        + pid
                                        + "'");	
                    
                    //POWRÓT DO LISTY PRODUKTÓW
                    response.sendRedirect("produkty.jsp");
                }		
                catch (Throwable e) 	    
                {
                     System.out.println(e); 
                }
                finally 
                {
                    //ZAMKNIĘCIE POŁĄCZENIA
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
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
