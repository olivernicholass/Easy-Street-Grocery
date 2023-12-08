<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
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
            caption-side: top;
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

    
    </style>
</head>
<body>

<%@ include file="auth.jsp" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ include file="jdbc.jsp" %>

<%
    String userName = (String) session.getAttribute("authenticatedUser");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet res = null;
    try {
        String sql = "SELECT * FROM customer WHERE userid = ?";

        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String uid = "sa";
        String pw = "304#serverpw";

        conn = DriverManager.getConnection(url, uid, pw);
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, userName);
        res = stmt.executeQuery();

        if (res.next()) {
            int id = res.getInt("customerId");
            String firstName = res.getString("firstName");
            String lastName = res.getString("lastName");
            String email = res.getString("email");
            String phone = res.getString("phonenum");
            String address = res.getString("address");
            String city = res.getString("city");
            String state = res.getString("state");
            String postalCode = res.getString("postalCode");
            String country = res.getString("country");
            String userId = res.getString("userid");
%>


            <table border="1">
                <caption>Customer Details</caption>
                <tr><th>ID</th><td><%=id%></td></tr>
                <tr><th>First Name</th><td><%= firstName %></td></tr>
                <tr><th>Last Name</th><td><%= lastName %></td></tr>
                <tr><th>Email</th><td><%= email %></td></tr>
                <tr><th>Phone</th><td><%= phone %></td></tr>
                <tr><th>Address</th><td><%= address %></td></tr>
                <tr><th>City</th><td><%= city %></td></tr>
                <tr><th>State</th><td><%= state %></td></tr>
                <tr><th>Postal Code</th><td><%= postalCode %></td></tr>
                <tr><th>Country</th><td><%= country %></td></tr>
                <tr><th>User id</th><td><%= userId %></td></tr>
            </table>

<%
        } else {
            out.println("No Customer Found");
        }

    } catch (SQLException exep) {
        exep.printStackTrace();
    } finally {
        if (res != null) res.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
