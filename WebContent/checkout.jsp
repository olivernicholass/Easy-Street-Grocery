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
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            color: #007bff;
            text-align: center;
        }

        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }

        table {
            width: 100%;
        }

        tr {
            margin-bottom: 15px;
        }

        td {
            padding: 10px;
        }

        input[type="text"],
        input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"],
        input[type="reset"] {
            background-color: #007bff;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<form method="get" action="order.jsp">

<h1>Enter your customer id and password:</h1>
    <table>
        <tr>
            <td>Customer ID:</td>
            <td><input type="text" name="customerId" size="20"></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><input type="password" name="password" size="20"></td>
        </tr>
        <tr>
            <td><input type="submit" value="Submit"></td>
            <td><input type="reset" value="Reset"></td>
        </tr>
    </table>
</form>

</body>
</html>
