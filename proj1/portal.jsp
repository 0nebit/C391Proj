<!DOCTYPE html>
<html>
  <head>
    <title>Main Portal</title>
  </head>
  <body>
    <h1><center>Main Portal</center></h1>
    <p><center>Status</center></p>
    <%@ page import = "java.util.*" %>
    <%
       HttpSession sess = request.getSession();
       out.println("<p>User: "+sess.getAttribute("u_uname")+"</p>");
       String class_str = (String) sess.getAttribute("u_class");
       if (class_str.equals("a"))
       {
       out.println("<p>Current account status: administrator</p>");
       }
       else if (class_str.equals("p"))
       {
       out.println("<p>Current account status: person</p>");
       }
       else if (class_str.equals("d"))
       {
       out.println("<p>Current account status: doctor</p>");
       }
       else if (class_str.equals("r"))
       {
       out.println("<p>Current account status: radiologist</p>");
       }
       %>
    <li><center>
	<a href="http://ui10.cs.ualberta.ca:16150/project/edit_account.jsp" 
	   target="_self">Edit account</a>
    </center></li>
    <%
       if (class_str.equals("a"))
       {
       out.println("<li><center><a href=\"http://ui10.cs.ualberta.ca:16150/project/manage_users.jsp\"target=\"_self\">Manage users</a></center></li>");
       }
       %>
  </body>
</html>
