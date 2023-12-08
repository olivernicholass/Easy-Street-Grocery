<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="header.jsp" %>
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
            margin: 0;
            padding: 0;
            color: var(--dark-slate-gray);
        }


        h2 {
            text-align: center;
            margin-top: 20px;
        }

        h2 a {
            text-decoration: none;
            color: var(--dark-slate-gray);
            padding: 10px;
            background-color: var(--cambridge-blue);
            border-radius: 5px;
            margin: 5px;
            display: inline-block;
            transition: background-color 0.3s;
        }

        h2 a:hover {
            background-color: var(--charcoal);
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
            color: var(--dark-slate-gray);
            padding: 10px;
            background-color: var(--cambridge-blue);
            border-radius: 5px;
            margin: 5px;
            display: inline-block;
            transition: background-color 0.3s;
        }

        h4 a:hover {
            background-color: var(--charcoal);
        }
    </style>
</head>
<body>


<h2><a href="login.jsp">Login</a></h2>

<h2><a href="listprod.jsp">Begin Shopping</a></h2>

<h2><a href="listorder.jsp">List All Orders</a></h2>

<h2><a href="customer.jsp">Customer Info</a></h2>

<h2><a href="admin.jsp">Administrators</a></h2>

<h2><a href="logout.jsp">Log out</a></h2>

<h4><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

</body>
</html>