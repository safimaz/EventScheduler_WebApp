<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Room" %>

<%

    if (session.getAttribute("loggedInUser") == null) {

        /*response.sendRedirect("login.jsp");*/

        request.setAttribute(
                "errorMessage",
                "Access Denied. Login is required."
            );

            request.getRequestDispatcher("/error.jsp")
                   .forward(request, response);
        
        return;

    }

    List<Room> rooms =
        (List<Room>) request.getAttribute("rooms");

%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Rooms - Event Room Scheduler</title>


    <style>

        /* =========================================
           GLOBAL
        ========================================= */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
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


        /* =========================================
           NAVBAR
        ========================================= */

        .navbar {

            height: 72px;

            background: #ffffff;

            border-bottom: 1px solid #e2e8f0;

            padding: 0 5%;

            display: flex;

            align-items: center;

            justify-content: space-between;

            position: sticky;

            top: 0;

            z-index: 1000;
        }


        /* =========================================
           LOGO
        ========================================= */

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

            color: #ffffff;

            font-size: 15px;

            font-weight: 700;
        }

        .logo span {

            color: #2563eb;
        }


        /* =========================================
           USER INFORMATION
        ========================================= */

        .user-section {

            display: flex;

            align-items: center;

            gap: 12px;
        }

        .user-info {

            text-align: right;
        }

        .user-name {

            display: block;

            color: #0f172a;

            font-size: 14px;

            font-weight: 600;
        }

        .user-label {

            display: block;

            color: #64748b;

            font-size: 11px;

            margin-top: 2px;
        }

        .user-avatar {

            width: 40px;

            height: 40px;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eff6ff;

            border: 1px solid #dbeafe;

            color: #2563eb;

            font-size: 14px;

            font-weight: 700;
        }


        /* =========================================
           MAIN CONTAINER
        ========================================= */

        .container {

            width: 90%;

            max-width: 1200px;

            margin: auto;

            padding: 38px 0 60px;
        }


        /* =========================================
           BACK BUTTON
        ========================================= */

        .back {

            display: inline-flex;

            align-items: center;

            gap: 6px;

            margin-bottom: 25px;

            color: #64748b;

            font-size: 13px;

            font-weight: 500;

            transition: 0.2s;
        }

        .back:hover {

            color: #2563eb;

            transform: translateX(-2px);
        }


        /* =========================================
           PAGE HEADER
        ========================================= */

        .page-header {

            display: flex;

            align-items: flex-end;

            justify-content: space-between;

            gap: 25px;

            margin-bottom: 30px;
        }

        .page-title h1 {

            color: #0f172a;

            font-size: 32px;

            line-height: 1.2;

            letter-spacing: -0.5px;

            margin-bottom: 7px;
        }

        .page-title p {

            color: #64748b;

            font-size: 14px;
        }

        .room-count {

            padding: 8px 13px;

            border-radius: 20px;

            background: #eff6ff;

            border: 1px solid #dbeafe;

            color: #2563eb;

            font-size: 12px;

            font-weight: 600;

            white-space: nowrap;
        }


        /* =========================================
           SEARCH SECTION
        ========================================= */

        .search-box {

            background: #ffffff;

            border: 1px solid #e2e8f0;

            border-radius: 10px;

            padding: 18px;

            margin-bottom: 30px;

            box-shadow:
                0 3px 12px rgba(15, 23, 42, 0.04);
        }

        .search-label {

            display: block;

            color: #334155;

            font-size: 12px;

            font-weight: 600;

            margin-bottom: 9px;
        }

        .search-form {

            display: flex;

            gap: 10px;
        }

        .search-box input {

            flex: 1;

            height: 44px;

            padding: 0 14px;

            border: 1px solid #cbd5e1;

            border-radius: 7px;

            outline: none;

            color: #1e293b;

            font-family: inherit;

            font-size: 14px;

            transition: 0.2s;
        }

        .search-box input::placeholder {

            color: #94a3b8;
        }

        .search-box input:focus {

            border-color: #2563eb;

            box-shadow:
                0 0 0 3px rgba(37, 99, 235, 0.10);
        }

        .search-box button {

            height: 44px;

            padding: 0 22px;

            border: none;

            border-radius: 7px;

            background: #2563eb;

            color: #ffffff;

            font-family: inherit;

            font-size: 13px;

            font-weight: 600;

            cursor: pointer;

            transition: 0.2s;
        }

        .search-box button:hover {

            background: #1d4ed8;

            transform: translateY(-1px);

            box-shadow:
                0 5px 12px rgba(37, 99, 235, 0.18);
        }


        /* =========================================
           ROOMS GRID
        ========================================= */

        .rooms {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;
        }


        /* =========================================
           ROOM CARD
        ========================================= */

        .room-card {

            background: #ffffff;

            border: 1px solid #e2e8f0;

            border-radius: 10px;

            padding: 23px;

            min-height: 255px;

            display: flex;

            flex-direction: column;

            transition: all 0.25s ease;
        }

        .room-card:hover {

            transform: translateY(-4px);

            border-color: #bfdbfe;

            box-shadow:
                0 12px 30px rgba(15, 23, 42, 0.08);
        }


        /* =========================================
           ROOM HEADER
        ========================================= */

        .room-header {

            display: flex;

            align-items: flex-start;

            justify-content: space-between;

            gap: 12px;

            padding-bottom: 16px;

            margin-bottom: 15px;

            border-bottom: 1px solid #f1f5f9;
        }

        .room-title-section {

            display: flex;

            align-items: center;

            gap: 12px;

            min-width: 0;
        }

        .room-icon {

            width: 42px;

            height: 42px;

            flex-shrink: 0;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eff6ff;

            color: #2563eb;

            border-radius: 8px;

            font-size: 18px;
        }

        .room-card h2 {

            color: #0f172a;

            font-size: 17px;

            line-height: 1.3;

            word-break: break-word;
        }


        /* =========================================
           STATUS
        ========================================= */

        .status {

            display: inline-flex;

            align-items: center;

            gap: 6px;

            padding: 5px 9px;

            border-radius: 20px;

            font-size: 10px;

            font-weight: 700;

            white-space: nowrap;
        }

        .status::before {

            content: "";

            width: 6px;

            height: 6px;

            border-radius: 50%;
        }

        .available {

            color: #059669;

            background: #ecfdf5;

            border: 1px solid #d1fae5;
        }

        .available::before {

            background: #10b981;
        }

        .maintenance {

            color: #d97706;

            background: #fffbeb;

            border: 1px solid #fde68a;
        }

        .maintenance::before {

            background: #f59e0b;
        }

        .inactive {

            color: #dc2626;

            background: #fef2f2;

            border: 1px solid #fecaca;
        }

        .inactive::before {

            background: #ef4444;
        }


        /* =========================================
           ROOM INFORMATION
        ========================================= */

        .room-info {

            display: flex;

            align-items: flex-start;

            gap: 8px;

            margin: 9px 0;

            color: #64748b;

            font-size: 13px;

            line-height: 1.5;
        }

        .room-info strong {

            color: #334155;

            font-weight: 600;

            min-width: 82px;
        }

        .description {

            margin-top: 13px;

            padding-top: 13px;

            border-top: 1px solid #f1f5f9;
        }


        /* =========================================
           EMPTY STATE
        ========================================= */

        .empty-state {

            grid-column: 1 / -1;

            background: #ffffff;

            border: 1px dashed #cbd5e1;

            border-radius: 10px;

            padding: 55px 20px;

            text-align: center;
        }

        .empty-icon {

            width: 55px;

            height: 55px;

            margin: 0 auto 15px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #f1f5f9;

            color: #64748b;

            border-radius: 50%;

            font-size: 22px;
        }

        .empty-state h3 {

            color: #334155;

            font-size: 17px;

            margin-bottom: 6px;
        }

        .empty-state p {

            color: #94a3b8;

            font-size: 13px;
        }


        /* =========================================
           FOOTER
        ========================================= */

        .footer {

            background: #020617;

            color: #94a3b8;

            padding: 24px 5%;

            border-top: 1px solid #0f172a;
        }

        .footer-content {

            width: 90%;

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


        /* =========================================
           RESPONSIVE
        ========================================= */

        @media (max-width: 1000px) {

            .rooms {

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

            .page-header {

                align-items: flex-start;

                flex-direction: column;

                margin-bottom: 25px;
            }

            .page-title h1 {

                font-size: 27px;
            }

            .search-form {

                flex-direction: column;
            }

            .search-box button {

                width: 100%;
            }

            .rooms {

                grid-template-columns: 1fr;
            }

            .room-header {

                flex-direction: column;
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

            .room-card {

                padding: 20px;
            }

        }

    </style>

</head>


<body>


    <!-- =========================================
         NAVIGATION
    ========================================== -->

    <header class="navbar">


        <!-- EVENTSYNC LOGO -->

        <a href="dashboard.jsp" class="logo">

            <div class="logo-icon">
                ES
            </div>

            Event<span>Sync</span>

        </a>


        <!-- USER INFORMATION -->

        <div class="user-section">

            <div class="user-info">

                <span class="user-name">

                    <%= session.getAttribute("loggedInUser") != null
                        ? ((com.event.scheduler.model.User)
                            session.getAttribute("loggedInUser")).getName()
                        : "" %>

                </span>

                <span class="user-label">
                    EventSync User
                </span>

            </div>


            <div class="user-avatar">

                <%= session.getAttribute("loggedInUser") != null
                    ? ((com.event.scheduler.model.User)
                        session.getAttribute("loggedInUser")).getName()
                        .substring(0, 1).toUpperCase()
                    : "" %>

            </div>

        </div>


    </header>



    <!-- =========================================
         MAIN CONTENT
    ========================================== -->

    <main>

        <div class="container">


            <!-- =====================================
                 BACK TO DASHBOARD
            ====================================== -->

            <a href="dashboard.jsp" class="back">

                ← Back to Dashboard

            </a>



            <!-- =====================================
                 PAGE HEADER
            ====================================== -->

            <div class="page-header">

                <div class="page-title">

                    <h1>
                        Meeting Rooms
                    </h1>

                    <p>
                        Search and explore available rooms
                        for your events and meetings.
                    </p>

                </div>


                <div class="room-count">

                    🏢 Room Directory

                </div>

            </div>



            <!-- =====================================
                 SEARCH
                 LOGIC UNCHANGED
            ====================================== -->

            <div class="search-box">

                <span class="search-label">
                    Find a Room
                </span>


                <form action="rooms"
                      method="get"
                      class="search-form">


                    <input
                        type="text"
                        name="keyword"
                        placeholder="Search by name, location..."
                        value="<%= request.getParameter("keyword") != null
                            ? request.getParameter("keyword")
                            : "" %>"
                    >


                    <button type="submit">

                        Search →

                    </button>


                </form>

            </div>



            <!-- =====================================
                 ROOMS
                 LOGIC UNCHANGED
            ====================================== -->

            <div class="rooms">

            <%

                if (rooms != null && !rooms.isEmpty()) {

                    for (Room room : rooms) {

            %>


                <!-- =================================
                     ROOM CARD
                ================================== -->

                <div class="room-card">


                    <div class="room-header">


                        <div class="room-title-section">


                            <div class="room-icon">
                                🏢
                            </div>


                            <h2>

                                <%= room.getRoomName() %>

                            </h2>


                        </div>


                        <div class="<%= room.getStatus()
                            .toLowerCase() %> status">

                            <%= room.getStatus() %>

                        </div>


                    </div>



                    <div class="room-info">

                        <strong>
                            Capacity:
                        </strong>

                        <span>
                            <%= room.getCapacity() %> people
                        </span>

                    </div>



                    <div class="room-info">

                        <strong>
                            Location:
                        </strong>

                        <span>
                            <%= room.getLocation() %>
                        </span>

                    </div>



                    <div class="room-info description">

                        <strong>
                            Description:
                        </strong>

                        <span>
                            <%= room.getDescription() %>
                        </span>

                    </div>


                </div>


            <%

                    }

                } else {

            %>


                <!-- =================================
                     EMPTY STATE
                ================================== -->

                <div class="empty-state">

                    <div class="empty-icon">
                        🏢
                    </div>

                    <h3>
                        No rooms found
                    </h3>

                    <p>
                        Try searching with a different
                        room name or location.
                    </p>

                </div>


            <%

                }

            %>


            </div>


        </div>

    </main>



    <!-- =========================================
         FOOTER
    ========================================== -->

    <footer class="footer">

        <div class="footer-content">

            <div class="footer-logo">

                EventSync

            </div>


            <div class="footer-text">

                © 2026 EventSync · Event & Resource
                Scheduling Platform

            </div>

        </div>

    </footer>


</body>

</html>
