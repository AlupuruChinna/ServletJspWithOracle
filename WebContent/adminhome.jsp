<%@page import="java.util.Currency"%>
<%@page import="java.util.Date"%>
<%@page import="javax.websocket.Session"%>
<%@page import="com.vtsl.beans.Userbean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
	<%
		String uname=(String)session.getAttribute("name");
		System.out.print(session.getAttribute("name"));
		if(session.getAttribute("name")==null)
		{
			out.print("<script>parent.location.href='adminlogin.jsp'</script>");
		}
		session.setAttribute("name", uname);
		
	%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>

.bg{
	width:100%;
	margin:auto;
	max-width:800px;
	min-height:1000px;
	position:relative;
	background:url(ForgetPwd.jpg) no-repeat center; 
	box-shadow:0 12px 15px 0 rgba(0,0,0,.24),0 17px 50px 0 rgba(0,0,0,.19);
}

ul {
    list-style-type: none;
    margin: auto;
    
    overflow: hidden;
    background-color: #333;
    position: relative;
    border-bottom-color: blue;
    width: auto;
    border-bottom-width: thick;
    font-size: large;
    font-stretch: wider;
    box-sizing: content-box;
}

li {
    float: left;
}

li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    box-shadow: fuchsia;
    position: static;
    
}

li a:hover:not(.active) {
    background-color: aqua;
}

.active {
    background-color: #4CAF50;
}

.lufont {
    font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
    box-shadow: aqua;
    size: 2in;
}

.container {
    padding: 06px;
    padding-left: 6in;
    
}

.dropdown {
    float: left;
    overflow: hidden;
}

.dropdown .dropbtn {
    font-size: 16px;    
    border: none;
    outline: none;
    color: white;
    padding: 14px 16px;
    background-color: inherit;
    font-family: inherit;
    margin: 0;
}

.dropdown:hover .dropbtn {
    background-color: red;
}

.w3-myfont {
  font-family: "Comic Sans MS", cursive, sans-serif;
  font-stretch: wider;
  color: black;
}
.h3
{
	padding-right: 50%;
	padding: 14px,20px;
	padding-left: 4in;

}


.h2
{
	padding-right: 50%;
	padding: 14px,20px;
	padding-left: 4in;

}

</style>
<script type="text/javascript">
var myVar=setInterval(function () {myTimer()}, 1000);
var counter = 0;
function myTimer() {
    var date = new Date();
    document.getElementById("timedemo").innerHTML = date.toISOString();
}
</script>
<title>Home Page</title>
</head>

<body><!-- <div class="bg"> -->
<%-- <%String aname=request.getParameter("aname"); %> --%>
<center>
	<h2>Welcome to VerinonTechnology Solution (Pvt) Ltd.<br> 
</center>
<pre><h5 align="left" id="timedemo"></h5></pre></h5><h3 class="w3-myfont" align="right">	Welcome to Admin: Mr. <%=uname %></h3>
<center></center>	
<p class="lufont"> 
<ul>
  <li><a href="userhomeslideshow.jsp" target="rightframe" selected>Home</a></li>
  <li><a href="ainbox.jsp" 		target="leftframe" >Inbox</a></li>
  <li><a href="aactions.jsp"	target="leftframe" >Actions</a></li>
  <li><a href="aabout1.jsp" 		target="leftframe" >Profile</a></li>
  <!-- <li><a href="contactus.jsp" target="rightframe">ContactUs</a></li> -->
  
  <li><a href="logout.jsp">Logout</a></li>

</ul></div>

</body>
</html>