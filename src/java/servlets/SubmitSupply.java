/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.ManageDB;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.w3c.dom.Element;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.w3c.dom.Document;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 *
 * @author steev
 */
@WebServlet(name = "SubmitSupply", urlPatterns = {"/SubmitSupply"})
@MultipartConfig
public class SubmitSupply extends HttpServlet {

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
            out.println("<title>Servlet SubmitSupply</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SubmitSupply at " + request.getContextPath() + "</h1>");
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
        
        //POBRANIE NAZWY PLIKU    
        System.out.println(request.getParameter("plik"));
        
        try {
            //POBRANIE I PRZETWORZENIE PLIKU XML
            File xml = new File("C:/"+request.getParameter("plik"));
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(xml);
            doc.getDocumentElement().normalize();

            //USTAWIENIE CHWYTU NA 1. ZNACZNIK "PRODUKT"
            NodeList nList = doc.getElementsByTagName("produkt");
            
            String id = null;
            String nazwa = null;
            String kategoria = null;
            String cena = null;
            String ilosc1 = null;
            String ilosc2 = null;
            int ilosc = 0;
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;  
            
            
            try 
            {
                //POŁĄCZENIE Z BAZĄ DANYCH
                ManageDB db=new ManageDB("baza", "host.pl", 3306 , "user","pw");
                con = db.getConnection();
                stmt=con.createStatement();	        
                
                //PĘTLA PRZECHODZĄCZA PRZEZ WSZYSTKIE ELEMENTY TYPU "PRODUKT"
                for (int temp = 0; temp < nList.getLength(); temp++) {

                        Node nNode = nList.item(temp);
                        

                        if (nNode.getNodeType() == Node.ELEMENT_NODE) {

                                Element eElement = (Element) nNode;
                                
                                //POBRANIE WARTOŚCI Z ELEMENTU TYPU "PRODUKT" I ZAPISANIE DO ZMIENNYCH 
                                id = eElement.getAttribute("id");
                                nazwa = eElement.getElementsByTagName("nazwa").item(0).getTextContent();
                                kategoria = eElement.getElementsByTagName("kategoria").item(0).getTextContent();
                                cena = eElement.getElementsByTagName("cena").item(0).getTextContent();
                                ilosc1 = eElement.getElementsByTagName("ilosc").item(0).getTextContent();
                                
                                //OBSŁUGA ZAPYTANIA - CZY ZNAJDUJĘ SIĘ W BAZIE PRODUKT O PODANYM ID
                                rs = stmt.executeQuery("SELECT * FROM Produkt WHERE ID="
                                    + id);
                                boolean more = rs.next();
                                
                                if (!more) 
                                {
                                    //OBSŁUGA ZAPYTANIA - JEŚLI NIE ZNAJDUJĘ SIĘ TO DODAJ
                                    stmt.executeQuery("INSERT INTO Produkt VALUES("
                                        + id
                                        +", '"
                                        + nazwa
                                        +"', '"
                                        + kategoria
                                        +"', "
                                        + cena
                                        +", "
                                        + ilosc1
                                        + ")");
                                }
                                else if (more) 
                                {
                                   //OBSŁUGA ZAPYTANIA - JEŚLI ZNAJDUJĘ SIĘ TO POBIERZ JEGO ILOŚĆ W MAGAZYNIE
                                   rs = stmt.executeQuery("SELECT Ilosc FROM Produkt WHERE ID="
                                        + id);
                                   boolean more2 = rs.next();
                                   if(more)
                                   {
                                       //DODAWANIE ILOŚCI PRODUKTU
                                       ilosc2 = rs.getString("Ilosc");
                                       ilosc = Integer.parseInt(ilosc1) + Integer.parseInt(ilosc2);
                                       
                                       //OBSŁUGA ZAPYTANIA - AKTUALIZACJA LICZBY SZTUK W BAZIE
                                       stmt.executeQuery("UPDATE Produkt SET Ilosc="
                                            + ilosc
                                            + " WHERE ID="
                                            + id);
                                   }
                                }
                        }
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

            //POWRÓT DO STRONY REALIZACJI DOSTAW
            response.sendRedirect("dostawa.jsp");
        } catch (Exception e) {
            e.printStackTrace();
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
