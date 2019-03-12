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
<title>File Delete </title>

<style>
/* th {
    background-color: #4CAF50;
    color: white;
} */

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
%>
<body>
	Choose File For delete:
	
	<%
		
		String curUser=(String)session.getAttribute("name");
		try
		{
			con=DBConnect.getLocalDBConnection();
			stmt=con.createStatement();
			rs= stmt.executeQuery("select file_name,upload_file from useruploads where fname_ref = '"+curUser+"'");
		}
		catch(Exception e)
		{
			System.out.print("Caught some: "+e);
		}
%>
  <table class="w3-container" id="rounded-corner" summary="all posts">

     <tbody>
      <tr>
        	<th>File Name</th>
        	<th>For Delete</th>
        	<th>For Download</th>
        </tr>
        <% while (rs.next()) {
             String filename = rs.getString(1);
        %>
        
         <tr>
             <td>
                <%=rs.getString(1)%>
             </td>
             
             <td>

                 <a href ="delaction.jsp?deleteid=<%=filename%>">Delete</a>
              </td>
              <td>

                 <a href ="downaction.jsp?downid=<%=filename%>">Download</a>
              
                 
              </td>
              
              <td>

                  <a href ="ushowfiles.jsp?id=<%=filename%>">ShowFile</a>
              </td>
              
          </tr>
          <%}%>

        </tbody>
     </table>
</body>
</html>