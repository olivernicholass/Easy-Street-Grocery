
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
  <title>YOUR NAME Grocery</title>
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

    form {
      margin: 20px;
      text-align: center;
    }

    input[type="text"] {
      width: 70%;
      padding: 10px;
      box-sizing: border-box;
      background-color: #52796fff;
      color: #cad2c5ff; 
      border: 1px solid #354f52ff; 
    }

    select, input[type="submit"], input[type="reset"] {
      padding: 10px;
      box-sizing: border-box;
      background-color: #52796fff; 
      color: #cad2c5ff; 
      border: 1px solid #354f52ff;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    select {
      width: 20%;
    }

    input[type="submit"]:hover, input[type="reset"]:hover {
      background-color: #84a98cff; 
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

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
  <input type="text" name="productName" placeholder="Enter product name" size="50">
  <select name="category">
    <option value="">All Categories</option>
    <%
        String sql = "SELECT * FROM category";
        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String uid = "sa";
        String pw = "304#serverpw";
        try(Connection con = DriverManager.getConnection(url, uid, pw);
            Statement stmt = con.createStatement();
            ResultSet res = stmt.executeQuery(sql)) {
            while (res.next()) {
                int categoryId = res.getInt("categoryId");
                String categoryName = res.getString("categoryName");
    %>
                <option value="<%= categoryId %>"><%= categoryName %></option>
    <%
            }
        } catch (SQLException ex) {
            out.print("SQLException: " + ex);
        }
    %>
  </select>
  <input type="submit" value="Search">
  <input type="reset" value="Reset">
</form>

<%@ page import="java.sql.*,java.text.NumberFormat,java.net.URLEncoder" %>

<%
String url2 = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid2 = "sa";
String pw2 = "304#serverpw";
String name = request.getParameter("productName");
int scId = -1; 

// Get the selected category from the request parameters
String scIdStr = request.getParameter("category");
if (scIdStr != null && !scIdStr.isEmpty()) {
    try {
        scId = Integer.parseInt(scIdStr);
    } catch (NumberFormatException e) {
        out.print("NumberFormatException: " + e);
    }
}

if (name == null || name.isEmpty()) {
    name = "";
}

// Note: Forces loading of SQL Server driver
try {
    // Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
} catch (java.lang.ClassNotFoundException e) {
    out.println("ClassNotFoundException: " + e);
}

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset. Make sure to use PreparedStatement!

// Make the connection
try (Connection con = DriverManager.getConnection(url2, uid2, pw2);
        Statement stmt = con.createStatement();) {
    // Build the SQL query based on whether a category is selected
    String sql1 = "SELECT * FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ?";
    if (scId != -1) {
        sql1 += " AND category.categoryId = ?";
    }

    PreparedStatement prepstmt = con.prepareStatement(sql1);
    prepstmt.setString(1, "%" + name + "%");
    if (scId != -1) {
        prepstmt.setInt(2, scId);
    }

    ResultSet rst = prepstmt.executeQuery();

    // Print out the ResultSet
    out.println("<table> <tr> <th></th> <th>Product Name</th> <th>Price</th> </tr>");
    while (rst.next()) {
        int productId = rst.getInt("productId");
        String productName = rst.getString("productName");
        double productPrice = rst.getDouble("productPrice");

        String addcartURL = "addcart.jsp?id=" + productId + "&name=" + URLEncoder.encode(productName, "UTF-8") + "&price=" + productPrice;
        out.println("<tr><td><a href= \"" + addcartURL + "\">Add to cart</a></td>");

        String productNameURL = "product.jsp?id=" + productId + "&name=" + URLEncoder.encode(productName, "UTF-8") + "&price=" + productPrice;
        out.println("<td><a href= \"" + productNameURL + "\">" + productName + "</a></td>");

        out.println("<td>$" + productPrice + "</td></tr>");
    }
    out.println("</table>");

    rst.close();

} catch (SQLException ex) {
    out.print("SQLException: " + ex);
}
%>
</body>
</html>
