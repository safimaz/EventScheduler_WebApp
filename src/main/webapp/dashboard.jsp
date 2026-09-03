<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.event.scheduler.model.User" %>

<%
    User loggedInUser =
        (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Dashboard - Event Room Scheduler</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .navbar {
            background-color: #1f2937;
            color: white;
            padding: 18px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h2 {
            margin: 0;
        }

        .user-info {
            text-align: right;
        }

        .user-info span {
            display: block;
            font-size: 14px;
        }

        .container {
            padding: 30px;
        }

        .welcome {
            margin-bottom: 25px;
        }

        .welcome h1 {
            margin-bottom: 5px;
        }

        .welcome p {
            color: #666;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
        }

        .card {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
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
            text-decoration: none;
            padding: 9px 15px;
            border-radius: 5px;
            background-color: #2563eb;
            color: white;
        }

        .logout {
            background-color: #dc2626 !important;
        }

    </style>

</head>

<body>

    <div class="navbar">

        <h2>Event Room Scheduler</h2>

        <div class="user-info">

            <span>
                <%= loggedInUser.getName() %>
            </span>

            <span>
                Role: <%= loggedInUser.getRole() %>
            </span>

        </div>

    </div>


    <div class="container">

        <div class="welcome">

            <h1>
                Welcome, <%= loggedInUser.getName() %>!
            </h1>

            <p>
                Manage meeting rooms, resources and bookings from here.
            </p>

        </div>


        <div class="cards">

            <div class="card">

                <h3>🏢 Rooms</h3>

                <p>
                    Search and view available meeting rooms.
                </p>

                <a href="rooms.jsp">
                    View Rooms
                </a>

            </div>


            <div class="card">

                <h3>📅 Book a Room</h3>

                <p>
                    Create a new room booking.
                </p>

                <a href="booking.jsp">
                    New Booking
                </a>

            </div>


            <div class="card">

                <h3>📋 My Bookings</h3>

                <p>
                    View and manage your bookings.
                </p>

                <a href="myBookings.jsp">
                    My Bookings
                </a>

            </div>


            <div class="card">

                <h3>🖥 Resources</h3>

                <p>
                    View available shared resources.
                </p>

                <a href="resources.jsp">
                    Resources
                </a>

            </div>


            <div class="card">

                <h3>🔔 Notifications</h3>

                <p>
                    View your booking notifications.
                </p>

                <a href="notifications.jsp">
                    Notifications
                </a>

            </div>


            <div class="card">

                <h3>🚪 Logout</h3>

                <p>
                    Securely sign out of your account.
                </p>

                <a href="logout" class="logout">
                    Logout
                </a>

            </div>

        </div>

    </div>

</body>
</html>