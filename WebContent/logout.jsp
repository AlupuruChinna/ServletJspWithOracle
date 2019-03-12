<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    	System.out.print(session.getAttribute("name"));
    	session.setAttribute("name", null);
    	request.getSession().invalidate();
    	
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logout </title>

<SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() 
	{ window.history.forward(); }
</SCRIPT>
</HEAD>

</head>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
	
	
	<h2>Successfully logged out</h2>
	<!-- <h5><a href="index.html">Click For Login Again</a></h5> -->
	
	<%
		
		//request.getSession(true).removeValue("name");
		//System.out.print(request.getAttribute("name"));
		//session.setAttribute("name", null);
    	//request.getSession(false).invalidate();
    	
	 	out.print("<script>parent.location.href='index.html'</script> "); 
	 	//System.out.print(request.getAttribute("name"));								
		//response.sendRedirect(request.getContextPath() +"/index.html");
	
		 
    //request.getRequestDispatcher("index.html").forward(request, response);
    	
	%>
</body>
</html>