<%@ page import="java.sql.*, java.text.NumberFormat, java.util.HashMap, java.util.Iterator, java.util.ArrayList, java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Order Summary</title>
</head>
<body>

<%
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

int customerId = 0;
try {
    customerId = Integer.parseInt(custId);
} catch (NumberFormatException e) {
    out.println("<h1>Your Customer ID is invalid, please enter a valid number.</h1>");
    return;
}

boolean ifExist = false;
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#serverpw";

Connection conn = null; 

// Validating that the customer id is a number and the customer id exists in the database.
// Display an error if customer id is invalid.

try {
    conn = DriverManager.getConnection(url, uid, pw);

    PreparedStatement custPrep = conn.prepareStatement("SELECT * FROM Customer WHERE customerId = ?");
    custPrep.setInt(1, customerId);
    ResultSet custResult = custPrep.executeQuery();
    ifExist = custResult.next();
} catch (SQLException e) {
    out.println("Error checking for a customer: " + e.getMessage());
    return;
} finally {
    // Closing PreparedStatement (either explicitly or as part of try-catch with resources syntax)
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) {
            out.println("Error closing the connection: " + e.getMessage());
        }
    }
}

if (!ifExist) {
    out.println("<h1>Customer ID does not exist, enter a valid ID.</h1>");
    return;
}

// Showing error message if shopping cart is empty

if (productList == null || productList.isEmpty()) {
    out.println("<h1>Your cart is empty, please add an item.</h1>");
    return;
}

// SQL Server connection information and making a successful connection
try {
    conn = DriverManager.getConnection("jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True", "sa", "304#serverpw");

    // Saving info to DB...
    // Inserting into ordersummary table and retrieving auto-generated id
    String insOrdSum = "INSERT INTO OrderSummary (customerId, orderDate, totalAmount) VALUES (?, GETDATE(), 0)";
    try (PreparedStatement orderSumPrep = conn.prepareStatement(insOrdSum, Statement.RETURN_GENERATED_KEYS)) {
        orderSumPrep.setInt(1, customerId);
        int rows = orderSumPrep.executeUpdate();

        if (rows == 0) {
            out.println("<h1>Error creating an order</h1>");
            return;
        }

        // Retrieve auto-generated keys
        ResultSet keys = orderSumPrep.getGeneratedKeys();
        if (keys.next()) {
            int orderId = keys.getInt(1);

            // Insert each item into OrderProduct table using OrderId from previous INSERT
            // Traversing list of products and storing each ordered product in the orderproduct table
            Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                ArrayList<Object> product = entry.getValue();
                String productId = (String) product.get(0);
                int quantity = (Integer) product.get(3);

                String insOrdProd = "INSERT INTO OrderProduct (orderId, productId, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement orderProdPrep = conn.prepareStatement(insOrdProd)) {
                    orderProdPrep.setInt(1, orderId);
                    orderProdPrep.setString(2, productId);
                    orderProdPrep.setInt(3, quantity);
                    orderProdPrep.executeUpdate();
                } catch (SQLException e) {
                    out.println("Error inserting into the OP table: " + e.getMessage());
                    return;
                }
            }

            // Update total amount for the order record
            double total = 0;
            iterator = productList.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                ArrayList<Object> product = entry.getValue();
                double price = Double.parseDouble(String.valueOf(product.get(2)));
                int quantity = (Integer) product.get(3);
                total += price * quantity;
            }

            // Updating total amount for the order in OrderSummary table
            String updateTotal = "UPDATE OrderSummary SET totalAmount = ? WHERE orderId = ?";
            try (PreparedStatement updateTotals = conn.prepareStatement(updateTotal)) {
                updateTotals.setDouble(1, total);
                updateTotals.setInt(2, orderId);
                updateTotals.executeUpdate();
            } catch (SQLException e) {
                out.println("Error updating your total: " + e.getMessage());
                return;
            }

            // Displaying the order information including all ordered items
            out.println("<h1>Your Order Summary</h1>");
            out.println("<table>");
            out.println("<tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

            iterator = productList.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                ArrayList<Object> product = entry.getValue();
                String productId = (String) product.get(0);
                String productName = (String) product.get(1);
                double price = Double.parseDouble((String) product.get(2));
                int quantity = (Integer) product.get(3);
                double subtotal = price * quantity;

                out.println("<tr><td>" + productId + "</td><td>" + productName + "</td><td align=\"center\">" + quantity + "</td><td>$" + price + "</td><td>$" + subtotal + "</td></tr>");
            }

            out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td><td align=\"left\">$" + total + "</td></tr>");
            out.println("</table>");
            out.println("<h1>Order completed. Will be shipped soon...</h1>");
            out.println("<h1>Your order reference number is: " + orderId + "</h1>");
            out.println("<h1>Shipping to customer: " + customerId + " Name: </h1>");


            // Clearing the shopping cart (sessional variable) after order has been successfully placed
            session.removeAttribute("productList");
        } else {
            out.println("<h1>Error retrieving the auto-generated key.</h1>");
            return;
        }
    } catch (SQLException e) {
        out.println("Error inserting into the OS table: " + e.getMessage());
        return;
    }
} catch (SQLException e) {
    out.println("Error making the connection: " + e.getMessage());
    return;
} finally {

    // Closing connection (either explicitly or as part of try-catch with resources syntax)
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) {
            out.println("Error closing the connection: " + e.getMessage());
        }
    }
}
%>

</body>
</html>