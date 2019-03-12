package com.vtsl.servlets;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vtsl.dbconnection.DBConnect;

@WebServlet("/DownloadClob")
public class DownloadClob extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	Connection con=DBConnect.getLocalDBConnection();
	private FileWriter fw;
	private Clob c;
	private Reader r;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		PrintWriter out=response.getWriter();
		String filename=request.getParameter("filename");
		System.out.println(filename);
		PreparedStatement ps;
		try {
			ps = con.prepareStatement("select tf_file from taskfile where tfname=?");
			ps.setString(1, filename);
			ResultSet rs=ps.executeQuery();  

			while(rs.next())
			{
				File data = new File(filename);
				//response.setContentType("force-download");
				System.out.println("Entered in while-- "+filename);
	            // Get the character stream of our CLOB data
	            Reader reader = rs.getCharacterStream(1);
	            FileWriter writer = new FileWriter(data);
	            char[] buffer = new char[1];
	            while (reader.read(buffer) > 0) 
	            {
	                writer.write(buffer);
	                
	              /*  response.setHeader("Content-Disposition",
	    	                "attachment;filename="+filename+ ".txt");*/
	            }
	            writer.close();
				
	           /* out.println("<html><head><link href='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet' id='bootstrap-css'>"
						+ "<body><h2>Download Successfully... Thank You</h2></body></html>");*/		        

			}

			out.println("<html><head><link href='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet' id='bootstrap-css'>"
					+ "<body><h2>Download Successfully... Thank You</h2></body></html>");		        
			 //fw.close();
		//	 r.close();
			// c.free();
			
		}
		catch (SQLException e) 
		{
			
			e.printStackTrace();
		}  
		              
		//fw.close();
		//r.close();
		//con.close();  
	}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
	
		doGet(request, response);
	}

}
