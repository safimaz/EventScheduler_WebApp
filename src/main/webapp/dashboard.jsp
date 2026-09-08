<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.event.scheduler.model.User" %>

<%
    /*
     * ==========================================
     * USER SESSION VALIDATION
     * ==========================================
     */

    User loggedInUser =
        (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {

        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );

        return;
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Dashboard - EventSync</title>


    <style>

        /* ==========================================
           GLOBAL
        ========================================== */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {

            font-family: "Segoe UI", Arial, sans-serif;

            background: #f8fafc;

            color: #1e293b;

            min-height: 100vh;
        }

        a {
            text-decoration: none;
        }


        /* ==========================================
           NAVBAR
        ========================================== */

        .navbar {

            height: 72px;

            background: #ffffff;

            border-bottom: 1px solid #e2e8f0;

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 0 5%;

            position: sticky;

            top: 0;

            z-index: 1000;
        }


        /* ==========================================
           LOGO
        ========================================== */

        .logo {

            display: flex;

            align-items: center;

            gap: 10px;

            font-size: 22px;

            font-weight: 700;

            color: #0f172a;
        }

        .logo-icon {

            width: 38px;

            height: 38px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 9px;

            background: #2563eb;

            color: white;

            font-size: 15px;

            font-weight: 700;
        }

        .logo span {
            color: #2563eb;
        }


        /* ==========================================
           USER INFORMATION
        ========================================== */

        .user-section {

            display: flex;

            align-items: center;

            gap: 14px;
        }

        .user-avatar {

            width: 40px;

            height: 40px;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eff6ff;

            color: #2563eb;

            font-weight: 700;

            font-size: 15px;

            border: 1px solid #dbeafe;
        }

        .user-info {

            text-align: right;
        }

        .user-name {

            display: block;

            color: #0f172a;

            font-size: 14px;

            font-weight: 600;

            margin-bottom: 2px;
        }

        .user-role {

            display: block;

            color: #64748b;

            font-size: 12px;
        }


        /* ==========================================
           MAIN CONTAINER
        ========================================== */

        .container {

            width: 90%;

            max-width: 1200px;

            margin: auto;

            padding: 45px 0 60px;
        }


        /* ==========================================
           WELCOME SECTION
        ========================================== */

        .welcome-section {

            display: flex;

            align-items: flex-end;

            justify-content: space-between;

            margin-bottom: 35px;
        }

        .welcome-text h1 {

            font-size: 32px;

            line-height: 1.2;

            color: #0f172a;

            margin-bottom: 8px;

            letter-spacing: -0.5px;
        }

        .welcome-text h1 span {
            color: #2563eb;
        }

        .welcome-text p {

            color: #64748b;

            font-size: 15px;
        }


        /* ==========================================
           SYSTEM STATUS
        ========================================== */

        .system-status {

            display: flex;

            align-items: center;

            gap: 8px;

            padding: 8px 13px;

            border-radius: 20px;

            background: #ecfdf5;

            color: #059669;

            border: 1px solid #d1fae5;

            font-size: 12px;

            font-weight: 600;
        }

        .status-dot {

            width: 7px;

            height: 7px;

            border-radius: 50%;

            background: #10b981;
        }


        /* ==========================================
           SECTION TITLE
        ========================================== */

        .section-title {

            margin-bottom: 18px;

            color: #334155;

            font-size: 16px;

            font-weight: 600;
        }


        /* ==========================================
           DASHBOARD CARDS
        ========================================== */

        .cards {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;
        }

        .card {

            background: #ffffff;

            border: 1px solid #e2e8f0;

            border-radius: 10px;

            padding: 25px;

            min-height: 220px;

            display: flex;

            flex-direction: column;

            transition: all 0.25s ease;
        }

        .card:hover {

            transform: translateY(-4px);

            border-color: #bfdbfe;

            box-shadow:
                0 12px 30px rgba(15, 23, 42, 0.08);
        }


        /* ==========================================
           CARD ICON
        ========================================== */

        .card-icon {

            width: 46px;

            height: 46px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eff6ff;

            color: #2563eb;

            border-radius: 9px;

            font-size: 20px;

            margin-bottom: 18px;
        }


        /* ==========================================
           CARD CONTENT
        ========================================== */

        .card h3 {

            color: #0f172a;

            font-size: 17px;

            margin-bottom: 8px;

            font-weight: 650;
        }

        .card p {

            color: #64748b;

            font-size: 13px;

            line-height: 1.6;

            flex-grow: 1;

            max-width: 290px;
        }


        /* ==========================================
           CARD BUTTON
        ========================================== */

        .card a {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            align-self: flex-start;

            margin-top: 18px;

            padding: 9px 15px;

            border-radius: 6px;

            background: #2563eb;

            color: #ffffff;

            font-size: 13px;

            font-weight: 600;

            transition: all 0.2s ease;
        }

        .card a:hover {

            background: #1d4ed8;

            transform: translateY(-1px);
        }


        /* ==========================================
           LOGOUT CARD
        ========================================== */

        .logout-card:hover {

            border-color: #fecaca;
        }

        .logout {

            background: #dc2626 !important;
        }

        .logout:hover {

            background: #b91c1c !important;
        }


        /* ==========================================
           INFORMATION PANEL
        ========================================== */

        .info-panel {

            margin-top: 35px;

            background: #0f172a;

            border-radius: 12px;

            padding: 28px 30px;

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 30px;
        }

        .info-panel h2 {

            color: #ffffff;

            font-size: 19px;

            margin-bottom: 6px;
        }

        .info-panel p {

            color: #94a3b8;

            font-size: 13px;
        }

        .info-badge {

            white-space: nowrap;

            padding: 10px 17px;

            border-radius: 7px;

            background: rgba(255, 255, 255, 0.08);

            border: 1px solid rgba(255, 255, 255, 0.12);

            color: #e2e8f0;

            font-size: 12px;

            font-weight: 600;
        }


        /* ==========================================
           FOOTER
        ========================================== */

        .footer {

            background: #020617;

            color: #94a3b8;

            padding: 24px 5%;

            border-top: 1px solid #0f172a;
        }

        .footer-content {

            max-width: 1200px;

            margin: auto;

            display: flex;

            align-items: center;

            justify-content: space-between;
        }

        .footer-logo {

            color: #ffffff;

            font-size: 14px;

            font-weight: 700;
        }

        .footer-text {

            font-size: 12px;
        }


        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 950px) {

            .cards {

                grid-template-columns:
                    repeat(2, 1fr);
            }
        }


        @media (max-width: 700px) {

            .navbar {

                padding: 0 20px;
            }

            .user-info {

                display: none;
            }

            .container {

                width: 92%;

                padding-top: 30px;
            }

            .welcome-section {

                align-items: flex-start;

                flex-direction: column;

                gap: 18px;
            }

            .welcome-text h1 {

                font-size: 27px;
            }

            .cards {

                grid-template-columns: 1fr;
            }

            .info-panel {

                flex-direction: column;

                align-items: flex-start;
            }

            .footer-content {

                flex-direction: column;

                gap: 8px;

                text-align: center;
            }
        }


        @media (max-width: 450px) {

            .logo {

                font-size: 19px;
            }

            .logo-icon {

                width: 34px;

                height: 34px;
            }

            .system-status {

                font-size: 11px;
            }

            .card {

                min-height: 205px;

                padding: 22px;
            }
        }

    </style>

