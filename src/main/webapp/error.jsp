<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    errorPage="true"
    %>

<%
    String errorMessage = (String) request.getAttribute("errorMessage");

    if (errorMessage == null || errorMessage.trim().isEmpty()) {
        errorMessage = "An unexpected error occurred. Please try again.";
    }

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Error - Event Room Scheduler</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            min-height: 100vh;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #f5f7fb;
            color: #1f2937;
        }

        .error-container {
            width: 90%;
            max-width: 550px;

            background: white;

            border-radius: 16px;

            padding: 45px 35px;

            text-align: center;

            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        .error-icon {
            width: 75px;
            height: 75px;

            margin: 0 auto 25px;

            border-radius: 50%;

            background: #fee2e2;
            color: #dc2626;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 40px;
            font-weight: bold;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 12px;
        }

        .message {
            color: #6b7280;
            font-size: 16px;
            line-height: 1.6;

            margin-bottom: 25px;
        }

        .details {
            background: #f9fafb;

            border: 1px solid #e5e7eb;

            border-radius: 10px;

            padding: 15px;

            margin-bottom: 25px;

            text-align: left;

            font-size: 14px;
            color: #4b5563;
        }

        .button {
            display: inline-block;

            padding: 12px 24px;

            background: #2563eb;
            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-weight: 600;
        }

        .button:hover {
            background: #1d4ed8;
        }

        .secondary-button {
            display: inline-block;

            margin-left: 10px;

            padding: 12px 24px;

            background: #e5e7eb;
            color: #374151;

            text-decoration: none;

            border-radius: 8px;

            font-weight: 600;
        }

        .secondary-button:hover {
            background: #d1d5db;
        }

    </style>

</head>

<body>

    <div class="error-container">

        <div class="error-icon">
            !
        </div>

        <h1>
            Something went wrong
        </h1>

        <p class="message">
            We couldn't complete your request.
            Please try again or return to your dashboard.
        </p>

        <div class="details">

            <strong>Error Details:</strong>

            <br><br>

            <%= errorMessage %>

        </div>

        <a href="<%= contextPath %>/login.jsp"
           class="button">
            Back to Login
        </a>

        <a href="<%= contextPath %>/index.jsp"
           class="secondary-button">
            Home
        </a>

    </div>

</body>

</html>