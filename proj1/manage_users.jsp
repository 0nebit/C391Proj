<html>
  <body>
    <h1>Manager Users</h1>
    <%@ page import = "java.sql.*" %>
    <p>Enter the Person's ID number</p>
    <form action="manage_users.jsp" method="post">
      Person ID: <input type="text" name="f_pid"/>
      <br>
      <input type="submit" name="submit_f_person" value="Find">
    </form>
    <%
       if (request.getParameter("submit_f_person") != null)
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

       Statement statement = null;
       ResultSet result_set = null;
       
       //HttpSession sess = request.getSession();
       //int id = (Integer) sess.getAttribute("u_id");

       String sql_str = null;

       if (!request.getParameter("f_pid").equals(""))
       {
       sql_str = "SELECT * FROM persons WHERE person_id = "+request.getParameter("f_pid");

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

       int r_pid = -1;
       String r_fn = null;
       String r_ln = null;
       String r_addr = null;
       String r_email = null;
       String r_phone = null;

       while (result_set != null && result_set.next())
       {
       r_pid = (Integer) result_set.getInt(1);
       HttpSession sess = request.getSession();
       sess.setAttribute("admin_update_person", r_pid);
       r_fn = result_set.getString(2);
       r_ln = result_set.getString(3);
       r_addr = result_set.getString(4);
       r_email = result_set.getString(5);
       r_phone = result_set.getString(6);
       }

       out.println("<p>Found:</p>");
       out.println("<p>PID:"+r_pid+"</p>");
       out.println("<p>First Name:"+r_fn+"</p>");
       out.println("<p>Last Name:"+r_ln+"</p>");
       out.println("<p>Address: "+r_addr+"</p>");
       out.println("<p>Email: "+r_email+"</p>");
       out.println("<p>Phone: "+r_phone+"</p>");

       out.println("<p>Update this person's information.</p>");
       out.println("<form action=\"manage_users.jsp\" method=\"post\">");
       out.println("First Name: <input type=\"text\" name=\"fn_e\"/>");
       out.println("<br>");
       out.println("Last Name: <input type=\"text\" name=\"ln_e\"/>");
       out.println("<br>");
       out.println("Address: <input type=\"text\" name=\"addr_e\"/>");
       out.println("<br>");
       out.println("Email: <input type=\"text\" name=\"email_e\"/>");
       out.println("<br>");
       out.println("Phone: <input type=\"text\" name=\"phone_e\"/>");
       out.println("<br>");
       out.println("<input type=\"submit\" name=\"submit_edit_p\" value=\"Submit\">");
       out.println("</form>");

       try
       {
       con.close();
       }
       catch (Exception e)
       {
       out.println(e.getMessage());
       }
       }
       }

       if (request.getParameter("submit_edit_p") != null)
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
       int target_id = (Integer) sess.getAttribute("admin_update_person");

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

       sql_str = "UPDATE persons SET first_name = '"+new_fn+"' WHERE person_id = "+target_id;
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
       sql_str = "UPDATE persons SET last_name = '"+new_ln+"' WHERE person_id = "+target_id;
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
       sql_str = "UPDATE persons SET address = '"+new_addr+"' WHERE person_id = "+target_id;
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
       sql_str = "UPDATE persons SET email = '"+new_email+"' WHERE person_id = "+target_id;
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
       sql_str = "UPDATE persons SET phone = '"+new_phone+"' WHERE person_id = "+target_id;
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

       sql_str = "SELECT * FROM  persons WHERE person_id = "+target_id;

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

       out.println("<p>Updated person's information:</p>");
       out.println("<p>PID:"+target_id+"</p>");
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

    <p>Enter the User's username</p>
    <form action="manage_users.jsp" method="post">
      Username: <input type="text" name="f_un"/>
      <br>
      <input type="submit" name="submit_f_un" value="Find">
    </form>

    <%
       if (request.getParameter("submit_f_un") != null)
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

       Statement statement = null;
       ResultSet result_set = null;
       
       //HttpSession sess = request.getSession();
       //int id = (Integer) sess.getAttribute("u_id");

       String sql_str = null;

       if (!request.getParameter("f_un").equals(""))
       {
       sql_str = "SELECT * FROM users WHERE user_name = '"+request.getParameter("f_un")+"'";

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

       String r_un = null;
       String r_pass = null;
       String r_class = null;
       int r_pid = -1;

       while (result_set != null && result_set.next())
       {
       r_un = result_set.getString(1);
       HttpSession sess = request.getSession();
       sess.setAttribute("admin_update_user", r_un);
       r_pass = result_set.getString(2);
       r_class = result_set.getString(3);
       r_pid = (Integer) result_set.getInt(4);
       }

       out.println("<p>Found:</p>");
       out.println("<p>Username:"+r_un+"</p>");
       out.println("<p>Password:"+r_pass+"</p>");
       out.println("<p>Class:"+r_class+"</p>");
       out.println("<p>PID: "+r_pid+"</p>");

       out.println("<p>Update this user's information.</p>");
       out.println("<form action=\"manage_users.jsp\" method=\"post\">");
       out.println("Username: <input type=\"text\" name=\"un_e\"/>");
       out.println("<br>");
       out.println("Password: <input type=\"text\" name=\"pass_e\"/>");
       out.println("<br>");
       out.println("Class: <input type=\"text\" name=\"class_e\"/>");
       out.println("<br>");
       out.println("<input type=\"submit\" name=\"submit_edit_u\" value=\"Submit\">");
       out.println("</form>");

       try
       {
       con.close();
       }
       catch (Exception e)
       {
       out.println(e.getMessage());
       }
       }
       }

       if (request.getParameter("submit_edit_u") != null)
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
       String target_un = (String) sess.getAttribute("admin_update_user");

       String new_un = request.getParameter("un_e");
       String new_pass = request.getParameter("pass_e");
       String new_class = request.getParameter("class_e");

       String sql_str = null;

       if (!new_un.equals(""))
       {
       sql_str = "UPDATE users SET user_name = '"+new_un+"' WHERE user_name = '"+target_un+"'";
       try
       {
       statement = con.createStatement();
       result_set = statement.executeQuery(sql_str);
       target_un = new_un;
       }
       catch (Exception e)
       {
       out.println("<p>Error: "+e.getMessage()+"</p>");
       }
       }

       if (!new_pass.equals(""))
       {
       sql_str = "UPDATE users SET password = '"+new_pass+"' WHERE user_name = '"+target_un+"'";
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

       if (!new_class.equals(""))
       {
       sql_str = "UPDATE users SET class = '"+new_class+"' WHERE user_name = '"+target_un+"'";
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

       sql_str = "SELECT * FROM users WHERE user_name = '"+target_un+"'";

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

       String r_un = null;
       String r_pass = null;
       String r_class = null;

       while (result_set != null && result_set.next())
       {
       r_un = result_set.getString(1);
       r_pass = result_set.getString(2);
       r_class = result_set.getString(3);
       }

       out.println("<p>Updated user's information:</p>");
       out.println("<p>Username:"+r_un+"</p>");
       out.println("<p>Password:"+r_pass+"</p>");
       out.println("<p>Class: "+r_class+"</p>");

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
    
  </body>
</html>
