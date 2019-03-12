<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%System.out.print(session.getAttribute("name")); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
    font-family: Arial;
}

* {
    box-sizing: border-box;
}

form.example input[type=text] {
    padding: 10px;
    font-size: 17px;
    border: 1px solid grey;
    float: left;
    width: 50%;
    background: #f1f1f1;
}

form.example button {
    float: left;
    width: 30%;
    padding: 0px;
    background: #2196F3;
    color: white;
    font-size: 17px;
    border: 1px solid grey;
    border-left: none;
    cursor: pointer;
}

form.example button:hover {
    background: #0b7dda;
}

form.example::after {
    content: "";
    clear: both;
    display: table;
}
</style>
<title>Security</title>
</head>
<body>
	<h4>For Security Reason Enter ur file_name</h4>
	<!-- <form action="userabout.jsp" target="rightframe" method="post">
	Enter Password:<input type="password" name="pwd">
	<input type="submit" value="Go">
	</form> -->
	
	<form class="example" action="admindownaction.jsp" style="margin:auto;max-width:200px" target="rightframe" method="post">
  <input type="password" placeholder="password.." name="downid">
  <button type="submit"><i class="fa fa-search"></i></button>
</form>
	
</body>
</html>