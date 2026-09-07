<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Forgot Password - EventSync</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f8fafc;
        }

        .container {
            width: 400px;
            margin: 100px auto;
            background-color: white;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #0f172a;
        }

        p {
            text-align: center;
            color: #64748b;
            font-size: 14px;
        }

        label {
            display: block;
            margin-top: 20px;
            margin-bottom: 7px;
            font-weight: 600;
        }

        input {
            width: 100%;
            height: 42px;
            padding: 0 10px;
            box-sizing: border-box;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
        }

        button {
            width: 100%;
            height: 44px;
            margin-top: 25px;
            background-color: #2563eb;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
        }

        .back {
            text-align: center;
            margin-top: 20px;
        }

        .back a {
            color: #2563eb;
            text-decoration: none;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 15px;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Forgot Password?</h1>

    <p>
        Enter your registered email and create a new password.
    </p>

    <%
        String error = (String) request.getAttribute("error");

        if (error != null) {
    %>

        <div class="error">
            <%= error %>
        </div>

    <%
        }
    %>

    <form action="forgot-password" method="post">

        <label>Email Address</label>

        <input type="email"
               name="email"
               placeholder="Enter your registered email"
               required>

        <label>New Password</label>

        <input type="password"
               name="password"
               placeholder="Enter new password"
               required>

        <label>Confirm Password</label>

        <input type="password"
               name="confirmPassword"
               placeholder="Confirm new password"
               required>

        <button type="submit">
            Reset Password
        </button>

    </form>

    <div class="back">
        <a href="login.jsp">
            ← Back to Login
        </a>
    </div>

</div>

</body>

</html>