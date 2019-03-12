<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
   
<%System.out.print(session.getAttribute("name")); %>
        <%!
        	String fname,sname,email,gender,pwd1;
        	
        %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Profile </title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<style>
	.container{
    padding:5%;
}
.container .img{
    text-align:center;
}
.container .details{
    border-left:3px solid #ded4da;
}
.container .details p{
    font-size:15px;
    font-weight:bold;
}

</style>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</head>


<body>
        <%
       	
		String pwd=request.getParameter("pwd");
        String c=(String)session.getAttribute("name");
        //System.out.print("Get name" +c);
		session.setAttribute("pwd", pwd);
//		System.out.print(pwd);
		try
		{
		Connection con=DBConnect.getLocalDBConnection();
		Statement st=con.createStatement();
		session.getAttribute("pwd");
		ResultSet rs=st.executeQuery("select afname,asname,email,gender,password from admindata where password='"+pwd+"'");
		
		while(rs.next())
		{
			//System.out.print("Entered loop");
			String pwd1=rs.getString(5);
			fname=rs.getString(1);
			
			sname=rs.getString(2);
			email=rs.getString(3);
			gender=rs.getString(4);
			//System.out.print(pwd1+""+pwd+ " "+fname);
			if(fname.equals(c) & pwd1.equals(pwd))
			{
				out.println("<h3>Admin personal profile is :</h3>");
				out.println("<h2 rifhtframe.src='about:blank'");
				%>
				<div class="container">
  <div class="row">
    <div class="col-md-6 img">
      <img src=download.png  alt="" class="img-rounded">
    </div>
    <div class="col-md-6 details">
      <blockquote>
        <h5>
       </h5>
         <small><cite title="Source Title">Hyderabad, India  <i class="icon-map-marker"></i></cite></small>
      </blockquote>
      <p>
        <b><%out.print(fname+" "+sname ); %></b> <br>
        <b><%out.print(gender);%></b> <br>
        <b><%out.print(email);%></b><br>
        www.VerinonTechnologySolution.com <br>
        Oct 26, 2018
      </p>
    </div>
  </div>
</div>
				<%
			}
		}
		if(!(pwd.equals(pwd1)))
		{
			//System.out.print("Entered not equal - true");
			out.print("<h2>plese enter ur validate password</h2>");
			out.print("<h2><a href='userabout1.jsp' target='leftframe' rightframe.src='about:blank'>LeftPanel</a></h2>");
		}
		}
	//while and tryand try
		catch(Exception e)
		{
			out.print("Caught some exception :" +e);
		}
		
			
	%>    	
	



</body>
</html>

