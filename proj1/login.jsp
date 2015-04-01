<html>
  <body>
    <h1>Login</h1>
    <p>Please login</p>
    <%@ page import = "java.sql.*" %>
    <%
       if (request.getParameter("submit") != null)
       {
       String user_name = request.getParameter("username").trim();
       String password = request.getParameter("password").trim();

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
       
       String sql_str = "SELECT * FROM users WHERE user_name = '"+user_name+"'";
       
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

       String r_un = null;
       String r_pass = null;
       String r_class = null;
       Integer r_id = null;

       while (result_set != null && result_set.next())
       {
       r_un = result_set.getString(1);
       r_pass = result_set.getString(2);
       r_class = result_set.getString(3);
       r_id = result_set.getInt(4);
       }

       if (password.equals(r_pass))
       {
       HttpSession sess = request.getSession();
       // out.println("<p>Hi!</p>");

       session.setAttribute("u_id", r_id);
       session.setAttribute("u_uname", r_un);
       session.setAttribute("u_class", r_class);

       // redirect to main work portal
       String redirect_url = "http://ui10.cs.ualberta.ca:16150/project/portal.jsp";
       response.sendRedirect(redirect_url);
       }
       else
       {
       out.println("<p>Incorrect username and password combination.</p>");
       }

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
       %>
    <form action="login.jsp" method="post">
      Username: <input type="text" name="username"/>
      <br>
      Password: <input type="password" name="password"/>
      <br>
      <input type="submit" name="submit" value="Login">
    </form>
    <%
       }
       %>
  </body>
</html>
