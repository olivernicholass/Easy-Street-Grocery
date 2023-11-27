<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#serverpw";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// Get product name to search for
// TODO: Retrieve and display info for the product
String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
double dprice = Double.parseDouble(price);

try(Connection con = DriverManager.getConnection(url, uid, pw);)
{
String sql = "SELECT productImageURL, productImage FROM product WHERE productId = ?";
PreparedStatement prepstmt = con.prepareStatement(sql);
prepstmt.setString(1, id);
ResultSet rst = prepstmt.executeQuery();

out.println("<h1>" + name + "</h1>");

String productImage = "";
String productImageURL = "";

while(rst.next()){
    productImageURL = rst.getString("productImageURL");
    productImage = rst.getString ("productImage");
    // TODO: If there is a productImageURL, display using IMG tag
    //String imageURL = productImageURL;
    if(productImageURL != null){
        out.println("<p>" + productImageURL + "</p>");
        out.println("<img src=\"" + productImageURL + "\">");
    }
}

// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
if(productImage != null){
    out.println("<img src='displayImage.jsp?id=" + id + "'>");
}

    



out.println("<table><tbody>");
out.println("<tr><th>ID</th><td>" + id + "</td></tr>");
out.println("<tr><th>Price</th><td>" + currFormat.format(dprice) + "</td></tr>");
out.println("</tbody></table>");

}catch(SQLException ex){
    out.println("SQLException: " + ex);
}




// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

