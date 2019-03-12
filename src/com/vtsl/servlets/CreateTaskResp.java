package com.vtsl.servlets;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vtsl.daos.FileImplementation;
import com.vtsl.dbconnection.DBConnect;


@WebServlet("/CreateTaskResp")
public class CreateTaskResp extends HttpServlet 
{
	String name,filename,comments,status,fileid,fromUser;
	HttpSession session;
	Timestamp currentLastmodification;
	Connection con;
	String asn_fname;
	File file;
	FileReader freader;
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("resource")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		session=request.getSession();
		name=(String)session.getAttribute("name");
		filename=request.getParameter("fname");
		comments=request.getParameter("comm");
		status=request.getParameter("status");
	
		//System.out.println(filename+ " "+comments+ " "+status+ ""+name);
		
		currentLastmodification=new java.sql.Timestamp(System.currentTimeMillis());
		FileImplementation forCheckingDetails=new FileImplementation();
		
		
		con=DBConnect.getLocalDBConnection();
		ResultSet rs;
		PreparedStatement ps;
		try 
		{
			String query="select tfid ,from_emp from taskfile where tfname=? " ;
			
			ps=con.prepareStatement(query);
			ps.setString(1, filename);
			//String fromEmp=(String)session.getAttribute("name");
			
			System.out.print("Entered " +filename) ;
			//ps.setString(1, fileid);
			rs=ps.executeQuery();
			while(rs.next())
			{
				
				if(rs.getString(2)!=null)
				{
					fromUser=rs.getString(2);
					fileid=rs.getString(1);
				}
				else
				{
					String query4="select tfid ,asn_admin,comm_desc from taskfile,assigntask where assigntask.asn_fname=taskfile.tfname " ;
					
					ps=con.prepareStatement(query4);
					//ps.setString(1, filename);
					//String fromEmp=(String)session.getAttribute("name");
					
					System.out.print("Entered " +filename) ;
					//ps.setString(1, fileid);
					rs=ps.executeQuery();
					while(rs.next())
					{
						fromUser=rs.getString(2);
						//comments=rs.getString(3);
						fileid=rs.getString(1);
					}
					
				}
			}
			//ps.executeUpdate();
		
			//out.println("successfully assigned");
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		forCheckingDetails.detailsAboutFile(filename, fileid, fromUser, currentLastmodification, status, comments);
		
		
		asn_fname=filename.concat(".txt");
		file = new File(asn_fname);
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
		//br.write("File Created Date: "			+new java.sql.Timestamp(System.currentTimeMillis()));
		//br.newLine();
		br.write("File Last Modificatio Date: "	+forCheckingDetails.getLastModificationTime());
		br.newLine();
		br.write("File Status is: "				+forCheckingDetails.getFileStatus());
		br.newLine();
		br.write("File Content is: "				+forCheckingDetails.getComm());
		br.newLine();
		br.write("================================================================= ");
		br.newLine();
		
		br.close();
		
		
		
		String query2=" update taskfile set tf_file=?,from_emp=?,tfstatus=?,tfmodify=?,tfcomments=? where tfname=? and toemp=? or toemp is null" ;
		try 
		{
			File file3=new File(asn_fname);
			FileReader freader1=new FileReader(file3);
			
			//String fromEmp=(String)session.getAttribute("name");
			ps=con.prepareStatement(query2);
			ps.setCharacterStream(1, freader1,(int)file3.length());
			ps.setString(2, name);
			ps.setString(3, status);
			ps.setTimestamp(4, currentLastmodification);
			ps.setString(5, comments);
			ps.setString(6, filename);
			ps.setString(7, name);
		
			System.out.println(name+ ""+status+" "+currentLastmodification+ " "+comments+ " "+filename+ " "+name);
			ps.executeUpdate();
		
			System.out.println("successfully assigned");
			
			String upassigntask="update assigntask set status=?,comm_desc=? where touser=? and asn_fname=?";
			ps=con.prepareStatement(upassigntask);
			ps.setString(1, status);
			ps.setString(2, comments);
			ps.setString(3, name);
			ps.setString(4, filename);
					
			ps.executeUpdate();
		}
		catch (SQLException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		if((status.equalsIgnoreCase("completed")))
		{
			String query3=" update taskfile set tf_file=?,from_emp=?,tfstatus=?,tfmodify=?,tfcomments=? where tfname=? and toemp=? or toemp is null" ;
			try 
			{
				File file2=new File(asn_fname);
				FileReader freader1=new FileReader(file2);
				
				//String fromEmp=(String)session.getAttribute("name");
				ps=con.prepareStatement(query3);
				ps.setCharacterStream(1, freader1,(int)file2.length());
				ps.setString(2, fromUser);
				ps.setString(3, status);
				ps.setTimestamp(4, currentLastmodification);
				ps.setString(5, comments);
				ps.setString(6, filename);
				ps.setString(7, name);
				//ps.executeUpdate();
				
				String changeStatus="update taskfile set toemp=? where toemp=? and tfname=?";
				ps=con.prepareStatement(changeStatus);
				//ps.setString(1, status);
				ps.setString(1, name+" - Finished");
				ps.setString(2,name);
				ps.setString(3,filename);
				//ps.executeUpdate();
				System.out.println("Exited for change---------1");
				
				System.out.println("Entered for change---------2");
				String changeStatus1="update assigntask set touser=?,status=?,comm_desc=? where  touser=? and asn_fname=?";
				ps=con.prepareStatement(changeStatus1);
				ps.setString(1, name+"- Finished");
				ps.setString(2, status);
				ps.setString(3, comments);
				ps.setString(4, name);
				ps.setString(5, filename);
				ps.executeUpdate();
			}
			catch (Exception e) 
			{
				// TODO: handle exception
			}
		}
		//br.close();
		response.sendRedirect("Thankyou.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		doGet(request, response);
	}

}
