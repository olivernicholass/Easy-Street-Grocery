<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#serverpw";
String name = request.getParameter("productName");
if(name == null || name.isEmpty())
	name = "";

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " + e);
}


// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
try( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();)
{
	String sql1 = "SELECT * from product WHERE productName LIKE ?";
	PreparedStatement prepstmt = con.prepareStatement(sql1);
	prepstmt.setString(1, "%" + name + "%");
	ResultSet rst = prepstmt.executeQuery();

	// Print out the ResultSet
	out.println("<table> <tr> <th></th> <th>Product Name</th> <th>Price</th> </tr>");
	while(rst.next()){
		String productId = rst.getString("productId");
		String productName = rst.getString("productName");
		String productPrice = rst.getString("productPrice");
		
		//Citation: ChatGPT
		//construct URL with variables 
		String encodedProductName = URLEncoder.encode(productName, "UTF-8");
		String linkurl = "addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + productPrice;
		out.println("<tr><td><a href= '" + linkurl + "'>Add to cart</a></td>");
		//end of citation

		out.println("<td>" + productName + "</td> <td>" + productPrice + "</td></tr>");
	}
	out.println("</table>");

	prepstmt.close();
	rst.close();
	con.close();

}catch(SQLException ex){
	out.print("SQLException: " + ex);
}


// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>