<html>
<head>
	<title>Data Analysis</title>
</head>
<body>

	<% page import="java.sql.*, db.Database" %>
	<%
		Boolean cb_patient = request.getParameter("cb_patient");
		Boolean cb_test = request.getParameter("cb_test");
		Boolean cb_date = request.getParameter("cb_date");
		int checks = 0;
		String hierarchy = request.getParameter("hierarchy");
		String table = "";

		// check that at least 1 display option checkbox is checked off
		if (!cb_patient && !cb_test && !cb_date) {
				String error = "<p><b>Please check off at least one option to display.</b></p>";
				session.setAttribute("error", error);
				response.sendRedirect("olapPrompt.jsp");
			}
		}

		// formulate query
		String query = "SELECT";
		String group = " GROUP BY CUBE(";

		if (cb_patient) {
			query += " patient_id,";
			group += " patient_id";
			table += "<th>Patient ID</th>";
			checks++;
		} if (cb_test) {
			query += " test_type,";
			group += " test_type,";
			table += "<th>Test Type</th>"
			checks++;
		} if (cb_date) {
			query += " TRUNC(test_date,";
			group += " TRUNC(test_date,";
			table += "<th>Test Date</th>"
			checks++;
			switch (hierarchy) {
				case "weekly":
					query += ' "IW")-1,';
					group += ' "IW")-1,';
					break;
				case "monthly":
					query += ' "MM"),';
					group += ' "MM"),';
					break;
				default:
					query += ' "Y"),';
					group += ' "Y"),';
					break;
			}
			query += ' "DD/MM/YYYY") AS start_date,';
		}
		// remove trailing comma from GROUP
		group = group.substring(0, group.length()-1) + ")";

		// combine query components
		query += " COUNT(i.record_id) FROM persons p, radiology_record r, pacs_images i WHERE p.person_id = r.patient_id AND r.record_id = i.record_id" + group;
		String query2 = "SELECT p.person_id, r.test_type, TRUNC(r.test_date, 'IW') AS test_date, COUNT(i.record_id) AS image_count FROM persons p, radiology_record r, pacs_images i WHERE p.person_id = r.patient_id AND r.record_id = i.record_id GROUP BY CUBE(p.person_id, r.test_type, test_date)";

		table += "<th>Number of Images</th>"
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

				// print data
				while (results != null && results.next()) {
					out.println("<tr>");
					for (int i = 1, i <= count; i++) {
						out.println("<td>" + results.getString(i) + "</td>")
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