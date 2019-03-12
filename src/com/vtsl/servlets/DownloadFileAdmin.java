package com.vtsl.servlets;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vtsl.dbconnection.DBConnect;
 
/**
 * A servlet that retrieves a file from MySQL database and lets the client
 * downloads the file.
 * @author www.codejava.net
 */
@WebServlet("/DownloadFileAdmin")
public class DownloadFileAdmin extends HttpServlet 
{
 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// size of byte buffer to send file
    private static final int BUFFER_SIZE = 4096;   
    Connection conn = null; // connection to the database
    Statement statement;
    ResultSet result ;
    String file_id;
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
    		response.setContentType("text/html");
        // get upload id from URL's parameters
        String uploadId = request.getParameter("filename");
         
        
        try {
            // connects to the database

            conn = DBConnect.getLocalDBConnection();
            System.out.println(" "+uploadId);
            // queries the database
            String getIdSQL="select afile_id from adminuploads where file_name="+uploadId;
            Statement st=conn.createStatement();
            result=st.executeQuery(getIdSQL);
            while (result.next()) 
            {
				file_id=result.getString(1);
				System.out.println("Entered");
			}
            
            
            String sql = "SELECT afile_id,upload_file FROM adminuploads WHERE afile_id =?";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, file_id);
            result = statement.executeQuery(sql);
            if (result.next()) {
                // gets file name and file blob data
                String fileName = result.getString("afile_id");
                Blob blob = result.getBlob("upload_file");
                InputStream inputStream = blob.getBinaryStream();
                int fileLength = inputStream.available();
                 
                System.out.println("fileLength = " + fileLength);
 
                ServletContext context = getServletContext();
 
                // sets MIME type for the file download
                String mimeType = context.getMimeType(fileName);
                if (mimeType == null) {        
                    mimeType = "application/octet-stream";
                }
                // set content properties and header attributes for the response
                response.setContentType(mimeType);
                response.setContentLength(fileLength);
                String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"%s\"", fileName);
                response.setHeader(headerKey, headerValue);
 
                // writes the file to the client
                OutputStream outStream = response.getOutputStream();
                 
                byte[] buffer = new byte[BUFFER_SIZE];
                int bytesRead = -1;
                 
                while ((bytesRead = inputStream.read(buffer)) != -1) 
                {
                    outStream.write(buffer, 0, bytesRead);
                }
                 
                //inputStream.close();
                //outStream.close();             
            } else 
            {
                // no file found
                response.getWriter().print("File not found for the id: " + uploadId);  
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.getWriter().print("Error: " + ex.getMessage());
        } catch (IOException ex) {
            ex.printStackTrace();
            response.getWriter().print("IO Error: " + ex.getMessage());
        }           
        }
            
}