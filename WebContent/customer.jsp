<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
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

<b><h3>Customer Profile </h3></b>
    <table border="1">
        <tr><td><b>ID<b></td><td><%=id%></td></tr>
        <tr><td><b>First Name<b></td><td><%= firstName %></td></tr>
        <tr><td><b>Last Name<b></td><td><%= lastName %></td></tr>
        <tr><td><b>Email<b></td><td><%= email %></td></tr>
        <tr><td><b>Phone<b></td><td><%= phone %></td></tr>
		<tr><td><b>Address<b></td><td><%= address %></td></tr>
		<tr><td><b>City<b></td><td><%= city %></td></tr>
		<tr><td><b>State<b></td><td><%= state %></td></tr>
		<tr><td><b>Postal Code<b></td><td><%= postalCode %></td></tr>
		<tr><td><b>Country<b></td><td><%= country %></td></tr>
		<tr><td><b>User id<b></td><td><%= userId %></td></tr>
    </table>
<%
        } else {
            out.println("No Customer Found");
        }

    } catch (SQLException exep) {
        exep.printStackTrace();
    } finally {
        res.close(); 
        tmt.close();
        conn.close(); 
    }
%>
</body>
</html>
