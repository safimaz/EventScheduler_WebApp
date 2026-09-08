
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

        /* Success message */

        .success-message {
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #28a745;
            background-color: #d4edda;
            color: #155724;
            border-radius: 5px;
        }

        /* Error message */

        .error-message {
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #dc3545;
            background-color: #f8d7da;
            color: #721c24;
            border-radius: 5px;
        }

        /* Add User button */

        .add-user {
            display: inline-block;
            padding: 10px 15px;
            margin-bottom: 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .add-user:hover {
            background-color: #0056b3;
        }

        /* User table */

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
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


    <!-- ================================= -->
    <!-- SUCCESS MESSAGE                    -->
    <!-- ================================= -->

    <%
    String successMessage =
    (String) request.getAttribute("successMessage");

        if (successMessage != null) {
    %>

        <div class="success-message">

            <%= successMessage %>

        </div>

    <%
        }
    %>


    <!-- ================================= -->
    <!-- ERROR MESSAGE                     -->
    <!-- ================================= -->

    <%
        String errorMessage =
                (String) request.getAttribute("errorMessage");

        if (errorMessage != null) {
    %>

        <div class="error-message">

            <%= errorMessage %>

        </div>

    <%
        }
    %>


    <!-- ================================= -->
    <!-- ADD USER                          -->
    <!-- ================================= -->

    <a href="create-user.jsp"
       class="add-user">
        Add New User
    </a>


    <!-- ================================= -->
    <!-- GET USERS                         -->
    <!-- ================================= -->

    <%
        List<User> users =
                (List<User>) request.getAttribute("users");
    %>


    <!-- ================================= -->
    <!-- USER TABLE                        -->
    <!-- ================================= -->

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

                        <td>
                            <%= user.getUserId() %>
                        </td>

                        <td>
                            <%= user.getName() %>
                        </td>

                        <td>
                            <%= user.getEmail() %>
                        </td>

                        <td>
                            <%= user.getRole() %>
                        </td>

                        <td>
                            <%= user.getStatus() %>
                        </td>

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
```
