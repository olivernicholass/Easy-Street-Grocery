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
            background-color: #cad2c5ff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            color: #84a98c;
            text-align: center;
        }

        form {
            background-color: #354f52;
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
            color: #fff;
        }

        input[type="text"],
        input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #cad2c5;
            border-radius: 4px;
            box-sizing: border-box;
            color: #84a98c;
        }

        td.button-container {
            text-align: right;
            margin-top: 15px;
        }

        input[type="submit"]{
            background-color: #84a98c;
             font-family: 'Poppins', sans-serif;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-left: 78px;
            margin-right:1px;
        }

        input[type="reset"] {
            background-color: #84a98c;
            color: #fff;
             font-family: 'Poppins', sans-serif;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-left: 30px;
            margin-right:100px;
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
        <tr class="button-container">
            <td colspan="2">
                <input type="submit" value="Submit">
                <input type="reset" value="Reset">
            </td>
        </tr>
    </table>
</form>

</body>
</html>
