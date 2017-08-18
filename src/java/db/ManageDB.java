/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.Connection;
import java.sql.SQLException;
import org.mariadb.jdbc.MariaDbDataSource;

/**
 *
 * @author steev
 */
public class ManageDB {
    MariaDbDataSource ds;
    static Connection con;
   
    //KONSTRUKTOR INICJUJĄCY POŁĄCZENIE
    public ManageDB(String dbName, String dbServerName, int port, String dbUsername, String dbPass) throws SQLException {
        ds=new MariaDbDataSource();
        ds.setDatabaseName(dbName);
        ds.setPassword(dbPass);
        ds.setPortNumber(port);
        ds.setServerName(dbServerName);
        ds.setUser(dbUsername);
        con=ds.getConnection();
    }
    
    //METODA ZWRACAJĄCA POŁĄCZENIE
    public static Connection getConnection()
    {
         return con;
    }
     
    
}
