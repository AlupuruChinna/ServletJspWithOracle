<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
   String result;
   String to = request.getParameter("mail");
   String from = "Chinna.alupuru@verinon.co.in";
   String host = "localhost";
   Properties properties = System.getProperties();
   properties.setProperty("mail.smtp.host", host);
   /* properties.setProperty("user.mail", "chantychinna143@gmail.com");
   properties.setProperty("user.password", " ********* "); */
   Session mailSession = Session.getDefaultInstance(properties,null);
   try{
      MimeMessage message = new MimeMessage(mailSession);
      message.setFrom(new InternetAddress(from));
      message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
      message.setSubject("Query/Information");
      message.setText(request.getParameter("subject"));
      Transport.send(message);
      result = "Sent message successfully....";
   }catch (MessagingException mex) {
      mex.printStackTrace();
      result = "Error: unable to send message....";
   }
%>
<html>
   <head>
      <title>Send Email using JSP</title>
   </head>
   
   
   <!-- for storing in DB -->
   <%
   		
   	try
   	{
   		String name=request.getParameter("name");
   		String mail=request.getParameter("mail");
   		Connection con=DBConnect.getLocalDBConnection();
		Statement st=con.createStatement();
		ResultSet rs=st.executeQuery("select fname,email from userdata where fname='"+name+"'");
		
		while(rs.next())
		{
		if(rs.getString(1).equals(name))
		{
   			PreparedStatement ps=con.prepareStatement("insert into contactus values(?,?,?,?)");
   			ps.setString(1, request.getParameter("name"));
   			ps.setString(2, request.getParameter("mail"));
   			ps.setString(3, request.getParameter("subject"));
   			ps.setTimestamp(4, new java.sql.Timestamp(System.currentTimeMillis()));
   			ps.executeUpdate();
   		//	out.print("Send Successfully and ur data stored in DB Successfully");
		}
		else
		{
			out.print("<h2>plese enter ur validate name</h2>");
			out.print("<h3> Ur data has not been stored in our database so please enter ur name as u mentioned in ur ID</h3>");
		}}
   	}
   catch(Exception e)
   {
	   out.print("Caught Exception "+e);
   }
   %>
   
   <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
	<link href='https://fonts.googleapis.com/css?family=Lato:300,400|Montserrat:700' rel='stylesheet' type='text/css'>
	<style>
		@import url(//cdnjs.cloudflare.com/ajax/libs/normalize/3.0.1/normalize.min.css);
		@import url(//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css);
	</style>
	<link rel="stylesheet" href="https://2-22-4-dot-lead-pages.appspot.com/static/lp918/min/default_thank_you.css">
	<script src="https://2-22-4-dot-lead-pages.appspot.com/static/lp918/min/jquery-1.9.1.min.js"></script>
	<script src="https://2-22-4-dot-lead-pages.appspot.com/static/lp918/min/html5shiv.js"></script>
</head>


	<html lang="en">

<body>
	<header class="site-header" id="header">
		<h1 class="site-header__title" data-lead-id="site-header-title">THANK YOU!</h1>
	</header>

	<div class="main-content">
		<i class="fa fa-check main-content__checkmark" id="checkmark"></i>
		<p class="main-content__body" data-lead-id="main-content-body">Your mail has been send Seccussfully.. Thankyou for contact us.</p>
	</div>

	<footer class="site-footer" id="footer">
		<p class="site-footer__fineprint" id="fineprint">Copyright ©2014 | All Rights Reserved</p>
	</footer>
</body>
</html>
</body>
</html>
</html>