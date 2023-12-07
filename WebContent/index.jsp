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
            background-color: #E7ECEF;
            margin: 0;
            padding: 0;
            color: #274C77;
        }

        h1 {
            text-align: center;
            background-color: #6096BA;
            color: #E7ECEF;
            padding: 20px;
            margin: 0;
        }

        h2 {
            text-align: center;
            margin-top: 20px;
        }

        h2 a {
            text-decoration: none;
            color: #274C77;
            padding: 10px;
            background-color: #A3CEF1;
            border-radius: 5px;
            margin: 5px;
            display: inline-block;
            transition: background-color 0.3s;
        }

        h2 a:hover {
            background-color: #8B8C89;
        }

        h3 {
            text-align: center;
            margin-top: 20px;
        }

        h4 {
            text-align: center;
            margin-top: 20px;
        }

        h4 a {
            text-decoration: none;
            color: #274C77;
            padding: 10px;
            background-color: #A3CEF1;
            border-radius: 5px;
            margin: 5px;
            display: inline-block;
            transition: background-color 0.3s;
        }

        h4 a:hover {
            background-color: #8B8C89;
        }
    </style>
</head>
<body>

<h1>Welcome to Easy Street Grocery</h1>

<h2><a href="login.jsp">Login</a></h2>

<h2><a href="listprod.jsp">Begin Shopping</a></h2>

<h2><a href="listorder.jsp">List All Orders</a></h2>

<h2><a href="customer.jsp">Customer Info</a></h2>

<h2><a href="admin.jsp">Administrators</a></h2>

<h2><a href="logout.jsp">Log out</a></h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3>Signed in as: "+userName+"</h3>");
%>

<h4><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

</body>
</html>