<html>
<head>
	<title>Data Analysis</title>
</head>
<body>
	<h1>Data Analysis</h1>
	<form name="analysis" method="post" action="olapResult.jsp"></form>
		<p>Find Number of Images for:</p>
		<input name="check_patient" type="checkbox" value="1">Patient Name<br>
		<input name="check_test" type="checkbox" value="1">Test Type<br>
		<input name="check_date" type="checkbox" value="1">Time Period<br>
		<p>Order by:</p>
		<select name="select_hierarchy"></select>
		<option value="weekly"></option>
		<option value="monthy"></option>
		<option value="yearly"></option>
		<input name="submit_analysis" type="submit" value="Display">
	</form>

	<%
	  String error = (String) session.getAttribute("error");
	  if (error != null) {
	    out.println(error);
	    session.removeAttribute("error");
	  }
	%>

</body>
</html>