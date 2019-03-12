<%@page import="com.vtsl.dbconnection.DBConnect"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>

<h3><center>TotalFiles</center></h3>
<table border="2" class="w3-table-all w3-hoverable">
   <tr>
        <th>File Number </th>
        <th>File Name</th>
        <th>Uploaded By</th>
   </tr>
   <%
   try
   {
       String query="select file_id,file_name,fname_ref from useruploads order by fname_ref";
       Connection conn=DBConnect.getLocalDBConnection();
       Statement stmt=conn.createStatement();
       ResultSet rs=stmt.executeQuery(query);
       while(rs.next())
       {
   %>
           
           <tr>	<td><%out.print(rs.getString("file_id")); %></td>
           		<td><%out.print(rs.getString("file_name")); %></td>
           		<td><%out.print(rs.getString("fname_ref"));; %></td>
           </tr>
		
		
   <%
       }
   %>
   </table>
   <%
        rs.close();
        stmt.close();
        conn.close();
   }
   catch(Exception e)
   {
        e.printStackTrace();
   }
   %>
</body>