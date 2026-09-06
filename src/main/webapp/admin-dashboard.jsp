<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.event.scheduler.model.User" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>

<%

    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {

        response.sendRedirect("login.jsp");

        return;

    }

    if (!"ADMIN".equalsIgnoreCase(
            loggedInUser.getRole())) {

        response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Access Denied");

        return;

    }

%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Dashboard - EventSync</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f8fafc;
            color: #0f172a;
            min-height: 100vh;
        }

        /* =========================
           NAVBAR
        ========================= */

        .header {
            height: 72px;
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            padding: 0 42px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .brand-logo {
            width: 40px;
            height: 40px;
            background: #2563eb;
            color: #ffffff;
            border-radius: 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            font-weight: 700;
        }

        .brand-name {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            letter-spacing: -0.3px;
        }

        .admin-profile {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .admin-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 700;
        }

        .admin-details {
            display: flex;
            flex-direction: column;
        }

        .admin-name {
            color: #0f172a;
            font-size: 14px;
            font-weight: 600;
        }

        .admin-role {
            color: #64748b;
            font-size: 12px;
            margin-top: 2px;
        }

        /* =========================
           MAIN CONTAINER
        ========================= */

        .container {
            max-width: 1180px;
            margin: 0 auto;
            padding: 38px 28px 60px;
        }

        /* =========================
           BACK LINK
        ========================= */

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #64748b;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 28px;
            transition: color 0.2s ease;
        }

        .back-link:hover {
            color: #2563eb;
        }

        /* =========================
           PAGE HEADER
        ========================= */

        .page-heading {
            margin-bottom: 30px;
        }

        .title {
            margin: 0;
            font-size: 30px;
            line-height: 1.2;
            color: #0f172a;
            font-weight: 700;
            letter-spacing: -0.6px;
        }

        .subtitle {
            color: #64748b;
            margin-top: 9px;
            font-size: 14px;
            line-height: 1.6;
        }

        /* =========================
           ADMIN NOTICE
        ========================= */

        .admin-banner {
            display: flex;
            align-items: center;
            gap: 13px;
            background: #eff6ff;
            border: 1px solid #dbeafe;
            border-radius: 9px;
            padding: 15px 17px;
            margin-bottom: 28px;
        }

        .admin-banner-icon {
            width: 34px;
            height: 34px;
            border-radius: 8px;
            background: #2563eb;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex-shrink: 0;
        }

        .admin-banner-text strong {
            display: block;
            color: #1e3a8a;
            font-size: 13px;
            margin-bottom: 3px;
        }

        .admin-banner-text span {
            color: #475569;
            font-size: 12px;
        }

        /* =========================
           CARDS
        ========================= */

        .cards {
            display: grid;
            grid-template-columns:
                repeat(2, minmax(0, 1fr));
            gap: 20px;
        }

        .card {
            position: relative;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 11px;
            padding: 25px;
            box-shadow: 0 2px 7px rgba(15, 23, 42, 0.04);
            transition: all 0.2s ease;
            overflow: hidden;
        }

        .card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 7px 20px rgba(15, 23, 42, 0.08);
            transform: translateY(-2px);
        }

        .card-top {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 18px;
        }

        .card-icon {
            width: 44px;
            height: 44px;
            border-radius: 9px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }

        .card h3 {
            color: #0f172a;
            font-size: 17px;
            font-weight: 700;
            margin-top: 2px;
        }

        .card p {
            color: #64748b;
            font-size: 13px;
            line-height: 1.6;
            min-height: 42px;
        }

        .card a {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            margin-top: 20px;
            padding: 9px 13px;
            border-radius: 7px;
            background: #f8fafc;
            color: #2563eb;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
        }

        .card a:hover {
            background: #2563eb;
            border-color: #2563eb;
            color: #ffffff;
        }

        .arrow {
            font-size: 15px;
            transition: transform 0.2s ease;
        }

        .card a:hover .arrow {
            transform: translateX(3px);
        }

        /* =========================
           PENDING BOOKING CARD
        ========================= */

        .pending-card {
            border-top: 3px solid #2563eb;
        }

        .pending-card .card-icon {
            background: #eff6ff;
        }

        /* =========================
           FOOTER
        ========================= */

        .footer {
            border-top: 1px solid #e2e8f0;
            background: #ffffff;
            padding: 20px 30px;
            text-align: center;
            color: #94a3b8;
            font-size: 12px;
        }

        /* =========================
           RESPONSIVE
        ========================= */

        @media (max-width: 750px) {

            .header {
                padding: 0 20px;
            }

            .container {
                padding: 28px 18px 45px;
            }

            .cards {
                grid-template-columns: 1fr;
            }

            .admin-details {
                display: none;
            }

        }

        @media (max-width: 450px) {

            .brand-name {
                font-size: 18px;
            }

            .title {
                font-size: 26px;
            }

            .card {
                padding: 21px;
            }

            .admin-banner {
                align-items: flex-start;
            }

        }

    </style>

