<html>
<head>
	<title>Data Analysis</title>
</head>
<body>
  <h1>Data Analysis</h1>
  
  <div class="topcorner1">
	<a href="http://ua15.cs.ualberta.ca:16060/proj1/HelpPage.html">Help Page</a>
	<a href="url">Portal</a>
	<a href="url">Logout</a>
	</div>

	<style type="text/css">
 	.topcorner1
	{
	   position:absolute;
	   top:10;
	   right:10;
  	}
	</style>
  
	<%@ page import="java.sql.*, db.Database" %>
	<%	
		Boolean cb_patient = request.getParameter("cb_patient") != null;
		Boolean cb_test = request.getParameter("cb_test") != null;
		Boolean cb_date = request.getParameter("cb_date") != null;
		int selected = 0;
		
		if (request.getParameter("select_hierarchy") != null) {
  		selected = Integer.parseInt(request.getParameter("select_hierarchy"));
    }
		int checks = 0;
		String table = "";

		// check that at least 1 display option checkbox is checked off
		if (!cb_patient && !cb_test && !cb_date) {
				String error = "<p><b>Please check off at least one option to display.</b></p>";
				session.setAttribute("error", error);
				response.sendRedirect("olapPrompt.jsp");
		}

		// formulate query
		String query = "SELECT";
		String group = " GROUP BY CUBE(";

		if (cb_patient) {
			query += " patient_id,";
			group += " patient_id,";
			table += "<th>Patient ID</th>";
			//checks++;
		} if (cb_test) {
			query += " test_type,";
			group += " test_type,";
			table += "<th>Test Type</th>";
			//checks++;
		} if (cb_date) {
			query += " TO_CHAR(TRUNC(test_date,";
			group += " TO_CHAR(TRUNC(test_date,";
			table += "<th>Test Date</th>";
			//checks++;
			switch (selected) {
			  // weekly
				case 1:
					query += " 'IW')-1,";
					group += " 'IW')-1,";
					break;
				// monthly
				case 2:
					query += " 'MM'),";
					group += " 'MM'),";
					break;
				// yearly
				default:
					query += " 'Y'),";
					group += " 'Y'),";
					break;
			}
			query += " 'DD/MM/YYYY') AS start_date,";
			group += " 'DD/MM/YYYY'),";
		}
		// remove trailing comma from GROUP
		group = group.substring(0, group.length()-1) + ")";

		// combine query components
		query += " COUNT(image_id) FROM cube_view" + group;
		
		table += "<th>Number of Images</th>";
	%>

	<!--HTML table to store results-->
	<table border="1">
		<tr>
			<%
				out.println(table);
			%>
		</tr>
		<%
			Database db = new Database();
			Connection conn = db.connect();

			Statement statement = null;
			ResultSet results = null;

			try {
				statement = conn.createStatement();
				results = statement.executeQuery(query);
				int columns = results.getMetaData().getColumnCount();

				// print data
				while (results.next()) {
					out.println("<tr>");
					for (int i = 1; i <= columns+1; i++) {
						out.println("<td>");
						if (results.getString(i) != null) {
							out.println(results.getString(i) + "</td>");
						}
					}
					out.println("</tr>");
				}
			} catch (Exception e) {
		  		out.println("<hr>" + e.getMessage() + "</hr>");
			} finally {
				db.close(conn, statement, results);
			}

		%>
	</table>
</body>
</html>
