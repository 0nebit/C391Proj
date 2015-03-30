<html>
<head>
	<title>Radiology Report</title>
</head>
<body>
	<h1>Generate Radiology Report</h1>

	<p>Generated results for patients with: </p>

	<%@ page import="java.sql.*", "db.*"%>
	<%
		String diagnosis = request.getParameter("input_diagnosis");
		String start = request.getParameter("input_date_start");
		String end = request.getParameter("input_date_end");

		if (diagnosis == "" || start == "" || end == "") {
			String error = "Please fill in all required parameters.";
			session.setAttribute("error", error);
			response.sendRedirect("report.jsp");
		}

		Database db = new Database();
		Connection conn = db.connect();

		Statement statement = null;
		ResultSet results = null;

		String sql = "SELECT first_name, last_name, address, phone, test_date FROM persons p, radiology r WHERE p.person_id = r.patient_id AND r.diagnosis LIKE '"+ diagnosis + "' AND r.test_date BETWEEN to_date('"+ start +"', 'DD/MM/YYYY') AND to_date('"+ end +"', 'DD/MM/YYYY') ORDER BY last_name";

		try {
		statement = conn.createStatement();
		results = statement.execute(sql);
		} catch (Exception e) {
		out.println("<hr>" + e.getMessage() + "</hr>");
		}
		
		out.print(diagnosis);
	%>
	<p>From: </p>
	<%
		out.print(start);
	%>
	<p>To: </p>
	<%
		out.print(end);
	%>
	
	<!-- HTML table to store results -->
	<h1><center>Report</center></h1>
	<table border="1">
		<tr>
			<th>Last Name</th>
			<th>First Name</th>
			<th>Address</th>
			<th>Phone</th>
			<th>Test Date</th>
		</tr>

	<%
		while (results != null && results.next()) {
			String firstName = results.getString(1);
			String lastName = results.getString(2);
			String address = results.getString(3);
			String phone = results.getString(4);
			String date = results.getString(5);

			out.println("<tr> <td>" + lName + "</td> <td>" + fName + "</td> <td>" + address + "</td> <td>" +	phone + "</td> <td>" + tDate + "</td> </tr>");
		}
		statement.close();
		results.close();
		conn.close();
	%>
	</table>
</body>
</html>