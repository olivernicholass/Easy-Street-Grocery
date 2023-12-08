<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
  <title>Login Screen</title>
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
    padding: 40px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    max-width: 400px;
    width: 50%;
    margin-left: 100px;
    margin-right: 150px;
}

    h3 {
      color: #84a98cff; 
      margin-bottom: 20px;
    }

    p {
      color: #354f52ff; 
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
    }

    input[type="submit"]:hover {
      background-color: #456ba8;
    }

    table {
      width: 100%;
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

<div>

  <%
    if (session.getAttribute("loginMessage") != null)
      out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
  %>

  <form name="MyForm" method="post" action="validateLogin.jsp">
    <table>
  <caption>Please enter your details</caption>
  <tr>
    <td align="right">Username:</td>
    <td><input type="text" name="username" size="10" maxlength="10"></td>
  </tr>
  <tr>
    <td align="right">Password:</td>
    <td><input type="password" name="password" size="10" maxlength="10"></td>
  </tr>
</table>
    <input class="submit" type="submit" name="Submit2" value="Log In">
  </form>

  <br>
  <p>Don't have an account? <a href="createacc.jsp">Sign Up</a></p>

</div>

</body>
</html>
