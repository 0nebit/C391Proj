import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import oracle.sql.*;
import oracle.jdbc.*;
import java.awt.Image;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

import oracle.jdbc.OracleResultSet;
import oracle.sql.BLOB;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;


/*	
 * Part of uploading module.
 * Gets image for UploadImage.jsp and puts it into the database.
 *
 * radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description)
 * pacs_images(record_id,image_id,thumbnail,regular_size,full_size)
 * 
 * One may also need to create a sequence using the following 
 * SQL statement to automatically generate a unique pic_id:
 *
 * CREATE SEQUENCE pic_id_sequence; <--- example
 * CREATE SEQUENCE image_id_sequence; <--- the one we should use
*/


public class UploadImage extends HttpServlet 
{
	// Variable initializations.
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rset = null;
	private ResultSet rset1 = null;
	public String response_message = "";

	// Change the following parameters to connect to the oracle database.
	String username = "lisheung";
	String password = "tformers1";
	String drivername = "oracle.jdbc.driver.OracleDriver";
	String dbstring ="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{	
		// Variable initializations.
		HttpSession session = request.getSession();
		FileItem image_file = null;
		int record_id = 0;
		int image_id;

		// Check if a record ID has been entered.
		if(request.getParameter("recordID") == null || request.getParameter("recordID").equals("")) 
		{
			// If no ID has been entered, send message to jsp.
			response_message = "<p><font color=FF0000>No Record ID Detected, Please Enter One.</font></p>";
			session.setAttribute("msg", response_message);
			response.sendRedirect("UploadImage.jsp");
		}

		try 
		{
			// Parse the HTTP request to get the image stream.
			DiskFileUpload fu = new DiskFileUpload();
			// Will get multiple image files if that happens and can be accessed through FileItems.
			List<FileItem> FileItems = fu.parseRequest(request);

			// Connect to the database and create a statement.
			conn = getConnected(drivername,dbstring, username,password);
			stmt = conn.createStatement();

			// Process the uploaded items, assuming only 1 image file uploaded.
			Iterator<FileItem> i = FileItems.iterator();

			while(i.hasNext()) 
			{
				FileItem item = (FileItem) i.next();

				// Test if item is a form field and matches recordID.
				if(item.isFormField()) 
				{
					if(item.getFieldName().equals("recordID"))
					{
						// Covert record id from string to integer.
						record_id = Integer.parseInt(item.getString());

						String sql = "select count(*) from radiology_record where record_id = " + record_id;
						int count = 0;

						try 
						{
							rset = stmt.executeQuery(sql);

							while(rset != null && rset.next()) 
							{
								count = (rset.getInt(1));
							}
						} 

						catch(SQLException e) 
						{
							response_message = e.getMessage();
						} 
			
						// Check if recordID is in the database.
						if(count == 0) 
						{
							// Invalid recordID, send message to jsp.
							response_message = "<p><font color=FF0000>Record ID Does Not Exist In Database.</font></p>";
							session.setAttribute("msg", response_message);
							response.sendRedirect("UploadImage.jsp");
						}
					}
				} 

				else 
				{
					image_file = item;

					if(image_file.getName().equals("")) 
					{
						// No file, send message to jsp.
						response_message = "<p><font color=FF0000>No File Selected For Record ID.</font></p>";
						session.setAttribute("msg", response_message);
						response.sendRedirect("UploadImage.jsp");
					}
				}
			}

			// Get the image stream.
			InputStream instream = image_file.getInputStream();

			BufferedImage full_image = ImageIO.read(instream);
			BufferedImage thumbnail = shrink(full_image, 10);
			BufferedImage regular_image = shrink(full_image, 5);

			// First, to generate a unique img_id using an SQL sequence.
			rset1 = stmt.executeQuery("SELECT image_id_sequence.nextval from dual");
			rset1.next();
			image_id = rset1.getInt(1);

			// Insert an empty blob into the table first. Note that you have to
			// use the Oracle specific function empty_blob() to create an empty blob.
			stmt.execute("INSERT INTO pacs_images VALUES(" + record_id + "," + image_id + ", empty_blob(), empty_blob(), empty_blob())");

			// to retrieve the lob_locator
			// Note that you must use "FOR UPDATE" in the select statement
			String cmd = "SELECT * FROM pacs_images WHERE image_id = " + image_id + " FOR UPDATE";
			rset = stmt.executeQuery(cmd);
			rset.next();
			BLOB myblobFull = ((OracleResultSet) rset).getBLOB(5);
			BLOB myblobThumb = ((OracleResultSet) rset).getBLOB(3);
			BLOB myblobRegular = ((OracleResultSet) rset).getBLOB(4);

			// Write the full size image to the blob object.
			OutputStream fullOutstream = myblobFull.getBinaryOutputStream();
			ImageIO.write(full_image, "jpg", fullOutstream);
			// Write the thumbnail size image to the blob object.
			OutputStream thumbOutstream = myblobThumb.getBinaryOutputStream();
			ImageIO.write(thumbnail, "jpg", thumbOutstream);
			// Write the regular size image to the blob object.
			OutputStream regularOutstream = myblobRegular.getBinaryOutputStream();
			ImageIO.write(regular_image, "jpg", regularOutstream);

			// Commit the changes to database.
			stmt.executeUpdate("commit");
			response_message = "<p><font color=00CC00>Upload Successful.</font></p>";
			session.setAttribute("msg", response_message);
			response.sendRedirect("UploadImage.jsp");
			
			instream.close();
			fullOutstream.close();
			thumbOutstream.close();
			regularOutstream.close();

			// Close connection.
			conn.close();
		} 

		catch(Exception ex) 
		{
			response_message = ex.getMessage();
		} 
	}

	// Shrink image by a factor of n, and return the shrunk image.
	public static BufferedImage shrink(BufferedImage image, int n) {

		int w = image.getWidth() / n;
		int h = image.getHeight() / n;

		BufferedImage shrunkImage = new BufferedImage(w, h, image.getType());

		for(int y = 0; y < h; ++y)
		{
			for(int x = 0; x < w; ++x)
			{
				shrunkImage.setRGB(x, y, image.getRGB(x * n, y * n));
			}
		}
		return shrunkImage;
	}

	// To connect to the specified database.
    private static Connection getConnected( String drivername, String dbstring,String username, String password) throws Exception 
	{
		Class drvClass = Class.forName(drivername); 
		DriverManager.registerDriver((Driver) drvClass.newInstance());
		return(DriverManager.getConnection(dbstring,username,password));
    }
}

