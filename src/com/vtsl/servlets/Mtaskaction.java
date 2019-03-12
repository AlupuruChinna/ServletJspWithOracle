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

import com.vtsl.dbconnection.DBConnect;

@WebServlet("/Mtaskaction")
public class Mtaskaction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con = DBConnect.getLocalDBConnection();
	ResultSet rs;
	PreparedStatement ps;
	String touser,asn_admin,asn_fname,comm_desc,asn_date;
	Statement stmt;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session=request.getSession();
		PrintWriter pw=response.getWriter();
		//pw.println("Hello Weclome to Servlet");
		
		String filename=request.getParameter("option");
		String[] users=request.getParameterValues("users");
		/*String[] availableDate = request.getParameterValues("date");

		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
		Date da = null;
		try {
			da=sdf.parse(availableDate[0]);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
*/		
		if(users!=null)
		{
			//System.out.println("Entered in not null");
			
			asn_fname=request.getParameter("option");
		    asn_admin=(String)session.getAttribute("name");
		    comm_desc=request.getParameter("comm");
		    
		    String query="insert into assigntask values(?,?,?,?,?,?)";
			    try {
			    	   	ps=con.prepareStatement(query);
			    	   	for(int i=0;i<users.length;i++)
						{
						
			    	   		ps.setString(1, users[i]);
			    	   		ps.setString(2, asn_fname);
				    	   	ps.setString(3, asn_admin);
				    	   	ps.setString(4, comm_desc);
				    	   	ps.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
				    	   	ps.setString(6, "assigned");
						}
			    	   	
			    	   	ps.executeUpdate();
			    	   	
			    	   	
			    	   	
				} catch (SQLException e) 
			       {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
		

		pw.println("<head></style><script src='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js'></script><script src='//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script><link href='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet' id='bootstrap-css'></head>"
				+ "<a href='multipleassigntask.jsp'>Continue..</a>"
				+ "<body><h2>successfully assigned</h2></body>");
		   
			//response.sendRedirect("");
		pw.println(filename+" " +(new java.util.Date()).toLocaleString());
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		doGet(request, response);
	}

}
