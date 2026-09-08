<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .empty-message {
            margin-top: 20px;
        }
    </style>
</head>

<body>

    <h1>User Management</h1>

    <%
        List<User> users =
                (List<User>) request.getAttribute("users");
    %>

    <% if (users != null && !users.isEmpty()) { %>

        <table>

            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>

                <% for (User user : users) { %>

                    <tr>
                        <td><%= user.getUserId() %></td>
                        <td><%= user.getName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getRole() %></td>
                        <td><%= user.getStatus() %></td>
                    </tr>

                <% } %>

            </tbody>

        </table>

    <% } else { %>

        <p class="empty-message">
            No users found.
        </p>

    <% } %>

</body>
</html>