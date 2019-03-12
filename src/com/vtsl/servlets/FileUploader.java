package com.vtsl.servlets;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.vtsl.beans.Userbean;
import com.vtsl.dbconnection.DBConnect;

@WebServlet("/FileUploader")
public class FileUploader extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            // Apache Commons-Fileupload library classes
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload sfu  = new ServletFileUpload(factory);

            if (! ServletFileUpload.isMultipartContent(request)) {
                System.out.println("sorry. No file uploaded");
                return;
            }

            // parse request
            List items = sfu.parseRequest(request);
            FileItem  id = (FileItem) items.get(0);
            String fileid =  id.getString();
            
            FileItem title = (FileItem) items.get(1);
            String   filename =  title.getString();

            // get uploaded file
            FileItem file = (FileItem) items.get(2);
                        
            //FileItem fname = (FileItem) items.get(3);
           // String   username =  fname.getString().toLowerCase();
            HttpSession session=request.getSession();
            String username=(String)session.getAttribute("name");
            //System.out.println(username+ "printrd in fileupload");
            //username=fname.getString();
            // Connect to Oracle
           Connection con=DBConnect.getLocalDBConnection();
           	Userbean u= new Userbean();
            PreparedStatement ps = con.prepareStatement("insert into useruploads values(?,?,?,?)");
            ps.setString(1, fileid);
            ps.setString(2, filename);
            // size must be converted to int otherwise it results in error
            ps.setBinaryStream(3, file.getInputStream(), (int) file.getSize());
            ps.setString(4,username);
            ps.executeUpdate();
            con.commit();
            con.close();
            out.println("<html><head><link href='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet' id='bootstrap-css'>"
					+ "<body><h2>File Added Successfully. <p> <a href='ListUploadFiles'>ShowFiles </a></h2></body></html>");
            
            System.out.println(u.getFname());
        }
        catch(Exception ex) {
            out.println( "Error --> " + ex.getMessage());
        }
    } 
}