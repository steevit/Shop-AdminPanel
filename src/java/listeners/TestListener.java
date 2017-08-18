/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listeners;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author steev
 */
public class TestListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Serwer uruchomiony"); 
        
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
       System.out.println("Serwer zatrzymany");      
    }
}
