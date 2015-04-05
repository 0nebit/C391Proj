<html>
  <body>
    <h1>Edit Account</h1>

    <div class="topcorner1">
      <a href="/proj1/HelpPage.html">Help Page</a>
      <a href="/proj/portal.jsp">Portal</a>
    </div>

    <style type="text/css">
      .topcorner1
      {
      position:absolute;
      top:10;
      right:10;
      }
    </style>

    <%@ page import = "java.sql.*" %>
    <%
       if (request.getParameter("submit_edit") != null)
       {
       Connection con = null;

       String driver_name  = "oracle.jdbc.driver.OracleDriver";
       String db_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
       
       try
       {
       Class drvClass = Class.forName(driver_name);
       DriverManager.registerDriver((Driver) drvClass.newInstance());
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }

       String sql_user = "chuan4";
       String sql_pass = "a12345678";

       try
       {
       con = DriverManager.getConnection(db_url, "chuan4", "a12345678");
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }
       
       // connection established

       // check username and password

       Statement statement = null;
       ResultSet result_set = null;
       
       HttpSession sess = request.getSession();
       int id = (Integer) sess.getAttribute("u_id");

       String new_fn = request.getParameter("fn_e");
       String new_ln = request.getParameter("ln_e");
       String new_addr = request.getParameter("addr_e");
       String new_email = request.getParameter("email_e");
       String new_phone = request.getParameter("phone_e");

       String sql_str = null;

       if (!new_fn.equals(""))
       {

       // out.println("<p>New first name is not null</p>");
       // out.println("<p>New first name = "+new_fn);

       sql_str = "UPDATE persons SET first_name = '"+new_fn+"' WHERE person_id = "+id;
       try
       {
       statement = con.createStatement();
       result_set = statement.executeQuery(sql_str);
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }
       }

       if (!new_ln.equals(""))
       {
       sql_str = "UPDATE persons SET last_name = '"+new_ln+"' WHERE person_id = "+id;
       try
       {
       statement = con.createStatement();
       result_set = statement.executeQuery(sql_str);
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }
       }

       if (!new_addr.equals(""))
       {
       sql_str = "UPDATE persons SET address = '"+new_addr+"' WHERE person_id = "+id;
       try
       {
       statement = con.createStatement();
       result_set = statement.executeQuery(sql_str);
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }
       }

       if (!new_email.equals(""))
       {
       sql_str = "UPDATE persons SET email = '"+new_email+"' WHERE person_id = "+id;
       try
       {
       statement = con.createStatement();
       result_set = statement.executeQuery(sql_str);
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }
       }

       if (!new_phone.equals(""))
       {
       sql_str = "UPDATE persons SET phone = '"+new_phone+"' WHERE person_id = "+id;
       try
       {
       statement = con.createStatement();
       result_set = statement.executeQuery(sql_str);
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }
       }

       String new_pass = request.getParameter("new_pass_e");

       if (!new_pass.equals(""))
       {
       sql_str = "UPDATE users SET password = '"+new_pass+"' WHERE person_id = "+id;
       
       try
       {
       statement = con.createStatement();
       result_set = statement.executeQuery(sql_str);
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }

       out.println("<p><font color=00CC00>Your password has been successfully changed.</font></p>");
       }

       sql_str = "SELECT * FROM persons WHERE person_id = "+id;

       try
       {
       statement = con.createStatement();
       result_set = statement.executeQuery(sql_str);
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }

       // out.println("<p>"+sql_str+"</p>");

       String r_fn = null;
       String r_ln = null;
       String r_addr = null;
       String r_email = null;
       String r_phone = null;

       while (result_set != null && result_set.next())
       {
       r_fn = result_set.getString(2);
       r_ln = result_set.getString(3);
       r_addr = result_set.getString(4);
       r_email = result_set.getString(5);
       r_phone = result_set.getString(6);
       }

       out.println("<p>Your updated personal information:</p>");
       out.println("<p>First Name:"+r_fn+"</p>");
       out.println("<p>Last Name:"+r_ln+"</p>");
       out.println("<p>Address: "+r_addr+"</p>");
       out.println("<p>Email: "+r_email+"</p>");
       out.println("<p>Phone: "+r_phone+"</p>");

       try
       {
       con.close();
       }
       catch (Exception e)
       {
       out.println(e.getMessage());
       }
       }

       else
       {
       Connection con = null;

       String driver_name  = "oracle.jdbc.driver.OracleDriver";
       String db_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
       
       try
       {
       Class drvClass = Class.forName(driver_name);
       DriverManager.registerDriver((Driver) drvClass.newInstance());
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }

       String sql_user = "chuan4";
       String sql_pass = "a12345678";

       try
       {
       con = DriverManager.getConnection(db_url, "chuan4", "a12345678");
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }
       
       // connection established

       // check username and password

       Statement statement = null;
       ResultSet result_set = null;
       
       HttpSession sess = request.getSession();
       int id = (Integer) sess.getAttribute("u_id");

       String sql_str = "SELECT * FROM persons WHERE person_id = "+id;
       
       // out.println("<p>"+sql_str+"</p>");

       try
       {
       statement = con.createStatement();
       result_set = statement.executeQuery(sql_str);
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }

       String r_fn = null;
       String r_ln = null;
       String r_addr = null;
       String r_email = null;
       String r_phone = null;

       while (result_set != null && result_set.next())
       {
       r_fn = result_set.getString(2);
       r_ln = result_set.getString(3);
       r_addr = result_set.getString(4);
       r_email = result_set.getString(5);
       r_phone = result_set.getString(6);
       }

       out.println("<p>Your old personal information</p>");
       out.println("<p>First Name:"+r_fn+"</p>");
       out.println("<p>Last Name:"+r_ln+"</p>");
       out.println("<p>Address: "+r_addr+"</p>");
       out.println("<p>Email: "+r_email+"</p>");
       out.println("<p>Phone: "+r_phone+"</p>");

       try
       {
       con.close();
       }
       catch (Exception e)
       {
       out.println(e.getMessage());
       }
       }
       %>
    <p>Enter your new personal information</p>
    <form action="edit_account.jsp" method="post">
      First Name: <input type="text" name="fn_e"/>
      <br>
      Last Name: <input type="text" name="ln_e"/>
      <br>
      Address: <input type="text" name="addr_e"/>
      <br>
      Email: <input type="text" name="email_e"/>
      <br>
      Phone: <input type="text" name="phone_e"/>
      <br>
      <p>Enter your new password</p>
      New Password: <input type="password" name="new_pass_e"/>
      <br>
      <input type="submit" name="submit_edit" value="Submit">
    </form>
    
  </body>
</html>
