package com.vtsl.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vtsl.beans.Userbean;
import com.vtsl.dbconnection.DBConnect;

@WebServlet("/UserRegistration")
public class UserRegistration extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Userbean u= new Userbean();
		
		String fname=request.getParameter("fname").toLowerCase();
		String sname=request.getParameter("sname").toLowerCase();
		String mail=request.getParameter("mail").toLowerCase();
		String pwd=request.getParameter("pwd");
		String gender=request.getParameter("gen").toLowerCase();
		String squest=request.getParameter("squest").toLowerCase();
		String sans=request.getParameter("sans").toLowerCase();
		
		Connection con= DBConnect.getLocalDBConnection();
		try 
		{
			
			PreparedStatement ps=con.prepareStatement("insert into userdata values(?,?,?,?,?,?,?)");
			ps.setString(1, fname);
			ps.setString(2, sname);
			ps.setString(3,	mail);
			ps.setString(4, pwd);
			ps.setString(5, gender);
			ps.setString(6, squest);
			ps.setString(7, sans);
			
			int i=ps.executeUpdate();
			
			if(i!=0)
			{
				System.out.println("Registration done successfully");
				request.getRequestDispatcher("thankyoufor.jsp").forward(request, response);
			}
			else
			{
				System.out.println("Failed to registration");
				request.getRequestDispatcher("regresponse.jsp").include(request, response);
			}
			
			
		}
		catch (SQLException e) 
		{
			System.out.println("Caught  : " +e);
			
			e.printStackTrace();
			
			System.out.println("Failed to registration");
			response.sendRedirect("regresponse.jsp");
			
		}
		
		

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		doGet(request, response);
	}

}
