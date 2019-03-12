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


@WebServlet("/CreateTaskAction")
public class CreateTaskAction extends HttpServlet 
{
	String fileid,filename,comments,fileOwner,toUser,fromUser;
	String status;
	Timestamp currentLastmodification;
	FileImplementation forCheckingDetails;
	String fname,comm;
	
    Connection con=DBConnect.getLocalDBConnection();
    Statement stmt;
    ResultSet rs;
    PreparedStatement ps;
    File file;
    FileReader freader;
    String[] users;
    HttpSession session;
    String asn_fname;
	private static final long serialVersionUID = 1L;
	private BufferedWriter br;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		PrintWriter out=response.getWriter();
		users=request.getParameterValues("users");
		fileid=request.getParameter("fid").toLowerCase();
		filename=request.getParameter("fname").toLowerCase();
		comments=request.getParameter("comm");
		asn_fname=filename.concat(".txt");
		toUser=request.getParameter("user");
		
		session=request.getSession();
		fileOwner=(String)session.getAttribute("name");
		
		if(status==null)
			status="assigned";
		
		
		forCheckingDetails=new FileImplementation();
		if(users!=null)
		{
		//System.out.println("Entered in not null");
		
		    try {
		    		
		    	   	for(int i=0;i<users.length;i++)
					{
		    	   		String queryforMultiple=" insert into assigntask values(?,?,?,?,?,?) ";
		    	   		ps=con.prepareStatement(queryforMultiple);
		    			
		    		
		    			//ps.setCharacterStream(3, freader,(int)file.length());
		    			ps.setString(1, users[i]);
		    			ps.setString(2, filename);
		    			ps.setString(3, fileOwner);
		    			ps.setString(4, comments);
		    			ps.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
		    			ps.setString(6,status);
		    			
		    			System.out.println("------->"+users[i]);
		    			
		    			ps.executeUpdate();
					}
		    	   	
		    	   	
		    	   	
				} 
		    	catch (SQLException e) 
		       {
			
		    		e.printStackTrace();
		       }
			
		}
	
		System.out.print(filename+"" +fileid+" "+ fileOwner+""+currentLastmodification+" "+status+" "+comments);
		//forCheckingDetails.detailsAboutFile(filename,fileid, fileOwner, currentLastmodification, status, comments);
		
		forCheckingDetails.setFileName(filename);
		forCheckingDetails.setFileId(fileid);
		forCheckingDetails.setFile_owner(fileOwner);
	//	forCheckingDetails.setFileCreationTime(currentLastmodification);
		forCheckingDetails.setComm(comments);
		forCheckingDetails.setFileStatus(status);
		
		
		
		file=new File(asn_fname);
		FileWriter fr = new FileWriter(file, true);
		br = new BufferedWriter(fr);
		
		br.newLine();
		br.write("================================================================ ");
		br.newLine();
		br.write("File Id: 	"	+forCheckingDetails.getFileId());
		br.newLine();
		br.write("File Name: "	+forCheckingDetails.getFileName());
		br.newLine();
		br.write("File From: " 	+forCheckingDetails.getFile_owner());
		br.newLine();
		br.write("File Created Date: "			+new java.sql.Timestamp(System.currentTimeMillis()));
		br.newLine();
		br.write("File Last Modificatio Date: "	+forCheckingDetails.getLastModificationTime());
		br.newLine();
		br.write("File Status is: "				+forCheckingDetails.getFileStatus());
		br.newLine();
		br.write("File Content: "				+forCheckingDetails.getComm());
		br.newLine();
		br.write("================================================================= ");
		br.newLine();

		br.close();
		
		freader=new FileReader(file);
		
		try
		{
					String queryfor=" insert into taskfile values(?,?,?,?,?,?,?,?,?) ";
	    	   		ps=con.prepareStatement(queryfor);
	    	   		ps.setString(1, fileid);
	    			ps.setString(2, filename);
	    			ps.setCharacterStream(3, freader,(int)file.length());
	    			ps.setString(4, toUser);
	    			ps.setString(5, fileOwner);
	    			ps.setString(6, status);
	    			ps.setTimestamp(7, new java.sql.Timestamp(System.currentTimeMillis()));
	    			ps.setTimestamp(8, null);
	    			ps.setString(9,comments);
					ps.executeUpdate();
	    			System.out.println("updated task file in tf table");
			
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		}
		finally 
		{
			out.println("<head></style><script src='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js'></script><script src='//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script><link href='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet' id='bootstrap-css'></head>"
					+ "<body><h2>successfully assigned</h2></body>");
		}
			
		if(file.exists())
		{
			try 
			{
				System.out.println("Entered here------------->");
				
				File f1=new File(asn_fname);
				FileReader f2=new FileReader(f1);
				
				currentLastmodification=new java.sql.Timestamp(System.currentTimeMillis());
				String query3=" update taskfile set tf_file=?, toemp=?,from_emp=?,tfstatus=?,tfmodify=?,tfcomments=? where tfid=? and tfname=?" ;
				ps=con.prepareStatement(query3);
				ps.setCharacterStream(1, f2,(int)f1.length());
				System.out.println("Enterd in updated table");
				ps.setString(2, toUser);
				ps.setString(3, fileOwner);
				ps.setString(4, status);
				ps.setTimestamp(5, currentLastmodification);
				ps.setString(6, comments);
				ps.setString(7,fileid);
				ps.setString(8, filename);
				ps.executeUpdate();
			
				System.out.println("Updated table 1");
			
			//	currentLastmodification=new java.sql.Timestamp(System.currentTimeMillis());
				String query5=" update assigntask set touser=?,asn_admin=?,status=?,asn_date=?,comm_desc=? where touser=? and asn_fname=?" ;
				ps=con.prepareStatement(query5);
				//ps.setCharacterStream(1, freader,(int)file.length());
				System.out.println("Enterd in updated table");
				ps.setString(1, toUser);
				ps.setString(2, fileOwner);
				ps.setString(3, status);
				ps.setTimestamp(4, currentLastmodification);
				ps.setString(5, comments);
				ps.setString(6,toUser);
				ps.setString(7, filename);
				
				ps.executeUpdate();
				
				System.out.println("Updated table 2");
				
				
				response.sendRedirect("Thankyou.jsp");
				
			}
			catch (Exception e) 
			{
				
			}
			finally 
			{
				out.close();
				freader.close();
				
				
			}

		}
		


	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		doGet(request, response);
	}

}
