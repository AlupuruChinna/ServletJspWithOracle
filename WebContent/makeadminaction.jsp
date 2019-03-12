
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%!

	Connection con;
	ResultSet rs;
	Statement stmt;
	PreparedStatement ps;
	String afname,asname,email,password,gender;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make a user as admin</title>
</head>
<body>

<%
		
		String curUser=(String)session.getAttribute("name");
		String selectedUser=request.getParameter("username");
		
		String deleteSql="select fname,sname,email,password,gender from userdata where fname=? ";
		try
		{
			con=DBConnect.getLocalDBConnection();
			ps=con.prepareStatement(deleteSql);
			ps.setString(1,selectedUser);
			rs=ps.executeQuery();
			while(rs.next())
			{
				afname=rs.getString(1);
				asname=rs.getString(2);
				email=rs.getString(3);
				password=rs.getString(4);
				gender=rs.getString(5);
			}
			
			rs.close();
			ps.close();
			
			String setAdminSQL="insert into admindata values(?,?,?,?,?)";
			ps=con.prepareStatement(setAdminSQL);
			ps.setString(1, afname);
			ps.setString(2, asname);
			ps.setString(3, email);
			ps.setString(4, password);
			ps.setString(5, gender);
			ps.executeUpdate();
			
			
			String deleteSql2="delete from userdata where fname=? ";
			ps=con.prepareStatement(deleteSql2);
			ps.setString(1, selectedUser);
			ps.executeUpdate();
			
			out.println("<html><head></style><script src='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js'></script><script src='//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script><link href='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet' id='bootstrap-css'></head>"
					+ "<body><h2>successfully assigned</h2></body>");
			out.print("<h3> Set :" +selectedUser+" as Admin Successfully </h3>");
			out.print("<h5><a href='makeadmin.jsp'>Back</h5></html?");
		}
		catch(Exception e)
		{
			System.out.print("Caught some: "+e);
			out.print(e);
		}
%>
<%
    
%>
</body>
</html>