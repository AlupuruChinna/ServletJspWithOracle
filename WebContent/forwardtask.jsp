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
	String filename,toUser,fromUser;
	
%>
<%
	String name=(String)session.getAttribute("name");
	session.setAttribute("name", name);
	String filename=request.getParameter("file_name");	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Response</title>
</head>
<body>

	<form class="w3-container w3-card-4" action="FwdTask">
  <h4>Respond about your task: Forward Section</h4>
	<%System.out.print(request.getParameter("file_name")); %>
  <select class="w3-select" name="selectfile">
    <option value="<%request.getParameter("file_name"); %>" disabled selected><%out.print(request.getParameter("file_name")); %> or (Choose File)</option>
    <%
    try {
        
        ps=con.prepareStatement("select asn_fname from assigntask where touser=?");
        ps.setString(1, name);
        ResultSet rs=ps.executeQuery();
        while ( rs.next()) 
        {
        	filename=rs.getString(1);
        	session.setAttribute("filename", filename);
       %>
    		<option><%out.print(rs.getString(1)); %> </option>
    <%
    	}}
        catch(Exception e)
        {
        	out.print("Caught some Exception: " +e);
        	
        }
     %>
     <option value="<%request.getParameter("file_name"); %>" disabled selected><%out.print(request.getParameter("file_name")); %> or (Choose new File)</option>
    <%
    try {
        //ps = con.prepareStatement(",userdata where userdata.fname=taskfile.toemp" );
        ps=con.prepareStatement("select tfname from taskfile where toemp=?");
        ps.setString(1, name);
        rs = ps.executeQuery();
        while ( rs.next()) 
        {
        	
       %>
    		<option><%out.print(rs.getString(1)); %> </option>
    <%
    	ps.executeUpdate();
    	}}
        catch(Exception e)
        {
        	out.print("Caught some Exception: " +e);
        	
        }
     %>
  </select>
  
  
  <select class="w3-select" name="selectuser">
    <option value="" disabled selected>Select Employee to Forward</option>
    		<%
    try {
        ps = con.prepareStatement("select fname from userdata" );
        rs = ps.executeQuery();
        while ( rs.next()) 
        {
        	toUser=rs.getString(1);
        	//session.setAttribute("toUser", toUser);
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
  
  <label>Please send some words regarding task</label>
  <input class="w3-input" type="text" name="comm"></p>
  
<p><button class="w3-btn w3-teal">Forward</button></p>
</form>
		
		
</body>
</html>