<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap">
    <style>
        body {
    background-color: #cad2c5ff;
    font-family: 'Poppins', sans-serif;
    margin: 0;
    padding: 0;
}

header {
    background-color: #52796fff;
    padding: 20px;
    border-radius: 0 0 8px 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    width: 100%;
    z-index: 1000;
    margin-bottom: 0;
}

h1 {
    color: #84a98cff; 
    margin: 0;
}

p {
    color: #354f52ff; 
    margin-top: 5px;
}

.user-info {
    position: absolute;
    top: 20px;
    right: 20px;
    color: #84a98cff;
    font-weight: bold;
    margin-top: 20px;
    margin-right: 30px;
}

    </style>
</head>
<body>

<header>
    <h1>Easy Street Grocery</h1>
    <p>Your one-stop shop for quality groceries</p>
    <div class="user-info">
    <% String userName = (String) session.getAttribute("authenticatedUser"); %>
        <% if (userName != null) { %>
            <p>Welcome, <%= userName %>!</p>
        <% } else { %>
        <% } %>
    </div>
</header>
