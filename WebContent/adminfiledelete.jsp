<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>FileDelete</title>
<style>
a:link {
    color: green;
}

/* visited link */
a:visited {
    color: green;
}

/* mouse over link */
a:hover {
    color: red;
}

/* selected link */
a:active {
    color: yellow;
}
</style>
</head>
<%!

Connection con;
ResultSet rs;
Statement stmt;
String filename;
String id;
%>
<body>
	Choose File For delete:
	
	<%
		
		String curUser=(String)session.getAttribute("name");
		try
		{
			con=DBConnect.getLocalDBConnection();
			stmt=con.createStatement();
			rs= stmt.executeQuery("select afile_id,file_name,upload_file from adminuploads where afname_ref = '"+curUser+"'");
		}
		catch(Exception e)
		{
			System.out.print("Caught some: "+e);
		}
%>
  <table class="w3-container w3-bordered" id="rounded-corner" summary="all posts">

     <tbody>
      <tr>
        	<th>File Name</th>
        	<th>For Delete</th>
        	<th>For Download</th>
        </tr>
        <% while (rs.next()) {
             filename = rs.getString("file_name");
             int id=rs.getInt(1);
             //session.setAttribute("id", id);
        %>
        
         <tr>
             <td>
                <%=rs.getString("file_name")%>
             </td>
             
             <td>

                 <a href ="admindelaction.jsp?deleteid=<%=filename%>">Delete</a>
              </td>
              <td>

                 <a href ="admindownaction.jsp?downid=<%=filename%>">Download</a>
              
                 
              </td>
              
              <td>

                 <a href ="showfile.jsp?id=<%=filename%>">ShowFile</a>
              </td>
      
          </tr>
          <%}%>

        </tbody>
     </table>
</body>
</html>