<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Create User</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        .form-container {
            width: 500px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input,
        select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        .buttons {
            margin-top: 20px;
        }

        button {
            padding: 8px 15px;
            cursor: pointer;
        }

        .back-link {
            margin-left: 10px;
        }

        .error-message {
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #dc3545;
            background-color: #f8d7da;
            color: #721c24;
            border-radius: 5px;
        }

    </style>

</head>

<body>

    <h1>Create User</h1>


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
    <!-- CREATE USER FORM                  -->
    <!-- ================================= -->

    <div class="form-container">

        <form action="users" method="post">

            <div class="form-group">

                <label for="name">
                    Name:
                </label>

                <input type="text"
                       id="name"
                       name="name"
                       required>

            </div>


            <div class="form-group">

                <label for="email">
                    Email:
                </label>

                <input type="email"
                       id="email"
                       name="email"
                       required>

            </div>


            <div class="form-group">

                <label for="password">
                    Password:
                </label>

                <input type="password"
                       id="password"
                       name="password"
                       required>

            </div>


            <div class="form-group">

                <label for="role">
                    Role:
                </label>

                <select id="role"
                        name="role"
                        required>

                    <option value="USER">
                        USER
                    </option>

                    <option value="ADMIN">
                        ADMIN
                    </option>

                </select>

            </div>


            <div class="form-group">

                <label for="status">
                    Status:
                </label>

                <select id="status"
                        name="status"
                        required>

                    <option value="ACTIVE">
                        ACTIVE
                    </option>

                    <option value="INACTIVE">
                        INACTIVE
                    </option>

                </select>

            </div>


            <div class="buttons">

                <button type="submit">
                    Create User
                </button>

                <a href="users"
                   class="back-link">
                    Back to Users
                </a>

            </div>

        </form>

    </div>

</body>
</html>