<html>
<head>
</head>
<body>
	<div align="center">
		<%
			String imageId = request.getQueryString();
			if (imageId.startsWith("regular")) {
				// regular sized image is clicked
				out.println("<a href=\"/proj1/viewImage.jsp?" + imageId.substring(7) + "\">");
				// display the regular sized image
				out.println("<img src=\"/proj1/GetOnePic?regular" + imageId.substring(7) + "\"></a>");
			} else {
				// full sized image is clicked
				out.println("<a href=\"/proj1/viewImage.jsp?regular" + imageId + "\">");
				// display the full sized image
				out.println("<img src=\"/proj1/GetOnePic?" + imageId + "\"></a>");
			}
		%>
	</div>
</body>