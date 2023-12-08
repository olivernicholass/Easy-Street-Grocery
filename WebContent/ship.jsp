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
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #cad2c5ff;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h3 {
            color: #84a98cff; 
            text-align: center;
        }

        .shipment-message {
        background-color: #52796fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 25%;
        font-weight: bold;
        color: #cad2c5ff;
        margin-top: 300px;
        position: absolute;
        margin-left: 30px;
    }

        table {
            width: 50%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #52796fff; 
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            caption-side: top;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #2f3e46ff; 
            padding: 12px;
            text-align: left;
            background-color: #84a98cff; 
            color: #cad2c5ff;
        }

        th {
            background-color: #52796fff; 
            color: #cad2c5ff;
            font-weight: bold;
        }

        caption {
            background-color: #52796fff;
            color: #cad2c5ff;
            font-size: 1.2em;
            font-weight: bold;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 8px 8px 0 0;
        }
    </style>
</head>
<body>

<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#serverpw";

String id = request.getParameter("orderId");

try (Connection con = DriverManager.getConnection(url, uid, pw);) {
    String sql = "SELECT productId, quantity FROM orderproduct WHERE orderId = ?";
    PreparedStatement prepstmt = con.prepareStatement(sql);

    if (id != null) {
        prepstmt.setString(1, id);
        ResultSet rst = prepstmt.executeQuery();

        if (rst.next()) {
            con.setAutoCommit(false); 

            String sql4 = "SELECT op.productId, op.quantity, pr.quantity AS inventoryqty, w.warehouseId FROM orderproduct op JOIN productinventory pr ON pr.productId = op.productId JOIN warehouse w ON w.warehouseId = pr.warehouseId WHERE op.orderId = ?";
            PreparedStatement prepstmt4 = con.prepareStatement(sql4);
            prepstmt4.setString(1, id);
            ResultSet rst4 = prepstmt4.executeQuery();

            boolean inventoryRoom = false;

            out.println("<table>");
            out.println("<caption>Shipment Details</caption>");
            out.println("<tr><th>Ordered Product</th><th>Quantity</th><th>Previous Inventory</th><th>New Inventory</th></tr>");

            while (rst4.next()) {
                String pid = rst4.getString("productId");
                int orderQty = Integer.parseInt(rst4.getString("quantity"));
                int inventoryQty = Integer.parseInt(rst4.getString("inventoryqty"));
                String wid = rst4.getString("warehouseId");

                if (inventoryQty >= orderQty) {
                    String sql5 = "UPDATE productinventory SET quantity = quantity - ? WHERE productId = ?";
                    PreparedStatement prepstmt5 = con.prepareStatement(sql5);
                    prepstmt5.setInt(1, orderQty);
                    prepstmt5.setString(2, pid);
                    prepstmt5.executeUpdate();

                    out.println("<tr>");
                    out.println("<td>" + pid + "</td>");
                    out.println("<td>" + orderQty + "</td>");
                    out.println("<td>" + inventoryQty + "</td>");
                    out.println("<td>" + (inventoryQty - orderQty) + "</td>");
                    out.println("</tr>");
                } else {
                    inventoryRoom = true;
                    break;
                }
            }

            if (inventoryRoom) {
                String pid = rst4.getString("productId");
                con.rollback();
                out.println("<div class='shipment-message'>Shipment not done. Insufficient inventory for product id:" + pid + "</div>");
            } else {
                con.commit();
            }

            con.setAutoCommit(true);

            out.println("</table>");

        } else {
            out.println("<div class='shipment-message'>Order ID not found in database</div>");
        }
    }
} catch (SQLException e) {
    out.println("<div class='shipment-message'>SQLException: " + e + "</div>");
}
%>

</body>
</html>
