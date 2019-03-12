
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete File</title>
</head>
<body>


<%
		
		String curUser=(String)session.getAttribute("name");
		String delRecord=request.getParameter("deleteid");
		System.out.print(curUser+ " " +delRecord);
		String deleteSql="delete from useruploads where file_name=? ";
		try
		{
			con=DBConnect.getLocalDBConnection();
			ps=con.prepareStatement(deleteSql);
			ps.setString(1, delRecord);
			ps.executeUpdate();
			out.print("<h4> File Deleted Successfully  :" +delRecord+"</h4>");
			out.print("<h5><a href='filedelete.jsp'>Back</h5>");
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