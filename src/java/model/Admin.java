/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author steev
 */
public class Admin 
{
    private String username;
    private String password;
    public boolean valid;
	
      
    public String getPassword() 
    {
         return password;
    }

    public void setPassword(String newPassword) 
    {
        password = newPassword;
    }
	
			
    public String getUsername() 
    {
        return username;
    }

    public void setUserName(String newUsername) 
    {
        username = newUsername;
    }

}
