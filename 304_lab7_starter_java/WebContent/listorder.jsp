<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>

</head>
<body>

<h1>Order List</h1>

<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#serverpw";

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
try( Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();)
{
	String sql1 = "SELECT os.orderId, os.orderDate, os.customerId, c.firstName, c.lastName, os.totalAmount  FROM ordersummary AS os JOIN customer AS c ON c.customerId = os.customerId;";
	ResultSet rst = stmt.executeQuery(sql1);


	String sql2 = "SELECT p.productName, p.productPrice, op.quantity FROM orderproduct AS op JOIN product AS p ON p.productId = op.productId WHERE op.orderId = ?;";
	PreparedStatement prepstmt = con.prepareStatement(sql2);
	
	out.println("<table border='1'> <tr> <th>Order ID</th> <th>order Date</th> <th>Customer ID</th> <th>Customer Name</th> <th>Total Amount</th> </tr>");

	while(rst.next()){
		String orderId = rst.getString(1);
		String orderDate = rst.getString(2);
		String customerId = rst.getString(3);
		String firstName = rst.getString(4);
		String lastName = rst.getString(5);
		String totalAmount = rst.getString(6);
		out.println("<tr><td>" + orderId + "</td><td>" + orderDate + "</td><td>" + customerId + "</td><td>" + firstName + " " + lastName + "</td><td>$" + totalAmount + "</td></tr>");

		prepstmt.setString(1, orderId);

		ResultSet rst2 = prepstmt.executeQuery();

		out.println("<tr align='right'><td colspan='4'><table border='1'><tr><th>Product Name</th><th>Price</th><th>Quantity</th></tr>");
		while(rst2.next()){
			out.println("<tr><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(2) + "</td><td>" + rst2.getString(3) + "</td></tr>");
		}
		out.println("</table></td></tr>");
		rst2.close();
	}
	out.println("</table>");
	stmt.close();
	prepstmt.close();
	rst.close();
	con.close();
}
catch(SQLException ex){
	out.println("SQLException: " + ex);
} 
%>

</body>
</html>

