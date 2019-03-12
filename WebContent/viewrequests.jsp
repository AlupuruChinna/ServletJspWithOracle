<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
p:link {
    color: green;
}

/* visited link */
p:visited {
    color: green;
}

/* mouse over link */
p:hover {
    color: red;
}

/* selected link */
p:active {
    color: yellow;
}

</style>
<body>

<h3><center>User Requests</center></h3>
<table border="2" class="w3-table-all w3-hoverable">
   <tr>
        <th>From </th>
        <th>Request or comments</th>
        <th>sender mail</th>
        <th>Reply</th>
   </tr>
   <%
   try
   {
       String query="select cfname_ref,cftext,cfmail from contactus";
       Connection conn=DBConnect.getLocalDBConnection();
       Statement stmt=conn.createStatement();
       ResultSet rs=stmt.executeQuery(query);
       while(rs.next())
       {
    	   String uname=rs.getString("cfname_ref");
   %>
           
           <tr>	<td><%out.print(rs.getString("cfname_ref")); %></td>
           		<td><%out.print(rs.getString("cftext")); %></td>
           		<td><%out.print(rs.getString("cfmail"));; %></td>
           		<td><p id="reply">Reply</p></td>
           </tr>
		
		
   <%
       }
   %>
   </table>
   <%
        /* rs.close();
        stmt.close();
        conn.close(); */
   }
   catch(Exception e)
   {
        e.printStackTrace();
   }
   %>
  
  <script>
  document.getElementById("reply").onclick = function() 
  {
	  myFunction()
	  alert("Automatic reply hasbeen send successfully")  
  };

  function myFunction() 
  {
	  	var str = document.getElementById("reply").innerHTML; 
	    var res = str.replace("Reply", "Send Successfully");
	    document.getElementById("reply").innerHTML = res;
	    
  }
  
  
  </script>
  
  
</body>