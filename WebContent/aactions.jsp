<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%-- <jsp:include page="loginpage.jsp"></jsp:include> --%>
<%System.out.print(session.getAttribute("name")); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Actions</title>

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
  
  <li><a href="adduser.jsp" target="rightframe">Add User</a></li>&nbsp;
  <li><a href="removeuser.jsp" target="rightframe">RemoveUser</a></li>
  <li><a href="achangepwd.jsp" target="rightframe">ChangePassword</a></li>
  <li><a href="achangemail.jsp" target="rightframe">ChangeMailID</a></li>
  <li><a href="taskassign.jsp" target="rightframe">AssignTask</a></li>
  <li><a href="adminfileupload.jsp" target="rightframe">FileUpload</a></li>
  <li><a href="adminfiledelete.jsp" target="rightframe">FileDelete</a></li>
  <li><a href="makeadmin.jsp" target="rightframe">Make Admin</a></li>
  <li><a href="AdminListUploadFiles" target="rightframe">ShowAllFiles</a></li>
  </h5>
</ul>

		
</div>
</body>
</html>