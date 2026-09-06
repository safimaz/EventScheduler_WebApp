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

    <title>Admin Dashboard - Event Room Scheduler</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .header {
            background-color: #1f2937;
            color: white;
            padding: 18px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            margin: 0;
        }

        .admin-name {
            font-weight: bold;
        }

        .container {
            padding: 30px;
        }

        .back-link {
            color: #4f46e5;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .title {
            margin-top: 30px;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #666;
            margin-bottom: 30px;
        }

        .cards {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(220px, 1fr));

            gap: 20px;
        }

        .card {
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .card h3 {
            margin-top: 0;
        }

        .card p {
            color: #666;
        }

        .card a {
            display: inline-block;
            margin-top: 10px;
            color: #4f46e5;
            text-decoration: none;
            font-weight: bold;
        }

        .card a:hover {
            text-decoration: underline;
        }

    </style>

</head>

<body>

    <div class="header">

        <h2>Event Room Scheduler</h2>

        <div class="admin-name">
            Admin: <%= loggedInUser.getName() %>
        </div>

    </div>

    <div class="container">

        <a
            class="back-link"
            href="<%= request.getContextPath() %>/dashboard.jsp">

             Back to Dashboard

        </a>

        <h1 class="title">
            Admin Dashboard
        </h1>

        <p class="subtitle">
            Manage bookings, rooms, resources and
            system operations.
        </p>

        <div class="cards">

            <div class="card">

                <h3>Pending Bookings</h3>

                <p>
                    Review and approve or reject
                    pending booking requests.
                </p>

                <a href="<%= request.getContextPath() %>/admin/bookings">
				    Manage Bookings
				</a>

            </div>

            <div class="card">

                <h3>Rooms</h3>

                <p>
                    Manage meeting rooms and their
                    availability.
                </p>

                <a href="#">
                    Manage Rooms
                </a>

            </div>

            <div class="card">

                <h3>Resources</h3>

                <p>
                    Manage projectors, microphones,
                    laptops and other resources.
                </p>

                <a href="#">
                    Manage Resource
                </a>

            </div>

            <div class="card">

                <h3>Reports</h3>

                <p>
                    View room and resource utilization
                    information.
                </p>

                <a href="#">
                    View Reports
                </a>

            </div>

        </div>

    </div>

</body>

</html>