</head>

<body>

    <!-- =========================
         HEADER
    ========================= -->

    <div class="header">

        <div class="brand">

            <div class="brand-logo">
                ES
            </div>

            <div class="brand-name">
                EventSync
            </div>

        </div>

        <div class="admin-profile">

            <div class="admin-avatar">
                <%= loggedInUser.getName().substring(0, 1).toUpperCase() %>
            </div>

            <div class="admin-details">

                <div class="admin-name">
                    Admin: <%= loggedInUser.getName() %>
                </div>

                <div class="admin-role">
                    Administrator
                </div>

            </div>

        </div>

    </div>


    <!-- =========================
         MAIN CONTENT
    ========================= -->

    <div class="container">

        <a
            class="back-link"
            href="<%= request.getContextPath() %>/dashboard.jsp">

            ← Back to Dashboard

        </a>


        <div class="page-heading">

            <h1 class="title">
                Admin Dashboard
            </h1>

            <p class="subtitle">
                Manage bookings, rooms, resources and
                system operations.
            </p>

        </div>


        <!-- ADMIN ACCESS BANNER -->

        <div class="admin-banner">

            <div class="admin-banner-icon">
                ✓
            </div>

            <div class="admin-banner-text">

                <strong>
                    Administrator Access
                </strong>

                <span>
                    You have access to system management and administrative operations.
                </span>

            </div>

        </div>


        <!-- MANAGEMENT CARDS -->

        <div class="cards">


            <div class="card pending-card">

                <div class="card-top">

                    <div class="card-icon">
                        ✓
                    </div>

                    <h3>
                        Pending Bookings
                    </h3>

                </div>

                <p>
                    Review and approve or reject
                    pending booking requests.
                </p>

                <a
                    href="<%= request.getContextPath() %>/admin/bookings">

                    Manage Bookings

                    <span class="arrow">
                        →
                    </span>

                </a>

            </div>


            <div class="card">

                <div class="card-top">

                    <div class="card-icon">
                        ▦
                    </div>

                    <h3>
                        Rooms
                    </h3>

                </div>

                <p>
                    Manage meeting rooms and their
                    availability.
                </p>

                <a href="#">

                    Manage Rooms

                    <span class="arrow">
                        →
                    </span>

                </a>

            </div>


            <div class="card">

                <div class="card-top">

                    <div class="card-icon">
                        ▤
                    </div>

                    <h3>
                        Resources
                    </h3>

                </div>

                <p>
                    Manage projectors, microphones,
                    laptops and other resources.
                </p>

                <a href="#">

                    Manage Resource

                    <span class="arrow">
                        →
                    </span>

                </a>

            </div>


            <div class="card">

                <div class="card-top">

                    <div class="card-icon">
                        ▥
                    </div>

                    <h3>
                        Reports
                    </h3>

                </div>

                <p>
                    View room and resource utilization
                    information.
                </p>

                <a href="#">

                    View Reports

                    <span class="arrow">
                        →
                    </span>

                </a>

            </div>


        </div>

    </div>


    <!-- =========================
         FOOTER
    ========================= -->

    <div class="footer">

        EventSync &nbsp;•&nbsp;
        Event Room & Resource Scheduler

    </div>

</body>

</html>