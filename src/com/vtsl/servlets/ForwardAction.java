package com.vtsl.servlets;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vtsl.daos.FileImplementation;


@WebServlet("/ForwardAction")
public class ForwardAction extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	String filename;
	String fromUser;
	String toUser;
	String getComments;
	
       
    	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    	{
    		HttpSession session=request.getSession();
    		
    		filename=request.getParameter("selectfile");
    		fromUser=(String)session.getAttribute("name");
    		toUser=request.getParameter("selectuser");
    		getComments=request.getParameter("comm");
    		System.out.println("--------------------------------------");
    		System.out.println(filename+ " "+fromUser+ " "+toUser+ ""+getComments);
    		
    		FileImplementation forCheckingDetails=new FileImplementation();
    		String asn_fname=filename.concat(".txt");
    		File file = new File(asn_fname);
    		/*forCheckingDetails.setFileId(tfid);
    		forCheckingDetails.setComm(comm);
    		forCheckingDetails.setFileForwardBy(name);
    		forCheckingDetails.setFileName(tfname);
    		forCheckingDetails.setLastModificationTime(new java.sql.Timestamp(System.currentTimeMillis()) );*/
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
    		//out.close();
    		
    		FileReader freader=new FileReader(file);
    	
    		String fwdTask="update taskfile set toemp=? where tfname=? and toemp=? ";
    		try
    		{
    			
    			/*ps=con.prepareStatement(fwdTask);
    			ps.setString(1,toUser);
    			ps.setString(2, tfname);
    			ps.setString(3, name);
    			rs=ps.executeQuery();*/
    			
    			
    		}
    		catch(Exception e)
    		{
    			System.out.print("Caught some: "+e);
    			//out.print(e);
    		}
    	
    	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		doGet(request, response);
	}

}
