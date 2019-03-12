<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
    <%!

	Connection con = DBConnect.getLocalDBConnection();
	ResultSet rs;
	PreparedStatement ps;
	
%>
<%
	String name=(String)session.getAttribute("name");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Task Assign Form</title>
</head>
<body>

	<form class="w3-container w3-card-4" action="assigntaskaction.jsp">
  <h4>Assign a task to your employee</h4>

  <select class="w3-select" name="selectuser">
    <option value="" disabled selected>Select User</option>
    <%
    try {
        ps = con.prepareStatement("select fname from userdata" );
        rs = ps.executeQuery();
        while ( rs.next()) 
        {
        	
       %>
    		<option><%out.print(rs.getString(1)); %> </option>
    <%
    	}}
        catch(Exception e)
        {
        	out.print("Caught some Exception: " +e);
        	
        }
     %>
    
  </select>
  
  
  <select class="w3-select" name="selectfile">
    <option value="" disabled selected>Select from Uploaded Files</option>
    <%
    try {
        ps = con.prepareStatement("select file_name from adminuploads" );
        rs = ps.executeQuery();
        while ( rs.next()) 
        {
        	
       %>
    		<option><%out.print(rs.getString(1)); %></option>
    <%
    	}}
        catch(Exception e)
        {
        	out.print("Caught some Exception: " +e);
        }
     %>
     <option value="" disabled selected>Select from Created TaskFiles</option>
    <%
    try {
        ps = con.prepareStatement("select tfname from taskfile" );
        rs = ps.executeQuery();
        while ( rs.next()) 
        {
        	
       %>
    		<option><%out.print(rs.getString(1)); %></option>
    <%
    	}}
        catch(Exception e)
        {
        	out.print("Caught some Exception: " +e);
        }
     %>
    
  </select>
  
  <label>Comment/Description</label>
  <input class="w3-input" type="text" name="comm"></p>
  
<p><button class="w3-btn w3-teal">Assign</button></p>
</form>
		
		
</body>
</html>