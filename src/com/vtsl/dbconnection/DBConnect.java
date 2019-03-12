package com.vtsl.dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect 
{
	static Connection con=null;
	public static Connection getLocalDBConnection()
	{
		try{  
			
			
			Class.forName("oracle.jdbc.driver.OracleDriver");  
			con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","smart","smart");  
			  
			System.out.println("connection Established");  
			}
			catch(Exception e)
			{ 
			System.out.println(e);
			}
		return con;
		
	}
}
