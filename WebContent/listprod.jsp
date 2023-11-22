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

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
try( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();)
{
	String sql1 = "SELECT * from product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ?";
	PreparedStatement prepstmt = con.prepareStatement(sql1);
	prepstmt.setString(1, "%" + name + "%");
	ResultSet rst = prepstmt.executeQuery();

	// Print out the ResultSet
	out.println("<table> <tr> <th></th> <th>Product Name</th> <th>Price</th> </tr>");
	while(rst.next()){
		int productId = rst.getInt("productId");
		String productName = rst.getString("productName");
		double productPrice = rst.getDouble("productPrice");
		String productImageURL = rst.getString("productImageURL");
		String category = rst.getString("categoryName");

		String addcartURL = "addcart.jsp?id=" + productId + "&name=" + URLEncoder.encode(productName, "UTF-8") + "&price=" + productPrice;
		out.println("<tr><td><a href= \"" + addcartURL + "\"'>Add to cart</a></td>");

		String productNameURL = "product.jsp?id=" + productId + "&name="  + URLEncoder.encode(productName, "UTF-8") + "&price=" + productPrice;// + "&image=" + productImageURL;
		out.println("<td><a href= \"" + productNameURL + "\"'>" + productName + "</a></td>");

		out.println("<td>" + productPrice + "</td></tr>");
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