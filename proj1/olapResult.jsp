<html>
<head>
	<title>Data Analysis</title>
</head>
<body>
  <h1>Data Analysis</h1>
  
  <div class="topcorner1">
	<a href="/proj1/HelpPage.html">Help Page</a>
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
		int checked = 1;
		String table = "";

		// check that at least 1 display option checkbox is checked off
		if (!cb_patient && !cb_test && !cb_date) {
				String error = "<p><b>Please check off at least one option to display.</b></p>";
				session.setAttribute("error", error);
				response.sendRedirect("olapPrompt.jsp");
		}

		// formulate query
		String sql = "";
		String query = "SELECT";
		String group = " GROUP BY CUBE(";

		if (cb_patient) {
			query += " p.person_id,";
			group += " p.person_id,";
			table += "<th>Patient ID</th>";
			checked += 1;
			//table += "<th>Patient ID</th><th>First Name</th><th>LastName</th>";
		} if (cb_test) {
			query += " r.test_type,";
			group += " r.test_type,";
			table += "<th>Test Type</th>";
			checked += 1;
		} if (cb_date) {
			query += " TO_CHAR(TRUNC(r.test_date,";
			group += " TO_CHAR(TRUNC(test_date,";
			table += "<th>Test Date</th>";
			checked += 1;
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

		// remove trailing comma from query
		// query = query.substring(0, query.length()-1);
		

		// combine query components
		sql = query + " COUNT(i.record_id) as image_count FROM persons p, radiology_record r, pacs_images i where p.person_id = r.patient_id AND r.record_id = i.record_id " + group;

		/*
		String error = sql;
		session.setAttribute("error", error);
		response.sendRedirect("olapPrompt.jsp");
		*/
		
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
				results = statement.executeQuery(sql);
				int columns = results.getMetaData().getColumnCount();

				// print each row found into table
				while (results != null && results.next()) {
					
					int k = 0;
					for (int l = 1; l <= checked; l++) {
						String b = (results.getString(l));
						if (b == null) {
							k = 1;
						}
					}
					
					if (k != 1) {
						out.println("<tr>");
					}

					// print out the number of columns specific to the users choices.
					int t = 0;
					for (int i = 1; i <= checked; i++) {
						for (int j = 1; j <= checked; j++) {
							String q = (results.getString(j));
							if (q == null) {
								t = 1;
							}
						}
						if (t != 1) {
							String z = (results.getString(i));
							out.println("<td>" + z + "</td>");
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
</body>
</html>
