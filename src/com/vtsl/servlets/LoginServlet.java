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
import javax.servlet.http.HttpSession;

import com.vtsl.beans.Userbean;
import com.vtsl.dbconnection.DBConnect;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
	Connection con=null;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
	
		String name=request.getParameter("uname");
		String pwd=request.getParameter("psw");
		HttpSession session;
		//System.out.println(name+ " "+pwd);
		con=DBConnect.getLocalDBConnection();
		try 
		{
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select fname,password from userdata where fname='"+name+"'");
			
			while(rs.next())
			{
			if(name.equals(rs.getString(1)) & pwd.equals(rs.getString(2)))
				{
					//System.out.println("true");
					session=request.getSession();
					
					session.setAttribute("name", name);
					/*Userbean u= new Userbean();
					u.setFname(name);*/
					request.getRequestDispatcher("mainhome.jsp").forward(request, response);
				}			
	
			}
							
			//System.err.println("Exited");
			//System.err.println("Failed");
			request.getRequestDispatcher("error.jsp").include(request, response);
		}
		catch (SQLException e) 
		{
			System.out.println("Caught : " +e);
			e.printStackTrace();
			response.sendRedirect("index.html");
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		doGet(request, response);
	}

}
