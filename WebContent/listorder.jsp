<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
  <title>Easy Street Grocery Order List</title>
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #cad2c5ff; 
      margin: 0;
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }



    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      background-color: #52796fff; 
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    table, th, td {
      border: 1px solid #3498db;
    }

    th, td {
      padding: 12px;
      text-align: left;
      color: #cad2c5ff;
      background-color: #84a98cff; 
    }

    th {
      background-color: #52796fff; 
      color: #cad2c5ff; 
      font-weight: bold;
    }

    tr:nth-child(even) {
      background-color: #f2f2f2;
    }

    tr:hover {
      background-color: #e0e0e0;
    }

    .nested-table {
      width: 100%;
      border-collapse: collapse;
    }

    .nested-table, .nested-table th, .nested-table td {
      border: 1px solid #3498db;
    }

    .nested-table th, .nested-table td {
      padding: 8px;
      text-align: left;
    }

    .nested-table th {
      background-color: #3498db;
      color: #fff;
    }
  </style>
</head>
<body>

<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#serverpw";

try {
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
} catch (java.lang.ClassNotFoundException e) {
    out.println("ClassNotFoundException: " + e);
}

try (Connection con = DriverManager.getConnection(url, uid, pw);
     Statement stmt = con.createStatement()) {

    String sql1 = "SELECT os.orderId, os.orderDate, os.customerId, c.firstName, c.lastName, os.totalAmount  FROM ordersummary AS os JOIN customer AS c ON c.customerId = os.customerId;";
    ResultSet rst = stmt.executeQuery(sql1);

    String sql2 = "SELECT p.productName, p.productPrice, op.quantity FROM orderproduct AS op JOIN product AS p ON p.productId = op.productId WHERE op.orderId = ?;";
    PreparedStatement prepstmt = con.prepareStatement(sql2);

    out.println("<table border='1'>");
    out.println("<tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>Customer Name</th><th>Total Amount</th></tr>");

    while (rst.next()) {
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
        while (rst2.next()) {
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
} catch (SQLException ex) {
    out.println("SQLException: " + ex);
}
%>

</body>
</html>
