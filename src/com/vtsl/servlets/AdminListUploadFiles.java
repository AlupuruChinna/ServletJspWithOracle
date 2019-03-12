package com.vtsl.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vtsl.dbconnection.DBConnect;

@WebServlet("/AdminListUploadFiles")
public class AdminListUploadFiles extends HttpServlet {
   
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session=request.getSession();
        String name=(String)session.getAttribute("name");
        session.setAttribute("name",name);
        
        PrintWriter out = response.getWriter();
        try {
            
            Connection con = DBConnect.getLocalDBConnection();
            PreparedStatement ps = con.prepareStatement("select afile_id,file_name,upload_file,afname_ref from adminuploads where afname_ref='"+name+"'" );
            ResultSet rs = ps.executeQuery();
            out.println("<h3>List Of Files</h3>");
            while ( rs.next()) 
            {
            	out.print("<head>"
            			+ "<style>"
            			+ "table { border-collapse: collapse; width: 70%;}"
            			+ "th, td {text-align: left;padding: 8px;}"
            			+ "tr:nth-child(even){background-color: #f2f2f2}"
            			+ "</style></head><body>"
            			+ "<div style='overflow-x:auto;'>"
            			+ "<table><tr><th>ID</th><th>File Name</th><th>File Image or Text</th><th>User</th></tr>"
            			+ "<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td><img width='35' height='35' src='AdminShowFiles?file_id=" +rs.getString(1).toString()+ "'></img></td><td>"+rs.getString(4)+"</td><td></tr></table>"
            			);
              //  out.println("<h4>" + rs.getString(3) + "</h4>");
                //out.println("<img width='4' height='4' src=ShowFiles?id=" +  rs.getString(1) + "></img> <p/>");
            		
            		ps.close();
            		rs.close();
            		ps = con.prepareStatement("select file_id,file_name,upload_file,fname_ref from useruploads" );
                    rs = ps.executeQuery();
                    out.println("<h3>List Of Files</h3>");
                    while ( rs.next()) 
                    {
                    	out.print("<head>"
                    			+ "<style>"
                    			+ "table { border-collapse: collapse; width: 70%;}"
                    			+ "th, td {text-align: left;padding: 8px;}"
                    			+ "tr:nth-child(even){background-color: #f2f2f2}"
                    			+ "</style></head><body>"
                    			+ "<div style='overflow-x:auto;'>"
                    			+ "<table><tr><th>ID</th><th>File Name</th><th>File Image or Text</th><th>User</th></tr>"
                    			+ "<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td><img width='35' height='35' src='ShowFiles?file_id=" +rs.getString(1)+ "'></img></td><td>"+rs.getString(4)+"</td><td></tr></table>"
                    			);
                      //  out.println("<h4>" + rs.getString(3) + "</h4>");
                        //out.println("<img width='4' height='4' src=ShowFiles?id=" +  rs.getString(1) + "></img> <p/>");
                    }
                    
                    response.sendRedirect("adminshowallfiles.jsp");
            }
            
            con.close();
            }
        catch(Exception ex) {

        }
        finally { 
            out.close();
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
}