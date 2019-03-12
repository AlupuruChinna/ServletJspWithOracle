<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!
	Connection con = DBConnect.getLocalDBConnection();
	ResultSet rs;
	PreparedStatement ps;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<title>Multiple Task Assign</title>
<style>
[type="date"] {
  background:#fff url(https://cdn1.iconfinder.com/data/icons/cc_mono_icon_set/blacks/16x16/calendar_2.png)  97% 50% no-repeat ;
}
[type="date"]::-webkit-inner-spin-button {
  display: none;
}
[type="date"]::-webkit-calendar-picker-indicator {
  opacity: 0;
}

/* custom styles */
/* body {
  padding: 4em;
  background: #e5e5e5;
  font: 13px/1.4 Geneva, 'Lucida Sans', 'Lucida Grande', 'Lucida Sans Unicode', Verdana, sans-serif;
} */
/* label {
  display: block;
} */
input {
  border: 1px solid #c4c4c4;
  border-radius: 5px;
  background-color: #fff;
  padding: 3px 5px;
  box-shadow: inset 0 3px 6px rgba(0,0,0,0.1);
  width: 190px;
}


.multiselect {
  width: 200px;
}

.selectBox {
  position: relative;
}

.selectBox select {
  width: 100%;
  font-weight: bold;
}

.overSelect {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
}

#checkboxes {
  display: none;
  border: 1px #dadada solid;
}

#checkboxes label {
  display: block;
}

#checkboxes label:hover {
  background-color: #1e90ff;
}
</style>
<script>


window.addEventListener('load', function () {

	  vanillacalendar.init();

	})

function checkAll(ele) {
     var checkboxes = document.getElementsByName('users');
     if (ele.checked) {
         for (var i = 0; i < checkboxes.length; i++) {
             if (checkboxes[i].type == 'checkbox') {
                 checkboxes[i].checked = true;
             }
         }
     } else {
         for (var i = 0; i < checkboxes.length; i++) {
             console.log(i)
             if (checkboxes[i].type == 'checkbox') {
                 checkboxes[i].checked = false;
             }
         }
     }
 }
 
 
 
var expanded = false;

function showCheckboxes() {
  var checkboxes = document.getElementById("checkboxes");
  if (!expanded) {
    checkboxes.style.display = "block";
    expanded = true;
  } else {
    checkboxes.style.display = "none";
    expanded = false;
  }
}
</script>




</head>
<body>
<form action="Mtaskaction" method="get">
<div class="w3-container w3-light-grey">
  <center><h2 style="text-shadow:1px 1px 0 #444">Assign Task to Multiple User</h2></center>
</div>

<select class="w3-select w3-border" name="option">
    <option value="" disabled selected>Choose File from Upload Files</option>
  	 <%
    try {
        ps = con.prepareStatement("select file_name from adminuploads" );
        rs = ps.executeQuery();
        while ( rs.next()) 
        {
        	
       %>
    		<option><%out.print(rs.getString(1)); %> </option>
    <%
    	}}
        catch(Exception e)
        {
        	out.print("Caught some Exception: " +e);
        	
        }
     %>
    
    
        <option value="" disabled selected>Choose from created Taskfiles</option>
  	 <%
    try {
        ps = con.prepareStatement("select tfname from taskfile" );
        rs = ps.executeQuery();
        while ( rs.next()) 
        {
        	
       %>
    		<option><%out.print(rs.getString(1)); %> </option>
    <%
    	}}
        catch(Exception e)
        {
        	out.print("Caught some Exception: " +e);
        	
        }
     %>
    
  </select>
  <p>
  <div class="multiselect">
    <div class="selectBox" onclick="showCheckboxes()">
      <select>
        <option>Select users from list</option>
      </select>
      <div class="overSelect"></div>
    </div>
    <div id="checkboxes" name="users">
      
        
  <%
  	ps = con.prepareStatement("select count(*) from userdata" );
  	rs = ps.executeQuery();
  	while ( rs.next()) 
  	{
  		int len=rs.getInt(1);
  		ps=con.prepareStatement("select fname from userdata");
  		rs=ps.executeQuery();
  		int count=1;
  		while(rs.next())
  		{
  			if(count<=len)
  			{
  				%>
  				<input class="w3-check" type="checkbox" name="users" id="users" value="<%out.print(rs.getString(1));%>"> <%out.print(rs.getString(1));%><br/>
  				
  				<%	
  			}
  			count++;
 		}
  		%>
			<hr><input class="w3-check" type="checkbox" onclick="checkAll(this);">SelectAll
  	
  		<%
  	}
  	
  %>
    </div>
  </div>
  </p>
  
  
	<label for="dateofbirth">Date</label>
	<input type="date" name="date" id="date">
	
	<p>  
  	<label>Comment/Description</label>
  	<input class="w3-input" type="text" name="comm"></p>
  
  <p><button class="w3-btn w3-teal">Assign</button></p>
</form>		

</body>
