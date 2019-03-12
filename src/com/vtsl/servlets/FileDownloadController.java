package com.vtsl.servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vtsl.dbconnection.DBConnect;


@WebServlet("/FileDownloadController")
public class FileDownloadController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
	private static final int BUFFER_SIZE = 6096;   
	int bytesRead = 0;
     
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // get upload id from URL's parameters
        String fname=request.getParameter("id");
       // response.setContentType("application/octet-stream");
        Connection con = null; // connection to the database
         
        try {
            // connects to the database
        	
        	con=DBConnect.getLocalDBConnection();
            // queries the database
            String sql = "SELECT afile_id,file_name,upload_file FROM adminuploads WHERE file_name = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, fname);
            
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                // gets file name and file blob data
            	
                String fileName = result.getString("file_name");
                Blob blob = result.getBlob(3);
                InputStream inputStream = blob.getBinaryStream();
                int fileLength = inputStream.available();
                 
                System.out.println("fileLength = " + fileLength);
 
                ServletContext context = getServletContext();
 
                // sets MIME type for the file download
                String mimeType = context.getMimeType(fileName);
                              
                 
                // set content properties and header attributes for the response
                response.setContentType(mimeType);
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
                response.setContentLength(fileLength);
                /*String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"" +fileName+ "\"");
                response.setHeader(headerKey, headerValue);
 */
                // writes the file to the client
                OutputStream outStream = response.getOutputStream();
                 
                byte[] buffer = new byte[BUFFER_SIZE];
                bytesRead = 0;
                 
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outStream.write(buffer);
                }
                 
                inputStream.close();
                outStream.close();             
            } else {
                // no file found
                response.getWriter().print("File not found for the filename: " + fname);  
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.getWriter().print("SQL Error: " + ex.getMessage());
        } catch (IOException ex) {
            ex.printStackTrace();
            response.getWriter().print("IO Error: " + ex.getMessage());
        } finally {
            if (con != null) {
                // closes the database connection
                try {
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }          
        }
    }	
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
