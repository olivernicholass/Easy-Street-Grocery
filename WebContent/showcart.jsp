<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	 <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
  <title>Easy Street Grocery</title>
  <style>
    	body {
      		font-family: 'Poppins', sans-serif;
        }

        h1 {
            background-color: #3498db;
            color: #fff;
            padding: 10px;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #3498db;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #3498db;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e0e0e0;
        }

        a {
            text-decoration: none;
            color: #3498db;
        }

        a:hover {
            text-decoration: underline;
        }

        .remove-link {
            color: red;
            cursor: pointer;
        }
    </style>


    <script>
        function removeProduct(productId) {
			// AJAX implementation
            if (confirm("Are you sure you want to remove this item?")) {
 
                var req = new XMLHttpRequest();
                req .onreadystatechange = function () {
                    if (req .readyState == 4 && req .status == 200) {
                        window.location.reload();
                    }
                };
                req .open("GET", "remove.jsp?id=" + productId, true);
                req .send();
            }
        }
    </script>
</head>
<body>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{
    out.println("<H1>Your shopping cart is empty!</H1>");
    productList = new HashMap<String, ArrayList<Object>>();
}
else
{
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    out.println("<h1>Your Shopping Cart</h1>");
    out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
    out.println("<th>Price</th><th>Subtotal</th><th>Action</th></tr>");

    double total = 0;
    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
    while (iterator.hasNext())
    {
        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
        ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
        if (product.size() < 4)
        {
            out.println("Expected product with four entries. Got: " + product);
            continue;
        }

        out.print("<tr><td>" + product.get(0) + "</td>");
        out.print("<td>" + product.get(1) + "</td>");

        out.print("<td align=\"center\">" + product.get(3) + "</td>");
        Object price = product.get(2);
        Object itemqty = product.get(3);
        double pr = 0;
        int qty = 0;

        try
        {
            pr = Double.parseDouble(price.toString());
        }
        catch (Exception e)
        {
            out.println("Invalid price for product: " + product.get(0) + " price: " + price);
        }
        try
        {
            qty = Integer.parseInt(itemqty.toString());
        }
        catch (Exception e)
        {
            out.println("Invalid quantity for product: " + product.get(0) + " quantity: " + qty);
        }

        out.print("<td align=\"right\">" + currFormat.format(pr) + "</td>");
        out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td>");
        out.print("<td align=\"center\"><span class=\"remove-link\" onclick=\"removeProduct('" + product.get(0) + "')\">Remove</span></td></tr>");
        out.println("</tr>");
        total = total + pr * qty;
    }
    out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
            + "<td align=\"right\">" + currFormat.format(total) + "</td><td></td></tr>");
    out.println("</table>");

    out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>

<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html>
