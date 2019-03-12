<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%-- <jsp:include page="loginpage.jsp"></jsp:include> --%>
<%System.out.print(session.getAttribute("name")); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Actions</title>

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
		<%
	request.getSession();
	String name=(String)session.getAttribute("name");
	session.setAttribute("name", name);

%>
<ul>
  <h5 class="w3-myfont" align="left">
  
  <li><a href="fileup.jsp" target="rightframe">UploadFile</a></li>&nbsp;
  <li><a href="filedelete.jsp" target="rightframe">DeleteFile</a></li>
  <li><a href="changepwd.jsp" target="rightframe">ChangePassword</a></li>
  <li><a href="changemail.jsp" target="rightframe">ChangeMailID</a></li>
  <li><a href="createtask.jsp" target="rightframe">CreateTask</a></li>
  <li><a href="usercreatetask.jsp" target="rightframe">TaskAssign</a></li>
  <li><a href="forwardtask.jsp" target="rightframe">ForwardTask</a></li>
  </h5>
</ul>

		
</div>
</body>
</html>