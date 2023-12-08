<%@ page language="java" import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
    <title>Update Product</title>
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

        form {
            background-color: #52796fff; 
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 50%;
            font-weight: bold;
        }

        label {
            color: #cad2c5ff;
            display: block;
            margin-bottom: 8px;
        }

        input, textarea {
            width: 97%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #2f3e46ff; 
            border-radius: 5px;
            background-color: #f2f2f2; 
        }

        input[type="submit"] {
            background-color: #52796fff; 
            color: #cad2c5ff; 
            font-family: 'Poppins', sans-serif;
            border: none;
            padding: 12px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: #354f52ff;
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
        Connection conn = null;
        PreparedStatement stmt = null; 

        try {
            String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
            String uid = "sa";
            String pw = "304#serverpw";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url, uid, pw);
            conn.setAutoCommit(false);

if (request.getMethod().equalsIgnoreCase("post")) {

    int productId = Integer.parseInt(request.getParameter("productId"));
    String productName = request.getParameter("productName");
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
    String productDesc = request.getParameter("productDesc");
    double productPrice = Double.parseDouble(request.getParameter("productPrice"));

    try {
        String sql = "UPDATE product SET productName=?, categoryId=?, productDesc=?, productPrice=? WHERE productId=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, productName);
        stmt.setInt(2, categoryId);
        stmt.setString(3, productDesc);
        stmt.setDouble(4, productPrice);
        stmt.setInt(5, productId);

        int rows = stmt.executeUpdate();

        if (rows > 0) {
            conn.commit();
            response.sendRedirect("listprod.jsp"); 
        } else {
            out.println("Product update failed. No rows affected.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<form method="post" action="updateProduct.jsp">
    <label for="productId">Product ID:</label>
    <input type="number" name="productId" required><br>

    <label for="productName">Product Name:</label>
    <input type="text" name="productName" required><br>

    <label for="categoryId">Category ID:</label>
    <input type="number" name="categoryId" required><br>

    <label for="productDesc">Product Description:</label>
    <textarea name="productDesc" required></textarea><br>

    <label for="productPrice">Product Price:</label>
    <input type="number" name="productPrice" step="0.01" required><br>

    <input type="submit" value="UPDATE PRODUCT">
</form>

</body>
</html>
