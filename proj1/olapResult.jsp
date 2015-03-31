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
		String hierarchy = request.getParameter("hierarchy")

		if (!cb_patient && !cb_test && !cb_date) {
				String error = "<p><b>Please check off at least one option to display.</b></p>";
				session.setAttribute("error", error);
				response.sendRedirect("olapPrompt.jsp");
			}
		}

		String query = "SELECT";
		String where = " WHERE p.person_id = r.patient_id AND r.record_id = i.record_id"

		if (cb_patient) {
			query += " patient_id,";
		} if (cb_test) {
			query += " test_type,";
		} if (cb_date) {
			query += " TO_CHAR(TRUNC(test_date,";
			switch (hierarchy) {
				case "weekly":
					query += ' "IW")-1,';
					break;
				case "monthly":
					query += ' "MM"),';
					break;
				default:
					query += ' "Y"),';
					break;
			}
			query += ' "DD/MM/YYYY") AS start_date,';
		}
		query += " COUNT(image_id) FROM persons p, radiology_record r, pacs_images i";

</body>
</html>