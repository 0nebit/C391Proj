<html>
<head>
	<title>Radiology Report</title>
</head>
<body>
	<h1>Generate Radiology Report</h1>
	
	<div class="topcorner1">
	<a href="/proj1/HelpPage.html">Help Page</a>
	<a href="/proj1/portal.jsp">Portal</a>
	</div>

	<style type="text/css">
 	.topcorner1
	{
	   position:absolute;
	   top:10;
	   right:10;
  	}
	</style>

	Generated results for patients with:

	<%@ page import="java.sql.*, db.*" %>
	<%
	  
		String diagnosis = request.getParameter("input_diagnosis").trim();
		String start = request.getParameter("input_date_start").trim();
		String end = request.getParameter("input_date_end").trim();

		if (diagnosis == "" || start == "" || end == "") {
			String error = "<p><b>Please fill in all required parameters.</b></p>";
			session.setAttribute("error", error);
			response.sendRedirect("reportPrompt.jsp");
		}

		Database db = new Database();
		Connection conn = db.connect();
		
		Statement statement = null;
		ResultSet results = null;

		String query = "SELECT first_name, last_name, address, phone, test_date FROM persons p, radiology_record r WHERE p.person_id = r.patient_id AND r.diagnosis = '"+ diagnosis + "' AND r.test_date BETWEEN to_date('"+ start +"', 'DD/MM/YYYY') AND to_date('"+ end +"', 'DD/MM/YYYY') ORDER BY last_name";

		try {
			statement = conn.createStatement();
			results = statement.executeQuery(query);
		} catch (Exception e) {
			if (e.getMessage().startsWith("ORA-01840") || e.getMessage().startsWith("ORA-01861")) {
		  		String error = "<p><b>Date must be in format DD/MM/YYYY</b></p>";
		  		session.setAttribute("error", error);
 				response.sendRedirect("reportPrompt.jsp");
 	  		} else {
		  		out.println("<hr>" + e.getMessage() + "</hr>");
			}
		}
		
		out.println(diagnosis + "<br><br>");
		out.println("From:  " + start + "<br>");
	  	out.println("To:  " + end + "<br>");

	%>
	
	<!-- HTML table to store results -->
	<h1>Report</h1>
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

			out.println("<tr> <td>" + lastName + "</td> <td>" + firstName + "</td> <td>" + address + "</td> <td>" +	phone + "</td> <td>" + date + "</td> </tr>");
		}
		db.close(conn, statement, results);
	%>
	</table>
</body>
</html>
