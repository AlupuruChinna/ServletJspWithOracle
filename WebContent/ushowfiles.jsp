<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.io.File"%>
<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="application/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%!
	Connection con;
	Statement st;
	String downRecord,id;
	File file;
	
	PreparedStatement ps;
	ResultSet rs;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="application/html; charset=ISO-8859-1">
<title>Download File</title>
</head>
<body>


<%
try {
	response.setContentType("application/pdf");
    con = DBConnect.getLocalDBConnection();
	Statement st = con.createStatement();
	String id = request.getParameter("downid");
    
	String sql="select * from useruploads where file_name='"+downRecord+"'";
    rs=st.executeQuery(sql);
    
    System.out.print("Entered" +id);
    while(rs.next()) 
    {
    	//response.setContentType("APPLICATION/OCTET-STREAM");
    	Blob blob = rs.getBlob("upload_file");
    	File file=new File(rs.getString("file_name"));
    	System.out.print("file name " +file);
   		InputStream is=rs.getBinaryStream(3);
   		OutputStream os=response.getOutputStream();
   		byte[] buffer = new byte[(int)blob.length()];
   		int r = 0;
   		while((r = is.read(buffer))!=-1) 
   		{
   			System.out.print("Entered read byte by byte");
      		os.write(buffer);

		}
   		os.flush();
   		is.close();
   		os.close();
   	
    }
    st.close();
    rs.close();
   // con.close();
}

catch(Exception e)
{
	out.print("Caught Some:" +e);	
}
%>

</body>
</html>