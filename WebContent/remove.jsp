<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>

<%
@SuppressWarnings("unchecked")
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null) {
    response.sendRedirect("showcart.jsp"); 
} else {
    String removing = request.getParameter("id");
    productList.remove(removing);
    session.setAttribute("productList", productList);
    response.sendRedirect("showcart.jsp");
}
%>