</head>


<body>


    <!-- ==========================================
         NAVIGATION BAR
    ========================================== -->

    <header class="navbar">


        <!-- LOGO -->

        <a href="<%= request.getContextPath() %>/dashboard.jsp"
           class="logo">

            <div class="logo-icon">
                ES
            </div>

            Event<span>Sync</span>

        </a>


        <!-- USER INFORMATION -->

        <div class="user-section">

            <div class="user-info">

                <span class="user-name">

                    <%= loggedInUser.getName() %>

                </span>

                <span class="user-role">

                    Role: <%= loggedInUser.getRole() %>

                </span>

            </div>


            <div class="user-avatar">

                <%= loggedInUser.getName()
                        .substring(0, 1)
                        .toUpperCase() %>

            </div>

        </div>

    </header>



    <!-- ==========================================
         MAIN CONTENT
    ========================================== -->

    <main>

        <div class="container">


            <!-- ======================================
                 WELCOME SECTION
            ======================================= -->

            <div class="welcome-section">

                <div class="welcome-text">

                    <h1>

                        Welcome back,

                        <span>
                            <%= loggedInUser.getName() %>
                        </span>

                    </h1>

                    <p>

                        Manage your events, rooms and resources
                        from your centralized scheduling portal.

                    </p>

                </div>


                <div class="system-status">

                    <span class="status-dot"></span>

                    System Operational

                </div>

            </div>



            <!-- ======================================
                 MANAGEMENT SECTION
            ======================================= -->

            <div class="section-title">

                Management Overview

            </div>


            <div class="cards">


                <!-- ==================================
                     ROOMS
                =================================== -->

                <div class="card">

                    <div class="card-icon">
                        🏢
                    </div>

                    <h3>
                        Rooms
                    </h3>

                    <p>

                        Search and view available meeting
                        rooms, conference halls and event spaces.

                    </p>

                    <a href="<%= request.getContextPath() %>/rooms">

                        View Rooms →

                    </a>

                </div>



                <!-- ==================================
                     BOOK A ROOM
                =================================== -->

                <div class="card">

                    <div class="card-icon">
                        📅
                    </div>

                    <h3>
                        Book a Room
                    </h3>

                    <p>

                        Create a new room booking by selecting
                        an available room, date and time.

                    </p>

                    <a href="<%= request.getContextPath() %>/book-room">

                        New Booking →

                    </a>

                </div>



                <!-- ==================================
                     MY BOOKINGS
                =================================== -->

                <div class="card">

                    <div class="card-icon">
                        📋
                    </div>

                    <h3>
                        My Bookings
                    </h3>

                    <p>

                        View, track and manage all your
                        existing room and event bookings.

                    </p>

                    <a href="<%= request.getContextPath() %>/my-bookings">

                        My Bookings →

                    </a>

                </div>



                <!-- ==================================
                     RESOURCES
                =================================== -->

                <div class="card">

                    <div class="card-icon">
                        🖥
                    </div>

                    <h3>
                        Resources
                    </h3>

                    <p>

                        View available shared resources and
                        equipment required for your events.

                    </p>

                    <a href="<%= request.getContextPath() %>/resources">

                        Resources →

                    </a>

                </div>



                <!-- ==================================
                     NOTIFICATIONS
                =================================== -->

                <div class="card">

                    <div class="card-icon">
                        🔔
                    </div>

                    <h3>
                        Notifications
                    </h3>

                    <p>

                        View booking updates, important messages
                        and notifications related to your account.

                    </p>

                    <a href="<%= request.getContextPath() %>/notifications">

                        View Notifications →

                    </a>

                </div>



                <!-- ==================================
                     SCHEDULE
                =================================== -->

                <div class="card">

                    <div class="card-icon">
                        📆
                    </div>

                    <h3>
                        Schedule
                    </h3>

                    <p>

                        View room availability, confirmed
                        bookings and daily room schedules.

                    </p>

                    <a href="<%= request.getContextPath() %>/schedule">

                        View Schedule →

                    </a>

                </div>



                <!-- ==================================
                     LOGOUT
                =================================== -->

                <div class="card logout-card">

                    <div class="card-icon">
                        🚪
                    </div>

                    <h3>
                        Logout
                    </h3>

                    <p>

                        Securely sign out of your EventSync
                        account.

                    </p>

                    <a
                        href="<%= request.getContextPath() %>/logout"
                        class="logout">

                        Logout →

                    </a>

                </div>


            </div>



            <!-- ======================================
                 INFORMATION PANEL
            ======================================= -->

            <div class="info-panel">

                <div>

                    <h2>
                        EventSync Scheduling Portal
                    </h2>

                    <p>

                        A centralized platform for managing
                        rooms, resources, bookings and schedules.

                    </p>

                </div>

                <div class="info-badge">

                    Account: <%= loggedInUser.getRole() %>

                </div>

            </div>


        </div>

    </main>



    <!-- ==========================================
         FOOTER
    ========================================== -->

    <footer class="footer">

        <div class="footer-content">

            <div class="footer-logo">

                EventSync

            </div>

            <div class="footer-text">

                Event Room &amp; Resource Scheduler

            </div>

        </div>

    </footer>


</body>

</html>