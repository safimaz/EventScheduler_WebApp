<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Create User - Event Room Scheduler</title>


    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }


        body {
            font-family: Arial, Helvetica, sans-serif;

            min-height: 100vh;

            background: #f5f7fb;

            color: #1f2937;
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

        .page-container {
            width: 92%;

            max-width: 650px;

            margin: 45px auto;
        }


        /* ============================= */
        /* PAGE HEADER                    */
        /* ============================= */

        .page-header {
            margin-bottom: 25px;
        }


        .page-header h1 {
            font-size: 30px;

            color: #111827;

            margin-bottom: 8px;
        }


        .page-header p {
            font-size: 14px;

            color: #6b7280;
        }


        /* ============================= */
        /* ERROR MESSAGE                  */
        /* ============================= */

        .error-message {
            display: flex;

            align-items: center;

            padding: 14px 18px;

            margin-bottom: 22px;

            background: #fef2f2;

            border: 1px solid #fecaca;

            border-radius: 8px;

            color: #991b1b;

            font-size: 14px;

            font-weight: 500;
        }


        .error-icon {
            width: 24px;

            height: 24px;

            min-width: 24px;

            display: flex;

            align-items: center;

            justify-content: center;

            margin-right: 10px;

            border-radius: 50%;

            background: #dc2626;

            color: white;

            font-size: 14px;

            font-weight: bold;
        }


        /* ============================= */
        /* FORM CARD                      */
        /* ============================= */

        .form-card {
            background: #ffffff;

            border: 1px solid #e5e7eb;

            border-radius: 12px;

            padding: 32px;

            box-shadow:
                0 4px 18px rgba(0, 0, 0, 0.05);
        }


        /* ============================= */
        /* FORM GROUP                     */
        /* ============================= */

        .form-group {
            margin-bottom: 20px;
        }


        label {
            display: block;

            margin-bottom: 8px;

            font-size: 14px;

            font-weight: 600;

            color: #374151;
        }


        /* ============================= */
        /* INPUTS                         */
        /* ============================= */

        input,
        select {

            width: 100%;

            height: 44px;

            padding: 0 13px;

            border: 1px solid #d1d5db;

            border-radius: 7px;

            background: #ffffff;

            color: #111827;

            font-size: 14px;

            outline: none;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease;
        }


        input:focus,
        select:focus {

            border-color: #2563eb;

            box-shadow:
                0 0 0 3px rgba(37, 99, 235, 0.12);
        }


        input::placeholder {
            color: #9ca3af;
        }


        select {
            cursor: pointer;
        }


        /* ============================= */
        /* BUTTON AREA                    */
        /* ============================= */

        .buttons {

            display: flex;

            align-items: center;

            gap: 12px;

            margin-top: 28px;

            padding-top: 22px;

            border-top: 1px solid #e5e7eb;
        }


        /* ============================= */
        /* CREATE BUTTON                  */
        /* ============================= */

        button {

            border: none;

            padding: 12px 20px;

            background: #2563eb;

            color: white;

            border-radius: 7px;

            font-size: 14px;

            font-weight: 600;

            cursor: pointer;

            transition:
                background 0.2s ease,
                transform 0.2s ease;
        }


        button:hover {

            background: #1d4ed8;

            transform: translateY(-1px);
        }


        button:active {

            transform: translateY(0);
        }


        /* ============================= */
        /* BACK LINK                     */
        /* ============================= */

        .back-link {

            padding: 11px 18px;

            color: #374151;

            background: #f3f4f6;

            text-decoration: none;

            border-radius: 7px;

            font-size: 14px;

            font-weight: 600;

            transition:
                background 0.2s ease;
        }


        .back-link:hover {

            background: #e5e7eb;
        }


        /* ============================= */
        /* FOOTER                         */
        /* ============================= */

        .footer {

            text-align: center;

            margin-top: 30px;

            color: #9ca3af;

            font-size: 13px;
        }


        /* ============================= */
        /* RESPONSIVE                     */
        /* ============================= */

        @media (max-width: 700px) {

            .navbar {

                padding: 0 20px;
            }


            .nav-title {

                display: none;
            }


            .page-container {

                width: 94%;

                margin: 30px auto;
            }


            .page-header h1 {

                font-size: 26px;
            }


            .form-card {

                padding: 24px 20px;
            }


            .buttons {

                flex-direction: column;

                align-items: stretch;
            }


            button,
            .back-link {

                width: 100%;

                text-align: center;
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

    <main class="page-container">


        <!-- ============================= -->
        <!-- PAGE HEADER                    -->
        <!-- ============================= -->

        <div class="page-header">

            <h1>
                Create User
            </h1>

            <p>
                Add a new user to the Event Room Scheduler.
            </p>

        </div>



        <!-- ============================= -->
        <!-- ERROR MESSAGE                  -->
        <!-- ============================= -->

        <%

            String errorMessage =
                    (String) request.getAttribute("errorMessage");

            if (errorMessage != null) {

        %>


            <div class="error-message">

                <span class="error-icon">
                    !
                </span>

                <%= errorMessage %>

            </div>


        <%

            }

        %>



        <!-- ============================= -->
        <!-- CREATE USER FORM               -->
        <!-- ============================= -->

        <div class="form-card">

            <form action="users" method="post">


                <!-- NAME -->

                <div class="form-group">

                    <label for="name">
                        Name
                    </label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Enter user's full name"
                        required>

                </div>



                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">
                        Email
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter user's email address"
                        required>

                </div>



                <!-- PASSWORD -->

                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter password"
                        required>

                </div>



                <!-- ROLE -->

                <div class="form-group">

                    <label for="role">
                        Role
                    </label>

                    <select
                        id="role"
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



                <!-- STATUS -->

                <div class="form-group">

                    <label for="status">
                        Status
                    </label>

                    <select
                        id="status"
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



                <!-- BUTTONS -->

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



        <!-- ============================= -->
        <!-- FOOTER                         -->
        <!-- ============================= -->

        <div class="footer">

            Event Room Scheduler &copy; 2026

        </div>


    </main>


</body>

</html>