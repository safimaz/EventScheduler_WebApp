<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.User" %>

<%
    String successMessage =
            (String) request.getAttribute("successMessage");

    String errorMessage =
            (String) request.getAttribute("errorMessage");

    List<User> users =
            (List<User>) request.getAttribute("users");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>User Management - Event Room Scheduler</title>


    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }


        body {
            font-family: Arial, Helvetica, sans-serif;

            background: #f5f7fb;

            color: #1f2937;

            min-height: 100vh;
        }


        /* ============================= */
        /* NAVBAR                         */
        /* ============================= */

        .navbar {

            height: 70px;

            background: #ffffff;

            border-bottom: 1px solid #e5e7eb;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 40px;

            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.04);
        }


        .brand {

            font-size: 22px;

            font-weight: 700;

            color: #2563eb;
        }


        .nav-title {

            font-size: 14px;

            color: #6b7280;

            font-weight: 500;
        }


        /* ============================= */
        /* MAIN CONTAINER                 */
        /* ============================= */

        .container {

            width: 92%;

            max-width: 1200px;

            margin: 40px auto;
        }


        /* ============================= */
        /* PAGE HEADER                    */
        /* ============================= */

        .page-header {

            display: flex;

            align-items: center;

            justify-content: space-between;

            margin-bottom: 28px;
        }


        .page-title h1 {

            font-size: 30px;

            font-weight: 700;

            color: #111827;

            margin-bottom: 7px;
        }


        .page-title p {

            color: #6b7280;

            font-size: 14px;
        }


        /* ============================= */
        /* ADD USER BUTTON                */
        /* ============================= */

        .add-user {

            display: inline-flex;

            align-items: center;

            gap: 8px;

            padding: 12px 18px;

            background: #2563eb;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-size: 14px;

            font-weight: 600;

            transition: 0.2s ease;
        }


        .add-user:hover {

            background: #1d4ed8;

            transform: translateY(-1px);
        }


        .plus {

            font-size: 20px;

            line-height: 1;
        }


        /* ============================= */
        /* ALERT MESSAGES                 */
        /* ============================= */

        .alert {

            padding: 14px 18px;

            margin-bottom: 20px;

            border-radius: 8px;

            font-size: 14px;

            font-weight: 500;
        }


        .success-message {

            background: #ecfdf5;

            border: 1px solid #a7f3d0;

            color: #065f46;
        }


        .error-message {

            background: #fef2f2;

            border: 1px solid #fecaca;

            color: #991b1b;
        }


        .alert-icon {

            font-weight: bold;

            margin-right: 8px;
        }


        /* ============================= */
        /* TABLE CARD                     */
        /* ============================= */

        .table-card {

            background: #ffffff;

            border: 1px solid #e5e7eb;

            border-radius: 12px;

            overflow: hidden;

            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.04);
        }


        .table-header {

            padding: 20px 24px;

            border-bottom: 1px solid #e5e7eb;

            display: flex;

            align-items: center;

            justify-content: space-between;
        }


        .table-header h2 {

            font-size: 18px;

            color: #111827;
        }


        .table-header span {

            font-size: 13px;

            color: #6b7280;
        }


        /* ============================= */
        /* TABLE                          */
        /* ============================= */

        .table-wrapper {

            overflow-x: auto;
        }


        table {

            width: 100%;

            border-collapse: collapse;
        }


        thead {

            background: #f9fafb;
        }


        th {

            padding: 14px 20px;

            text-align: left;

            font-size: 12px;

            text-transform: uppercase;

            letter-spacing: 0.5px;

            color: #6b7280;

            font-weight: 700;

            border-bottom: 1px solid #e5e7eb;
        }


        td {

            padding: 16px 20px;

            font-size: 14px;

            color: #374151;

            border-bottom: 1px solid #f1f5f9;
        }


        tbody tr {

            transition: background 0.2s ease;
        }


        tbody tr:hover {

            background: #f8fafc;
        }


        tbody tr:last-child td {

            border-bottom: none;
        }


        /* ============================= */
        /* USER ID                        */
        /* ============================= */

        .user-id {

            font-weight: 600;

            color: #2563eb;
        }


        /* ============================= */
        /* USER NAME                      */
        /* ============================= */

        .user-name {

            font-weight: 600;

            color: #111827;
        }


        /* ============================= */
        /* EMAIL                          */
        /* ============================= */

        .email {

            color: #4b5563;
        }


        /* ============================= */
        /* ROLE BADGES                    */
        /* ============================= */

        .role-badge {

            display: inline-block;

            padding: 5px 10px;

            border-radius: 20px;

            font-size: 12px;

            font-weight: 600;

            text-transform: uppercase;
        }


        .admin-role {

            background: #ede9fe;

            color: #6d28d9;
        }


        .user-role {

            background: #dbeafe;

            color: #1d4ed8;
        }


        /* ============================= */
        /* STATUS BADGES                  */
        /* ============================= */

        .status-badge {

            display: inline-flex;

            align-items: center;

            gap: 6px;

            padding: 5px 10px;

            border-radius: 20px;

            font-size: 12px;

            font-weight: 600;
        }


        .status-dot {

            width: 7px;

            height: 7px;

            border-radius: 50%;

            background: currentColor;
        }


        .active-status {

            background: #dcfce7;

            color: #15803d;
        }


        .inactive-status {

            background: #fee2e2;

            color: #b91c1c;
        }


        /* ============================= */
        /* EMPTY STATE                    */
        /* ============================= */

        .empty-state {

            padding: 60px 20px;

            text-align: center;
        }


        .empty-icon {

            font-size: 42px;

            margin-bottom: 15px;
        }


        .empty-state h3 {

            font-size: 18px;

            margin-bottom: 8px;

            color: #374151;
        }


        .empty-state p {

            font-size: 14px;

            color: #6b7280;
        }


        /* ============================= */
        /* FOOTER                         */
        /* ============================= */

        .footer {

            text-align: center;

            margin-top: 40px;

            padding: 20px;

            color: #9ca3af;

            font-size: 13px;
        }


        /* ============================= */
        /* RESPONSIVE                     */
        /* ============================= */

        @media (max-width: 768px) {

            .navbar {

                padding: 0 20px;
            }


            .nav-title {

                display: none;
            }


            .container {

                width: 94%;

                margin: 25px auto;
            }


            .page-header {

                flex-direction: column;

                align-items: flex-start;

                gap: 18px;
            }


            .page-title h1 {

                font-size: 26px;
            }


            .add-user {

                width: 100%;

                justify-content: center;
            }


            .table-header {

                padding: 18px;
            }


            th,
            td {

                padding: 13px 15px;
            }

        }

    </style>

