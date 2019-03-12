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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>NewTask</title>
<script>

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
<center><h4>Create A New Task</h4></center>
		
		<form action="CreateTaskAction">
		
		<label>Enter TaskFile ID:</label>
		<input class="w3-input" type="text" name="fid" placeholder="Enter file id " required></p>
		
		<label>Enter TaskFile Name:</label>
		<input class="w3-input" type="text" name="fname" placeholder="Enter Filename" required></p>
		
		<select class="w3-select" name="user">
		<label>Task for:</label>
    	<option value="" disabled selected>Select Employee</option>
  	 <%
    try {
        ps = con.prepareStatement("select fname from userdata" );
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
        <option>Choose employees</option>
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
			<hr><input class="w3-check" type="checkbox" onclick="checkAll(this);">SelectAll</hr>
  	
  		<%
  	}
  	
  %>
    </div>
  </div>
  </p>
  	<label>Comments:</label>
		<input class="w3-input" type="text" name="comm" placeholder="place the commments here" required></p>
		
		
		<p><button class="w3-btn w3-green">Create</button> <button class="w3-btn w3-green" type="reset">Cancel</button></p>
		</form>
		
		<p><strong>Note:</strong> After created task you can also assign this task to any employee for that
				you can use <strong>TaskAssign</strong> or <strong>TA Multiple</strong> in <strong><b><i>INBOX</i> </b></strong> section.
		</p>
		
		
</body>
</html>