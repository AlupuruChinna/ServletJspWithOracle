<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="changepwd.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Actions</title>
</head>
<body>
		<%!
			//Connection con;
			PreparedStatement ps;
			ResultSet rs;
			String pwd1,pwd2,name,oldpwd;
		%>


		<%
			name=(String)session.getAttribute("name");
			oldpwd=request.getParameter("oldpwd");
			pwd1=request.getParameter("pwd1");
			pwd2=request.getParameter("pwd2");
			
			if(!(pwd1.equals(pwd2)))
			{
				out.println("<h2>Your password has mismatched</h2>");
			}
			try
			{
				
				Statement st= DBConnect.getLocalDBConnection().createStatement();
				ResultSet rs=st.executeQuery("select password from admindata where afname='"+name+"'");
				//System.out.print(name);
				while(rs.next())
				{
					String pwd=rs.getString(1);
					if(!(pwd.equals(oldpwd)))
					{
						out.print("<h2>Your old password doesn't matched</h2>");
						
					}
					else
					{
						
						ps=DBConnect.getLocalDBConnection().prepareStatement("update admindata set password=? where afname=?");
						ps.setString(1,pwd1);
						ps.setString(2,name);
						ps.executeUpdate();
						out.print("<h2>Your passwordhasbeen changed Successfully</h2>");
						session.invalidate();
						out.print("<h2>Please Login with new password.. Pls logout</h2>");
						//out.print("<meta http-equiv='Refresh' content='8;url=index.html'>");
			/* 			response.setHeader("Refresh", "3");
						out.print("<a href='logout.jsp'>Logout</a>");
			 */			}
						ps.close();
					}
				
			}
			catch(Exception e)
			{
				out.print("Caught some :" +e);	
			}
			
		%>
</body>
</html>