</head>


<body>


    <!-- ============================= -->
    <!-- NAVBAR                         -->
    <!-- ============================= -->

    <nav class="navbar">

        <div class="brand">
            Event Room Scheduler
        </div>

        <div class="nav-title">
            Admin Panel
        </div>

    </nav>



    <!-- ============================= -->
    <!-- MAIN CONTENT                   -->
    <!-- ============================= -->

    <main class="container">


        <!-- ============================= -->
        <!-- PAGE HEADER                    -->
        <!-- ============================= -->

        <div class="page-header">

            <div class="page-title">

                <h1>
                    User Management
                </h1>

                <p>
                    Manage users registered in the Event Room Scheduler.
                </p>

            </div>


            <a href="<%= contextPath %>/create-user.jsp"
               class="add-user">

                <span class="plus">
                    +
                </span>

                Add New User

            </a>

        </div>



        <!-- ============================= -->
        <!-- SUCCESS MESSAGE                -->
        <!-- ============================= -->

        <%
            if (successMessage != null &&
                !successMessage.trim().isEmpty()) {
        %>

            <div class="alert success-message">

                <span class="alert-icon">
                    ✓
                </span>

                <%= successMessage %>

            </div>

        <%
            }
        %>



        <!-- ============================= -->
        <!-- ERROR MESSAGE                  -->
        <!-- ============================= -->

        <%
            if (errorMessage != null &&
                !errorMessage.trim().isEmpty()) {
        %>

            <div class="alert error-message">

                <span class="alert-icon">
                    !
                </span>

                <%= errorMessage %>

            </div>

        <%
            }
        %>



        <!-- ============================= -->
        <!-- USER TABLE                     -->
        <!-- ============================= -->

        <div class="table-card">


            <div class="table-header">

                <h2>
                    Registered Users
                </h2>

                <span>
                    User Directory
                </span>

            </div>



            <%
                if (users != null && !users.isEmpty()) {
            %>


                <div class="table-wrapper">

                    <table>

                        <thead>

                            <tr>

                                <th>
                                    User ID
                                </th>

                                <th>
                                    Name
                                </th>

                                <th>
                                    Email
                                </th>

                                <th>
                                    Role
                                </th>

                                <th>
                                    Status
                                </th>

                            </tr>

                        </thead>


                        <tbody>


                            <%

                                for (User user : users) {

                            %>


                                <tr>


                                    <!-- USER ID -->

                                    <td>

                                        <span class="user-id">

                                            #<%= user.getUserId() %>

                                        </span>

                                    </td>



                                    <!-- NAME -->

                                    <td>

                                        <span class="user-name">

                                            <%= user.getName() %>

                                        </span>

                                    </td>



                                    <!-- EMAIL -->

                                    <td>

                                        <span class="email">

                                            <%= user.getEmail() %>

                                        </span>

                                    </td>



                                    <!-- ROLE -->

                                    <td>


                                        <%

                                            if ("ADMIN".equalsIgnoreCase(
                                                    user.getRole())) {

                                        %>


                                            <span class="role-badge admin-role">

                                                <%= user.getRole() %>

                                            </span>


                                        <%

                                            } else {

                                        %>


                                            <span class="role-badge user-role">

                                                <%= user.getRole() %>

                                            </span>


                                        <%

                                            }

                                        %>


                                    </td>



                                    <!-- STATUS -->

                                    <td>


                                        <%

                                            if ("ACTIVE".equalsIgnoreCase(
                                                    user.getStatus())) {

                                        %>


                                            <span class="status-badge active-status">

                                                <span class="status-dot"></span>

                                                <%= user.getStatus() %>

                                            </span>


                                        <%

                                            } else {

                                        %>


                                            <span class="status-badge inactive-status">

                                                <span class="status-dot"></span>

                                                <%= user.getStatus() %>

                                            </span>


                                        <%

                                            }

                                        %>


                                    </td>


                                </tr>


                            <%

                                }

                            %>


                        </tbody>

                    </table>

                </div>


            <%

                } else {

            %>


                <!-- ============================= -->
                <!-- EMPTY STATE                    -->
                <!-- ============================= -->

                <div class="empty-state">

                    <div class="empty-icon">
                        👤
                    </div>

                    <h3>
                        No Users Found
                    </h3>

                    <p>
                        There are currently no users registered in the system.
                    </p>

                </div>


            <%

                }

            %>


        </div>


        <!-- ============================= -->
        <!-- FOOTER                        -->
        <!-- ============================= -->

        <div class="footer">

            Event Room Scheduler &copy; 2026

        </div>


    </main>


</body>

</html>