<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
    <title>Create Account</title>
    <style>
        body {
            background-color: #cad2c5ff;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        div {
            text-align: center;
            margin-left: -40px;
        }

        form {
        background-color: #52796fff;
        padding: 60px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-width: 400px;
        margin-left: 0px;
        padding-top: 20px;
        padding-bottom: 20px;
    }

        h3 {
            color: #84a98cff;
            margin-bottom: 20px;
        }

        p {
            color: #cad2c5ff;
            margin-top: 0;
        }

        td {
            color: #cad2c5ff;
            font-weight: bold;
            text-align: right;
            padding-right: 2px;
        }

        input[type="text"],
        input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #2f3e46ff;
            border-radius: 4px;
            box-sizing: border-box;
            color: #52796fff;
            background-color: #cad2c5ff;
        }

       input[type="submit"] {
          background-color: #84a98cff;
          color: #cad2c5ff;
          padding: 10px 20px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-size: 16px;
          margin-bottom: 15px;
          margin-left: 20px;
      }

        input[type="submit"]:hover {
            background-color: #456ba8;
        }

        table {
            width: 120%;
            margin-top: 20px;
        }

        caption {
            background-color: #52796fff;
            color: #cad2c5ff;
            font-size: 1.2em;
            font-weight: bold;
            padding: 10px;
            border-radius: 8px 8px 0 0;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <br>
    <form name="CreateAccountForm" method="post" action="index.jsp">
        <table>
         <p>Please enter your details.</p>
            <tr> 
                <td><div align="right"><font size="2">Username:</font></div></td>
                <td><input type="text" name="username" size="10" maxlength="10" required></td>
            </tr>
            <tr>
                <td><div align="right"><font size="2">Password:</font></div></td>
                <td><input type="password" name="password" size="10" maxlength="10" required></td>
            </tr>
        </table>
        <br/>
        <input class="submit" type="submit" name="Submit2" value="Create Account">
    </form>

</div>

</body>
</html>
