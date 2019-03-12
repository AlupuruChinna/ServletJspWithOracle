package com.vtsl.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vtsl.dbconnection.DBConnect;


@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
	Connection con=null;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
	
		String name=request.getParameter("uname");
		String pwd=request.getParameter("pwd");
		HttpSession session;
		//System.out.println(name+ " "+pwd);
		con=DBConnect.getLocalDBConnection();
		try 
		{
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("select afname,password from admindata where afname='"+name+"'");
			
			while(rs.next())
			{
			if(name.equals(rs.getString(1)) & pwd.equals(rs.getString(2)))
				{
					//System.out.println("true");
					session=request.getSession();
					session.setAttribute("name", name);
					request.getRequestDispatcher("adminmainhome.jsp").forward(request, response);
				}			
	
			}
							
			//System.err.println("Exited");
			//System.err.println("Failed");
			request.getRequestDispatcher("error.jsp").include(request, response);
		}
		catch (SQLException e) 
		{
			System.out.println("Caught Some: " +e);
			e.printStackTrace();
			response.sendRedirect("index.html");
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		doGet(request, response);
	}

}
