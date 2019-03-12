package com.vtsl.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vtsl.dbconnection.DBConnect;

@WebServlet("/ForgetPassword")
public class ForgetPassword extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	Connection con=null;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String fname,mail,squest,sans;
		fname=request.getParameter("fname").toLowerCase();
		mail=request.getParameter("mail");
		squest=request.getParameter("squest");
		sans=request.getParameter("sans");
		
		con= DBConnect.getLocalDBConnection();
		try
		{
			System.out.println(fname+"  "+mail+" "+sans+ " "+squest);
			
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select fname,sname,password from userdata where fname='"+fname+"'");
			//System.out.println(rs.next());
			//System.out.println(rs.getWarnings());
			while(rs.next())
			{
				System.out.println(rs.getString(3));
				PrintWriter pw=response.getWriter();
				pw.println("<html>"
						+ "<body> "
						+ "	<h3>Ur password is :"+rs.getString(3)+"</h3>"
						+ "</body>"
						+ "</html>");
				
			}
			
			System.out.println("Exit");
		} 
		catch (SQLException e) 
		{
			
			System.out.println("caught : " +e);
			e.printStackTrace();
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		doGet(request, response);
	}

}
