<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.event.scheduler.model.User" %>

<%
    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {

        response.sendRedirect("login.jsp");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(
            loggedInUser.getRole())) {

        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Add Resource | EventSync</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            color: #333;
        }

        .header {
            background: #1f2937;
            color: white;
            padding: 20px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
            font-size: 24px;
        }

        .back-btn {
            text-decoration: none;
            color: white;
            background: #374151;

            padding: 10px 18px;

            border-radius: 6px;
        }

        .container {
            max-width: 700px;

            margin: 40px auto;

            padding: 0 20px;
        }

        .form-card {
            background: white;

            padding: 30px;

            border-radius: 10px;

            box-shadow:
                0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .form-card h2 {
            margin-top: 0;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;

            margin-bottom: 7px;

            font-weight: bold;
        }

        input,
        select {

            width: 100%;

            padding: 11px;

            border: 1px solid #d1d5db;

            border-radius: 6px;

            font-size: 15px;
        }

        .button-group {

            display: flex;

            gap: 12px;

            margin-top: 25px;
        }

        .submit-btn {

            border: none;

            background: #2563eb;

            color: white;

            padding: 12px 22px;

            border-radius: 6px;

            font-size: 15px;

            font-weight: bold;

            cursor: pointer;
        }

        .cancel-btn {

            text-decoration: none;

            background: #6b7280;

            color: white;

            padding: 12px 22px;

            border-radius: 6px;

            font-size: 15px;
        }

        .submit-btn:hover {
            background: #1d4ed8;
        }

        .cancel-btn:hover {
            background: #4b5563;
        }

    </style>

</head>


<body>


    <!-- Header -->

    <div class="header">

        <h1>EventSync Admin</h1>

        <a
            href="<%= request.getContextPath() %>/admin/resources"
            class="back-btn">

            Resource Management

        </a>

    </div>


    <!-- Main Container -->

    <div class="container">

        <div class="form-card">

            <h2>
                Add Resource
            </h2>


            <form
                action="<%= request.getContextPath() %>/admin/resources"
                method="post">


                <!-- Resource Name -->

                <div class="form-group">

                    <label for="resourceName">
                        Resource Name
                    </label>

                    <input
                        type="text"
                        id="resourceName"
                        name="resourceName"
                        maxlength="100"
                        placeholder="Enter resource name"
                        required>

                </div>


                <!-- Resource Type -->

                <div class="form-group">

                    <label for="resourceType">
                        Resource Type
                    </label>

                    <input
                        type="text"
                        id="resourceType"
                        name="resourceType"
                        maxlength="100"
                        placeholder="Example: Audio Equipment"
                        required>

                </div>


                <!-- Quantity -->

                <div class="form-group">

                    <label for="quantity">
                        Quantity
                    </label>

                    <input
                        type="number"
                        id="quantity"
                        name="quantity"
                        min="1"
                        placeholder="Enter quantity"
                        required>

                </div>


                <!-- Status -->

                <div class="form-group">

                    <label for="status">
                        Status
                    </label>

                    <select
                        id="status"
                        name="status">

                        <option value="AVAILABLE">
                            AVAILABLE
                        </option>

                        <option value="MAINTENANCE">
                            MAINTENANCE
                        </option>

                        <option value="INACTIVE">
                            INACTIVE
                        </option>

                    </select>

                </div>


                <!-- Buttons -->

                <div class="button-group">

                    <button
                        type="submit"
                        class="submit-btn">

                        Add Resource

                    </button>


                    <a
                        href="<%= request.getContextPath() %>/admin/resources"
                        class="cancel-btn">

                        Cancel

                    </a>

                </div>


            </form>

        </div>

    </div>


</body>

</html>