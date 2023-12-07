<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Account</title>
 <style>
    body {
      background-color: var(--antiflash-white);
      font-family: 'Arial', 'Helvetica', sans-serif;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    div {
      text-align: center; 
    }

    form {
      background-color: var(--yinmn-blue);
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h3 {
      color: var(--air-superiority-blue);
    }

    p {
      color: var(--uranian-blue);
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      margin: 8px 0;
      box-sizing: border-box;
      border: 1px solid var(--battleship-gray);
      border-radius: 4px;
    }

    input[type="submit"] {
      background-color: var(--air-superiority-blue);
      color: var(--antiflash-white);
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    input[type="submit"]:hover {
      background-color: #456ba8;
    }

    table {
      width: 100%;
    }
  </style>
</head>
<body>

<div>
  <h3>Create Account</h3>

  <%
    if (session.getAttribute("createAccountMessage") != null)
      out.println("<p>"+session.getAttribute("createAccountMessage").toString()+"</p>");
  %>

  <br>
  <form name="CreateAccountForm" method="post" action="accvalidation.jsp">
    <table>
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