<%@ page language="java" import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<%
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#serverpw";

    String pid request.getParameter("productId");
    if ( pid != null && ! pid.isEmpty()) {
        try {
            int productId = Integer.parseInt( pid);

            try (Connection con = DriverManager.getConnection(url, uid, pw);
                 Statement stmt = con.createStatement()) {

                String sql = "DELETE FROM product WHERE productId = " + productId;
                stmt.executeUpdate(sql);
                response.sendRedirect("listprodremove.jsp");

            } catch (SQLException ex) {
                out.print("SQLException: " + ex);
            }
        } catch (NumberFormatException e) {
            out.print("NumberFormatException: " + e);
        }
    } else {
        out.print("ProductId parameter is missing or empty.");
    }
%>
