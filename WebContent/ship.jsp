<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>

<%@ include file="header.jsp" %>

<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#serverpw";

// TODO: Get order id
String id = request.getParameter("id");

try (Connection con = DriverManager.getConnection(url, uid, pw);) {
    // TODO: Retrieve all items in order with given id
    String sql = "SELECT productId, quantity FROM orderproduct WHERE orderId = ?";
    PreparedStatement prepstmt = con.prepareStatement(sql);
    prepstmt.setString(1, id);
    ResultSet rst = prepstmt.executeQuery();

    // TODO: Check if valid order id in database
    if (rst.next()) {
        // TODO: Start a transaction (turn-off auto-commit)
        con.setAutoCommit(false);

        String productid = rst.getString("productId");
        String quantity = rst.getString("quantity");

        while (rst.next()) {
            productid = rst.getString("productId");
            quantity = rst.getString("quantity");
        }

        // TODO: For each item verify sufficient quantity available in warehouse 1.
        // TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
        String sql4 = "SELECT op.productId, op.quantity, w.warehouseId FROM orderproduct op JOIN productinventory pr ON pr.productId = op.productId JOIN warehouse w ON w.warehouseId = pr.warehouseId WHERE op.orderId = ?";
        PreparedStatement prepstmt4 = con.prepareStatement(sql4);
        prepstmt4.setString(1, id);
        ResultSet rst4 = prepstmt4.executeQuery();

        while (rst4.next()) {
            String pid = rst4.getString("productId");
            int orderqty = Integer.parseInt(rst4.getString("quantity"));
            int inventoryqty = Integer.parseInt(rst4.getString("inventoryqty"));
            String wid = rst4.getString("warehouseId");

            if (inventoryqty > orderqty) {
                String sql5 = "UPDATE productinventory SET quantity = quantity - ? WHERE productId = ?";
                PreparedStatement prepstmt5 = con.prepareStatement(sql5);
                prepstmt5.setInt(1, orderqty);
                prepstmt5.setString(2, pid);
                prepstmt5.executeUpdate();
            } else {
                con.rollback();
            }
        }

        // TODO: Create a new shipment record.
        String sqlInsert = "INSERT INTO shipment (shipmentId, shipmentDate, shipmentDesc, warehouseId) VALUES (?,?,?,?)";
        PreparedStatement prepstmt3 = con.prepareStatement(sqlInsert);
        prepstmt3.setString(1, id);
        Date currentDate = new Date();
        prepstmt3.setDate(2, new java.sql.Date(currentDate.getTime()));
        prepstmt3.setString(3, "Description...."); 
        prepstmt3.setString(4, "WarehouseId.."); 
        ResultSet rst3 = prepstmt3.executeQuery();

        // TODO: Auto-commit should be turned back on
        con.setAutoCommit(true);

    } else {
        out.println("Order ID not found in database");
    }
} catch (SQLException e) {
    out.println("SQLException: " + e);
}
%>

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
