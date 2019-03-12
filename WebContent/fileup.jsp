<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>FileUpload</title>

<style>

<style>
th {
    background-color: #4CAF50;
    color: white;
}

.w3-button {width:150px;}

a:link {
    color: green;
}

/* visited link */
a:visited {
    color: green;
}

/* mouse over link */
a:hover {
    color: red;
}

/* selected link */
a:active {
    color: yellow;
} 
</style>
</style>
</head>
<body>
<% System.out.print(session.getAttribute("name")); %>
<form id="form1" enctype="multipart/form-data" action="FileUploader" method="post">
            <table class="w3-container">
                <tr>
                    <td>Enter File Id :</td>
                    <td><input  type="text"  name="id" placeholder="please Enter numbers only:"/></td>
                </tr>
                <tr>
                    <td>Enter Title For File :</td>
                    <td><input  type="text"  name="title"/></td>
                </tr>
                <tr>
                    <td>Select File  </td>
                    <td><input type="file"  name="photo" />
                </tr>
                
              <!--   <tr>
                    <td>Enter your Fname  </td>
                    <td><input type="text"  name="fname" />
                </tr> -->
            </table>
            <p/>
            <input type="submit" value="Upload" class="w3-button w3-light-blue"/>
        </form>

        <p/>
        <a href="ListUploadFiles">List of FIles </a>	
		
		
</body>
</html>