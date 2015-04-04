<!-- report generating module -->
<html>
<head>
	<title>Radiology Report</title>
</head>
<body>
	<h1>Generate Radiology Report</h1>
	
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
	
	<form name="report" method="post" action="reportResult.jsp">
		<H3><b>Diagnosis:</b><input name="input_diagnosis" type="text"><br></H3>
		<p>Please enter dates as DD/MM/YYYY</p>
		<H3><b>Date Range Start: </b></H3>
		<input name="input_date_start" pattern="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d" type="text" title="DD/MM/YYYY"><br>
		<H3><b>Date Range End: </b></H3>
		<input name="input_date_end" pattern="(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d" type="text" title="DD/MM/YYYY"><br>
		<input name="submit_report" type="submit" value="Generate">
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
