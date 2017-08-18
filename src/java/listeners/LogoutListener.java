/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listeners;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Web application lifecycle listener.
 *
 * @author steev
 */
public class LogoutListener implements ServletContextListener, HttpSessionListener {

    public LogoutListener()
    {
    }
    
    ServletContext servletContext;
    
    
    @Override
    public void contextInitialized(ServletContextEvent sce) 
    {
        //POBRANIE KONTEKSTU SERWLETU
        servletContext = sce.getServletContext();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) 
    {     
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) 
    {
        //POWIADOMIENIE W KONSOLI O UTWORZENIU SESJI
        log("Sesja utworzona",se);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        //POWIADOMIENIE W KONSOLI O ZAKOŃCZENIU I CZASIE TRWANIA SESJI 
         HttpSession session = se.getSession();
         long start = session.getCreationTime();
         long end = session.getLastAccessedTime();
         log("Sesja zakończona, Czas trwania:" 
                   + (end - start) + "(ms)", se);
    }
    
    protected void log(String msg, HttpSessionEvent hse)
   {
       //POBRANIE ID SESJI
      String _ID = hse.getSession().getId();
      log("SessionID:" + _ID + "    " + msg);
   }
    
    protected void log(String msg)
   {
      System.out.println("[" + getClass().getName() + "] " + msg);
   }
}
