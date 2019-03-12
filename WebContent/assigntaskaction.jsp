<%@page import="java.sql.Statement"%>
<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
      <%!

		Connection con = DBConnect.getLocalDBConnection();
		ResultSet rs;
		PreparedStatement ps;
		String touser,asn_admin,asn_fname,comm_desc;
		Statement stmt;
	%>
	<%
		//String name=(String)session.getAttribute("name");
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AssignTaskAction</title>
</head>
<body>
		<%
		 try
		   {
			 	
		       
		       con=DBConnect.getLocalDBConnection();
		       asn_fname=request.getParameter("selectfile");
		       touser=request.getParameter("selectuser");
		       comm_desc=request.getParameter("comm");
		       asn_admin=(String)session.getAttribute("name");
		       
		       String query="insert into assigntask values(?,?,?,?,?,?)";
		       ps=con.prepareStatement(query);
		       ps.setString(1, touser);
		       ps.setString(2, asn_fname);
		       ps.setString(3, asn_admin);
		       ps.setString(4, comm_desc);
		       ps.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
		       ps.setString(6, "assigned");
		       ps.executeUpdate();
		       
		       out.println("<head></style><script src='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js'></script><script src='//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script><link href='//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet' id='bootstrap-css'></head>"
						+ "<body><h2>successfully assigned</h2></body>");
		       response.sendRedirect("Thankyou.jsp");
		   }
		catch(Exception e)
		{
			out.print("Caught some exception :"+e);
		}
		
		%>
</body>
</html>