<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%!

	Connection con;
	ResultSet rs;
	PreparedStatement ps;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make User As Admin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

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
<body>
        	<div class="w3-container">
        	  <h2>SelectUser</h2>
        	  <p>Choose the user to set an Admin :</p>

        	  <table class="w3-table w3-bordered">
        	    <tr>
        	      <th>UserName</th>
        	      <th>mail</th>
        	      <th>gender</th>
        	      <th>MakeAdmin</th>
        	      
        	    </tr>

    <%
    try {
        
        con = DBConnect.getLocalDBConnection();
        ps = con.prepareStatement("select fname,email,gender from userdata" );
        rs = ps.executeQuery();
        while ( rs.next()) 
        {
        	    
        %>	    <tr>
        	      <td><%out.print(rs.getString(1)); %></td>
        	      <td><%out.print(rs.getString(2)); %></td>
        	      <td><%out.print(rs.getString(3)); %></td>
        	      <td><a href="makeadminaction.jsp?username=<%=rs.getString(1)%>">SetAsAdmin</a></td>
        	    </tr>
        	         	
        <%      
        }

    }
    catch(Exception ex) 
    {
		out.print("Caught SomeException: "+ex);
    }
    %>	
</table>
</div>
</body> 
</html>
		
