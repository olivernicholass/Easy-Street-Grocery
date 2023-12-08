<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Easy Street Grocery</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
    <style>
        body {
            background-color: var(--antiflash-white);
            color: var(--battleship-gray);
            font-family: 'Poppins', sans-serif;
            margin: 20px; 
            padding: 20px;
        }

        h1 {
            color: var(--yinmn-blue);
            margin-bottom: 20px; 
        }

        table {
            border-collapse: collapse;
            width: 100%; 
            margin-top: 20px; 
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--uranian-blue);
        }

        img {
            max-width: 100%;
            height: auto;
            margin-top: 20px; 
            margin-bottom: 20px; 
        }

        a {
            text-decoration: none;
            padding: 10px;
            margin: 10px;
            background-color: var(--air-superiority-blue);
            color: var(--antiflash-white);
            border-radius: 5px;
        }

        a:hover {
            background-color: var(--yinmn-blue);
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#serverpw";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
double dprice = Double.parseDouble(price);

try(Connection con = DriverManager.getConnection(url, uid, pw);)
{
    String sql = "SELECT productImageURL, productImage, productDesc FROM product WHERE productId = ?";
    PreparedStatement prepstmt = con.prepareStatement(sql);
    prepstmt.setString(1, id);
    ResultSet rst = prepstmt.executeQuery();

    out.println("<h1>" + name + "</h1>");

    String productImage = "";
    String productImageURL = "";
    String productDesc = "";

    while(rst.next()){
        productImageURL = rst.getString("productImageURL");
        productImage = rst.getString("productImage");
        productDesc = rst.getString("productDesc");

        if(productImageURL != null){
            out.println("<img src=\"" + productImageURL + "\">");
        }
    }

    if(productImage != null){
        out.println("<img src='displayImage.jsp?id=" + id + "'>");
    }

    out.println("<p>" + productDesc + "</p>");

    out.println("<table><tbody>");
    out.println("<tr><th>ID</th><td>" + id + "</td></tr>");
    out.println("<tr><th>Price</th><td>" + currFormat.format(dprice) + "</td></tr>");
    out.println("</tbody></table>");

}catch(SQLException ex){
    out.println("SQLException: " + ex);
}
%>

<a href="#">Add to Cart</a>
<a href="#">Continue Shopping</a>

</body>
</html>
