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
    :root {
        --ash-gray: #cad2c5ff;
        --cambridge-blue: #84a98cff;
        --hookers-green: #52796fff;
        --dark-slate-gray: #354f52ff;
        --charcoal: #2f3e46ff;
    }

    body {
        font-family: 'Poppins', sans-serif;
        background-color: var(--ash-gray);
    }

    h1 {
        background-color: var(--dark-slate-gray);
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
        border: 1px solid var(--dark-slate-gray);
    }

    th, td {
        padding: 10px;
        text-align: left;
    }

    th {
        background-color: var(--dark-slate-gray);
        color: #fff;
    }


    tr:hover {
        background-color: var(--hookers-green);
    }

    a {
        text-decoration: none;
        color: var(--cambridge-blue);
    }

    a:hover {
        text-decoration: underline;
    }

    .remove-link {
        color: red;
        cursor: pointer;
    }

    .button-container {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    .button {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        margin-right: 20px
    }

    .checkout-button {
        background-color: var(--hookers-green);
        color: #fff;
    }

    .continue-button {
        background-color: var(--hookers-green);
        color: #fff;
    }
</style>


    <script>
        function removeProduct(productId) {
            if (confirm("Are you sure you want to remove this item?")) {
                var req = new XMLHttpRequest();
                req.onreadystatechange = function () {
                    if (req.readyState == 4 && req.status == 200) {
                        window.location.reload();
                    }
                };
                req.open("GET", "remove.jsp?id=" + productId, true);
                req.send();
            }
        }
    </script>
</head>
<body>

<%
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null) {
    out.println("<H1>Your shopping cart is empty!</H1>");
    productList = new HashMap<String, ArrayList<Object>>();
} else {
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    out.println("<h1>Your Shopping Cart</h1>");
    out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
    out.println("<th>Price</th><th>Subtotal</th><th>Action</th></tr>");

    double total = 0;
    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
    while (iterator.hasNext()) {
        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
        ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
        if (product.size() < 4) {
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

        try {
            pr = Double.parseDouble(price.toString());
        } catch (Exception e) {
            out.println("Invalid price for product: " + product.get(0) + " price: " + price);
        }
        try {
            qty = Integer.parseInt(itemqty.toString());
        } catch (Exception e) {
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

    out.println("<div class=\"button-container\">");
    out.println("    <form action=\"checkout.jsp\" method=\"get\">");
    out.println("        <button type=\"submit\" class=\"button checkout-button\">Check Out</button>");
    out.println("    </form>");
    out.println("    <button class=\"button continue-button\" onclick=\"location.href='listprod.jsp'\">Continue Shopping</button>");
    out.println("</div>");
}
%>

</body>
</html>
