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
	
	<form name="analysis" method="post" action="olapResult.jsp">
		<p>Find number of images for:</p>
		<input name="cb_patient" type="checkbox" value="1">Patient Name<br>
		<input name="cb_test" type="checkbox" value="1">Test Type<br>
		<input name="cb_date" type="checkbox" value="1">Time Period<br>
		<p>Sort by:</p>
		<select name="select_hierarchy">
		  <option value="1">Week</option>
		  <option value="2">Month</option>
		  <option value="3" selected="selected">Year</option>
		</select>
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
