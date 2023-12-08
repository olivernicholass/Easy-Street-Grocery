<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>Administrator Page</title>
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

        table {
            width: 50%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #52796fff; 
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            caption-side: top;
        }

        caption {
            background-color: #52796fff; 
            color: #cad2c5ff; /
            font-size: 1.2em;
            font-weight: bold;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 8px 8px 0 0;
        }

        td, th {
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
        .action-button {
            display: inline-block;
            padding: 10px;
            background-color: #52796fff;
            color: #cad2c5ff;
            text-decoration: none;
            margin-top: 10px;
            border-radius: 5px;
        }

        .customer-list {
            margin-top: 650px;
            position: absolute;
        }

      .update-delete-links {
    display: flex;
    justify-content: space-evenly;
    margin-top: 400px;
    position: absolute;
}

.action-button {
    margin-right: 10px; 
}

        .button-container {
             margin-top: 420px;
            position: absolute;
        }
    </style>
</head>
<body>

<%
    boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;

    if (!authenticated) {
        String loginMessage = "You have not been authorized to access the URL " + request.getRequestURL().toString();
        session.setAttribute("loginMessage", loginMessage);
        response.sendRedirect("login.jsp");
    } else {

        try {
            String sql = "SELECT CONVERT(DATE, orderDate) AS onlyDate, SUM(totalAmount) AS sumTotal " +
                    "FROM ordersummary " +
                    "GROUP BY CONVERT(DATE, orderDate) " +
                    "ORDER BY onlyDate";

            String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
            String uid = "sa";
            String pw = "304#serverpw";

            Connection conn = DriverManager.getConnection(url, uid, pw);
            Statement stmt = conn.createStatement();
            ResultSet res = stmt.executeQuery(sql);

            out.println("<table border='1'>");
            out.println("<caption>Sales Report</caption>");
            out.println("<tr><th>Order Date</th><th>Total Order Amount</th></tr>");

            while (res.next()) {
                String onlyDate = res.getString("onlyDate");
                double sumTotal = res.getDouble("sumTotal");

                out.println("<tr><td>" + onlyDate + "</td><td>" + "$" + sumTotal + "</td></tr>");
            }

            out.println("</table>");


            out.println("<div class='customer-list'>");
            out.println("<h3>List of Customers</h3>");

            String sql = "SELECT * FROM customer";
            ResultSet res = stmt.executeQuery(sql);

            out.println("<ul>");
            while (res.next()) {
                String firstName = res.getString("firstName");
                String lastName = res.getString("lastName");
                out.println("<li>" + firstName + " " + lastName + "</li>");
            }
            out.println("</ul>");

            out.println("</div>");
            out.println("<div class='update-delete-links'>");
            out.println("<a class='action-button' href='addproduct.jsp'>Add New Product</a>");
            out.println("<a class='action-button' href='updateproduct.jsp'>Update Product</a>");
            out.println("<a class='action-button' href='listprodremove.jsp'>Delete Product</a>");
            out.println("</div>");

            

        } catch (SQLException exec) {
            exec.printStackTrace();
        }
    }
%>

</body>
</html>