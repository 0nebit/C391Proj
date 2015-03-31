<html>
<title>Upload Image</title>
<body>
	<H1>Upload Image</H1>

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
