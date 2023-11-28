<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
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

	    out.println("<h3> Administrator Sales Report by Day </h3> ");
            out.println("<table border='1'>");
            out.println("<tr><th>Order Date</th><th>Total Order Amount</th></tr>");

            while (res.next()) {
                String onlyDate = res.getString("onlyDate");
                double sumTotal = res.getDouble("sumTotal");

                out.println("<tr><td>" + onlyDate + "</td><td>" + "$" + sumTotal + "</td></tr>");
            }

            out.println("</table>");

        } catch (SQLException exec) {
            exec.printStackTrace();
        }
    }
%>
</body>
</html>
