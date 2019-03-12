<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%-- <jsp:include page="loginpage.jsp"></jsp:include> --%>
<%System.out.print(session.getAttribute("name")); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Inbox</title>

<style>
body
{
	margin: 0;
	background-image: url("");	
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
    font-size:medium;
    font-stretch: wider;
    box-sizing: content-box;
}

li {
    float: left;
    margin-left: 0%;
}

li a {
    display: block;
    color: white;
    text-align: justify;
    padding: 19px 20px;
    text-decoration: none;
    box-shadow: blue;
    position: relative;
    
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
    size: 1in;
}

.w3-myfont {
  font-family: "Comic Sans MS", cursive, sans-serif;
  font-stretch: wider;
  color: blue;
}

</style>


</head>

<body>
		
<ul>
  <h5 class="w3-myfont" align="left">
  
  <li><a href="ainbox1.jsp" target="rightframe">Inbox</a></li>&nbsp;
  <li><a href="adminuploadfiles.jsp" target="rightframe">AdminUploads</a></li>
  <li><a href="taskassign.jsp" target="rightframe">Task Assign</a></li>
  <li><a href="multipleassigntask.jsp" target="rightframe">TA Multiple</a></li>
  <li><a href="viewrequests.jsp" target="rightframe">ViewRequests</a></li>
  <li><a href="createtask.jsp" target="rightframe">NewTask</a></li>
  </h5>
</ul>

		
</div>
</body>
</html>