<html>
<body>
  <h1>Search Module</h1>
  <%@ page import = "java.sql.*" %>
  <%
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

     String sql_str = null;
     %>
  <p>Please enter the search keywords and/or and time periods.</p>
  <form action="search.jsp" method="post">
    Query: <input type="text" name="search_query"/><input type="submit" name="submit_search" value="Search">
    <br>
  </form>
  <p>Rank by:</p>
  <select name="rank_select">
    <option value="1" selected="selected">Default</option>
    <option value="2" >Most-recent-first</option>
    <option value="3">Most-recent-last</option>
  </select>
    
  <%
     if (request.getParameter("submit_search") != null)
     {
     if (!request.getParameter("search_query").equals(""))
     {
     // process search query

     sql_str = "";
     sql_str += "SELECT DISTINCT 6*score(1) + 6*score(2) + 3*score(3) + score(4) as rank, ";
     sql_str += "r.record_id, r.patient_id, r.doctor_id, r.radiologist_id, r.test_type, r.prescribing_date, r.test_date, r.diagnosis, r.description ";
     sql_str += "FROM radiology_record r, persons p ";
     sql_str += "WHERE r.patient_id = p.person_id ";
     sql_str += "AND contains(p.first_name, ?, 1) > 0 ";
     sql_str += "OR contains(p.last_name, ?, 2) > 0 ";
     sql_str += "OR contains(r.diagnosis, ?, 3) > 0 ";
     sql_str += "OR contains(r.description, ?, 4) > 0 ";
     sql_str += "ORDER BY rank DESC";

     PreparedStatement search_statement = con.prepareStatement(sql_str);

     search_statement.setString(1, request.getParameter("search_query"));
     search_statement.setString(2, request.getParameter("search_query"));
     search_statement.setString(3, request.getParameter("search_query"));
     search_statement.setString(4, request.getParameter("search_query"));
     
     result_set = search_statement.executeQuery();
     out.println("<p>Your query: "+request.getParameter("search_query")+"</p>");
     out.println("<table border=1>");
     out.println("<tr>");
     out.println("<th>record_id</th>");
     out.println("<th>patient_id</th>");
     out.println("<th>doctor_id</th>");
     out.println("<th>radiologist_id</th>");
     out.println("<th>test_type</th>");
     out.println("<th>prescribing_date</th>");
     out.println("<th>test_date</th>");
     out.println("<th>diagnosis</th>");
     out.println("<th>description</th>");
     out.println("<th>rank</th>");
     out.println("</tr>");

     while(result_set.next())
     {
     out.println("<tr>");
     out.println("<td>"); 
     out.println(result_set.getString(2));
     out.println("</td>");
     out.println("<td>"); 
     out.println(result_set.getString(3));
     out.println("</td>");
     out.println("<td>"); 
     out.println(result_set.getString(4));
     out.println("</td>");
     out.println("<td>"); 
     out.println(result_set.getString(5));
     out.println("</td>");
     out.println("<td>"); 
     out.println(result_set.getString(6));
     out.println("</td>");
     out.println("<td>"); 
     out.println(result_set.getString(7));
     out.println("</td>");
     out.println("<td>"); 
     out.println(result_set.getString(8));
     out.println("</td>");
     out.println("<td>"); 
     out.println(result_set.getString(9));
     out.println("</td>");
     out.println("<td>"); 
     out.println(result_set.getString(10));
     out.println("</td>");
     out.println("<td>");
     out.println(result_set.getString(1));
     out.println("</td>");
     out.println("</tr>");
     }
     }
     }
     %>
</body>
</html>
