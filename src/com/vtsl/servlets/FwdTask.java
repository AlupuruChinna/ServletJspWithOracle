package com.vtsl.servlets;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vtsl.daos.FileImplementation;
import com.vtsl.dbconnection.DBConnect;

@WebServlet("/FwdTask")
public class FwdTask extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	Connection con=DBConnect.getLocalDBConnection();
    Statement stmt;
    ResultSet rs;
    PreparedStatement ps;
    File file;
    int check;
    String name,tfname,toUser,comments,tfid,status;
	FileReader freader;
	
	Timestamp tfcreated;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session=request.getSession();
		PrintWriter out=response.getWriter();
		name=(String)session.getAttribute("name");
		tfname=request.getParameter("selectfile");
		toUser=request.getParameter("selectuser");
		comments=request.getParameter("comm");
	
	
		FileImplementation forCheckingDetails=new FileImplementation();
		//System.out.println(filename);
		
		
		try
		{
			String query="select * from taskfile where tfname=?" ;
			ps=con.prepareStatement(query);
			ps.setString(1, tfname);
			//ps.setString(2, tfname);
			//ps.setString(3, tfname);*/
			
			rs=ps.executeQuery();
			while(rs.next())
			{
				tfid=rs.getString(1);
				tfcreated=rs.getTimestamp("tfcreated");
				//status=rs.getString("tfstatus");
			}
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		}
		String asn_fname=tfname.concat(".txt");
		file = new File(asn_fname);
		forCheckingDetails.setFileId(tfid);
		forCheckingDetails.setComm(comments);
		forCheckingDetails.setFileForwardBy(name);
		forCheckingDetails.setFileName(tfname);
		forCheckingDetails.setLastModificationTime(new java.sql.Timestamp(System.currentTimeMillis()) );
		forCheckingDetails.setFileStatus("forwarded");
		//System.out.println(filename);
		//System.out.println("Entered after stream");
		
		FileWriter fr = new FileWriter(file, true);
		BufferedWriter br = new BufferedWriter(fr);
		
		br.newLine();
		br.write("================================================================ ");
		br.newLine();
		br.write("File Id: 	"	+forCheckingDetails.getFileId());
		br.newLine();
		br.write("File Name: "	+forCheckingDetails.getFileName());
		br.newLine();
		br.write("File From: " 	+forCheckingDetails.getFileForwardBy());
		br.newLine();
		br.write("File Created Date: "			+tfcreated);
		br.newLine();
		br.write("File Last Modificatio Date: "	+forCheckingDetails.getLastModificationTime());
		br.newLine();
		br.write("File Status is: "				+forCheckingDetails.getFileStatus());
		br.newLine();
		br.write("File Content is: "				+forCheckingDetails.getComm());
		br.newLine();
		br.write("================================================================= ");
		br.newLine();
		
		
		br.close();
		
		
		//freader = new FileReader(file);
	
		File f1=new File(asn_fname);
		FileReader f2=new FileReader(f1);
		
		try
		{
			String fwdTask="update taskfile set toemp=? where tfname=? and toemp=? ";
			ps=con.prepareStatement(fwdTask);
			ps.setString(1,toUser);
			ps.setString(2, tfname);
			ps.setString(3, name);
			//ps.executeQuery();
			ps.executeUpdate();
			
			
			String fwdTask2="update taskfile set tf_file=? where tfname=?";
			ps=con.prepareStatement(fwdTask2);
			ps.setCharacterStream(1,f2,(int)f1.length());
			ps.setString(2, tfname);
			
			//ps.executeQuery();
			ps.executeUpdate();
			
			String fwdTask1="update assigntask set touser=? where asn_fname=? and touser=? ";
			ps=con.prepareStatement(fwdTask1);
			ps.setString(1,toUser);
			ps.setString(2, tfname);
			ps.setString(3, name);
			//ps.executeQuery();
			ps.executeUpdate();
			System.out.println("Exicuted");
			out.println("<html><head><link href='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet' id='bootstrap-css'>"
					+ "<body><h2>Task hasbeen forwarded</h2></body></html>");
			
			
		}
		catch(Exception e)
		{
			System.out.print("Caught some: "+e);
			out.print(e);
		}
		out.println("<html><head><link href='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet' id='bootstrap-css'>"
				+ "<body><h2>Task hasbeen forwarded</h2></body></html>");
			}
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		doGet(request, response);
	}

	
}
