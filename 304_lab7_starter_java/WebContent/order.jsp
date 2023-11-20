<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message

/if (custId == null || custId.isEmpty() || productList == null || productList.isEmpty()) {
    out.println("<h1>Error: Invalid Customer ID or Cart is Empty!</h1>");
} else {

	// Make connection
	
    Connection connection = null;
    try {

        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
		String uid = "sa";
		String pw = "304#serverpw";
        
        Class.forName("com.mysql.jdbc.Driver"); 
        
        connection = DriverManager.getConnection(url, uid, pw); 
        
        String insert = "INSERT INTO orders (customerId, orderDate, totalAmount) VALUES (?, ?, ?)";
        PreparedStatement prep = connection.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
        prep.setString(1, custId);
        prep.setTimestamp(2, new Timestamp(System.currentTimeMillis())); 
        prep.setDouble(3, calculateTotal(productList)); 
        
        int rowsAff = prep.executeUpdate(); 
        if (rowsAff > 0) {

            ResultSet keys = prep.getGeneratedKeys();
            if (keys.next()) {
                int orderId = keys.getInt(1); 

				// Insert each item into OrderProduct table using OrderId from previous INSERT

                }
                
                out.println("<h1>Order Summary</h1>");
                session.removeAttribute("productList");
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        out.println("<h1>Error: Database Connection Failure!</h1>");
        e.printStackTrace();
    } finally {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

