<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
    <title>List of Products - Remove</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #cad2c5ff;
            color: #2f3e46ff;
        }

        h1 {
            background-color: #84a98cff;
            color: #cad2c5ff;
            padding: 10px;
            text-align: center;
            margin: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #84a98cff;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #84a98cff;
            color: #cad2c5ff;
        }

        tr:hover {
            background-color: #354f52ff;
        }

        .delete-button {
            background-color: #ff6961;
            color: #fff;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 3px;
        }

        .delete-button:hover {
            background-color: #d63447;
        }

        a {
            text-decoration: none;
            color: #2f3e46ff;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h1>List of Products - Remove</h1>

<%
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#serverpw";

    try (Connection con = DriverManager.getConnection(url, uid, pw);
         Statement stmt = con.createStatement()) {

        String sql = "SELECT * FROM product";
        ResultSet rst = stmt.executeQuery(sql);

        out.println("<table> <tr> <th></th> <th>Product Name</th> <th>Price</th> <th>Action</th> </tr>");
        while (rst.next()) {
            int productId = rst.getInt("productId");
            String productName = rst.getString("productName");
            double productPrice = rst.getDouble("productPrice");

            out.println("<tr>");
            out.println("<td></td>");
            out.println("<td>" + productName + "</td>");
            out.println("<td>$" + productPrice + "</td>");
            out.println("<td><form method='post' action='removeproduct.jsp'>" +
                    "<input type='hidden' name='productId' value='" + productId + "'>" +
                    "<input type='submit' class='delete-button' value='Delete'></form></td>");
            out.println("</tr>");
        }
        out.println("</table>");

        rst.close();

    } catch (SQLException ex) {
        out.print("SQLException: " + ex);
    }
%>

</body>
</html>