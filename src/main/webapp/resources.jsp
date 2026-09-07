<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Resource" %>

<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Resource> resources =
        (List<Resource>) request.getAttribute("resources");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Resources - EventSync</title>

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

        .navbar {
            height: 72px;
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 42px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .brand-logo {
            width: 40px;
            height: 40px;
            border-radius: 9px;
            background: #2563eb;
            color: #ffffff;
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

        .navbar-section {
            color: #64748b;
            font-size: 14px;
            font-weight: 500;
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

        .back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 26px;
            color: #64748b;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .back:hover {
            color: #2563eb;
        }

        /* =========================
           PAGE HEADER
        ========================= */

        .page-header {
            margin-bottom: 28px;
        }

        .page-header h1 {
            font-size: 30px;
            line-height: 1.2;
            font-weight: 700;
            color: #0f172a;
            letter-spacing: -0.6px;
        }

        .page-header p {
            margin-top: 8px;
            font-size: 14px;
            color: #64748b;
        }

        /* =========================
           SEARCH SECTION
        ========================= */

        .search-box {
            margin-bottom: 28px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 18px;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04);
        }

        .search-label {
            display: block;
            margin-bottom: 9px;
            font-size: 13px;
            font-weight: 600;
            color: #334155;
        }

        .search-form {
            display: flex;
            gap: 10px;
        }

        .search-box input {
            flex: 1;
            min-width: 0;
            padding: 11px 13px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            background: #ffffff;
            color: #0f172a;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s ease,
                        box-shadow 0.2s ease;
        }

        .search-box input::placeholder {
            color: #94a3b8;
        }

        .search-box input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.10);
        }

        .search-box button {
            padding: 11px 22px;
            border: none;
            border-radius: 7px;
            background: #2563eb;
            color: #ffffff;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .search-box button:hover {
            background: #1d4ed8;
        }

        /* =========================
           RESOURCE GRID
        ========================= */

        .resources {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        /* =========================
           RESOURCE CARD
        ========================= */

        .resource-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 24px;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04);
            transition: all 0.2s ease;
        }

        .resource-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.08);
            transform: translateY(-2px);
        }

        /* =========================
           RESOURCE CARD HEADER
        ========================= */

        .resource-header {
            display: flex;
            align-items: center;
            gap: 14px;
            padding-bottom: 18px;
            margin-bottom: 16px;
            border-bottom: 1px solid #f1f5f9;
        }

        .resource-icon {
            width: 42px;
            height: 42px;
            border-radius: 9px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 19px;
            flex-shrink: 0;
        }

        .resource-title {
            min-width: 0;
        }

        .resource-card h2 {
            color: #0f172a;
            font-size: 17px;
            font-weight: 700;
            line-height: 1.3;
            word-break: break-word;
        }

        .resource-subtitle {
            margin-top: 4px;
            color: #94a3b8;
            font-size: 12px;
        }

        /* =========================
           RESOURCE INFORMATION
        ========================= */

        .resource-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            padding: 10px 0;
            border-bottom: 1px solid #f8fafc;
            font-size: 14px;
        }

        .resource-info:last-child {
            border-bottom: none;
        }

        .resource-info strong {
            color: #64748b;
            font-size: 13px;
            font-weight: 500;
        }

        .resource-info {
            color: #334155;
        }

        /* =========================
           STATUS BADGES
        ========================= */

        .available,
        .maintenance,
        .inactive {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .available {
            color: #15803d;
            background: #f0fdf4;
        }

        .maintenance {
            color: #b45309;
            background: #fffbeb;
        }

        .inactive {
            color: #dc2626;
            background: #fef2f2;
        }

        .available::before,
        .maintenance::before,
        .inactive::before {
            content: "";
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
        }

        /* =========================
           EMPTY STATE
        ========================= */

        .empty-state {
            grid-column: 1 / -1;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 65px 30px;
            text-align: center;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04);
        }

        .empty-icon {
            width: 58px;
            height: 58px;
            margin: 0 auto 18px;
            border-radius: 12px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 25px;
        }

        .empty-state h2 {
            color: #0f172a;
            font-size: 20px;
            margin-bottom: 8px;
        }

        .empty-state p {
            color: #64748b;
            font-size: 14px;
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

        @media (max-width: 650px) {

            .navbar {
                padding: 0 20px;
            }

            .container {
                padding: 28px 18px 45px;
            }

            .navbar-section {
                display: none;
            }

            .search-form {
                flex-direction: column;
            }

            .search-box button {
                width: 100%;
            }

            .resources {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 450px) {

            .brand-name {
                font-size: 18px;
            }

            .page-header h1 {
                font-size: 26px;
            }

            .resource-card {
                padding: 18px;
            }

            .resource-info {
                align-items: flex-start;
            }

        }

    </style>

</head>

<body>

    <!-- =========================
         NAVBAR
    ========================= -->

    <div class="navbar">

        <div class="brand">

            <div class="brand-logo">
                ES
            </div>

            <div class="brand-name">
                EventSync
            </div>

        </div>

        <div class="navbar-section">
            Resources
        </div>

    </div>


    <!-- =========================
         MAIN CONTENT
    ========================= -->

    <div class="container">

        <a href="dashboard.jsp" class="back">
            ← Back to Dashboard
        </a>


        <div class="page-header">

            <h1>
                Shared Resources
            </h1>

            <p>
                Browse and check the availability of shared event resources.
            </p>

        </div>


        <div class="search-box">

            <span class="search-label">
                Search Resources
            </span>

            <form action="resources" method="get" class="search-form">

                <input
                    type="text"
                    name="keyword"
                    placeholder="Search resources..."
                    value="<%= request.getParameter("keyword") != null
                            ? request.getParameter("keyword")
                            : "" %>"
                >

                <button type="submit">
                    Search
                </button>

            </form>

        </div>


        <div class="resources">

        <%

            if (resources != null && !resources.isEmpty()) {

                for (Resource resource : resources) {

        %>

            <div class="resource-card">

                <div class="resource-header">

                    <div class="resource-icon">
                        ▦
                    </div>

                    <div class="resource-title">

                        <h2>
                            <%= resource.getResourceName() %>
                        </h2>

                        <div class="resource-subtitle">
                            Shared Event Resource
                        </div>

                    </div>

                </div>


                <div class="resource-info">

                    <strong>Type:</strong>

                    <span>
                        <%= resource.getResourceType() %>
                    </span>

                </div>


                <div class="resource-info">

                    <strong>Quantity:</strong>

                    <span>
                        <%= resource.getQuantity() %>
                    </span>

                </div>


                <div class="resource-info">

                    <strong>Status:</strong>

                    <span class="<%= resource.getStatus()
                        .toLowerCase() %>">

                        <%= resource.getStatus() %>

                    </span>

                </div>

            </div>

        <%

                }

            } else {

        %>

            <div class="empty-state">

                <div class="empty-icon">
                    ▦
                </div>

                <h2>
                    No resources found
                </h2>

                <p>
                    There are currently no resources matching your search.
                </p>

            </div>

        <%

            }

        %>

        </div>

    </div>


    <!-- =========================
         FOOTER
    ========================= -->

    <div class="footer">
        EventSync &nbsp;•&nbsp; Event Room & Resource Scheduler
    </div>

</body>

</html>