<html>
<title>Upload Image</title>
<body>
	<H1>Upload Image</H1>

	<div class="topcorner1">
	<a href="http://ua15.cs.ualberta.ca:16140/proj1/HelpPage.html">Help Page</a>
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

	<form name="upload-image" method="POST" enctype="multipart/form-data" action="UploadImage">

		<H3>Radiology Record ID: <input name="recordID" type="text" pattern="[0-9]+" title="Use Digits"></H3>
		<p>
		<H3>Select File path: <input name="file-path" type="file" size="30"></input></H3>
		<input type="submit" name="Isubmit" value="Upload Now">
		
	</form>

	<%
		String error = (String) session.getAttribute("msg");

		if (error != null) 
		{
			out.println(error);
			session.removeAttribute("msg");
		}
	%>

</body>
</html>
