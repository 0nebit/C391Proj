<!DOCTYPE html>
<html>
  <head>
    <title>Main Portal</title>
  </head>
  <body>
    <h1><center>Main Portal</center></h1>
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
	<a href="/proj1/edit_account.jsp" 
	   target="_self">Edit account</a>
    </center></li>
    <%
       if (class_str.equals("a"))
       {
       out.println("<li><center><a href=\"/proj1/manage_users.jsp\"target=\"_self\">Manage users</a></center></li>");
       out.println("<li><center><a href=\"/proj1/reportPrompt.jsp\"target=\"_self\">Report Generation</a></center></li>");
       out.println("<li><center><a href=\"/proj1/olapPrompt.jsp\"target=\"_self\">Data Analysis</a></center></li>");
       }
       %>
    <%
       if (class_str.equals("r"))
       {
       out.println("<li><center><a href=\"/proj1/UploadImage.jsp\"target=\"_self\">Upload Image</a></center></li>");
       }
       %>
    <li><center>
	<a href="/proj1/search.jsp" 
	   target="_self">Search</a>
    </center></li>
    <li><center>
	<a href="/proj1/HelpPage.html" 
	   target="_self">Help Page</a>
    </center></li>
  </body>
</html>
