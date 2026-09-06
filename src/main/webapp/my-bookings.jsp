<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Booking" %>
<%@ page import="com.event.scheduler.model.User" %>

<%
    User loggedInUser =
        (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Booking> bookings =
        (List<Booking>) request.getAttribute("bookings");

    String successMessage =
        (String) session.getAttribute("successMessage");

    if (successMessage != null) {
        session.removeAttribute("successMessage");
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Bookings - Event Room Scheduler</title>

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

        .container {
            padding: 30px;
        }

        .back {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
        }

        .success {
            background-color: #dcfce7;
            color: #166534;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .booking-card {
            background-color: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .booking-card h2 {
            margin-top: 0;
        }

        .booking-info {
            margin: 8px 0;
        }

        .status {
            font-weight: bold;
        }

        .pending {
            color: #d97706;
        }

        .confirmed {
            color: #16a34a;
        }

        .rejected {
            color: #dc2626;
        }

        .cancelled {
            color: #6b7280;
        }

        .expired {
            color: #dc2626;
        }

        .completed {
            color: #2563eb;
        }

        .empty {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
        }

        .button {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 16px;
            background-color: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

    </style>

</head>

<body>

    <div class="navbar">

        <h2>Event Room Scheduler</h2>

        <span>
            <%= loggedInUser.getName() %>
        </span>

    </div>

    <div class="container">

        <a href="dashboard.jsp" class="back">
            ← Back to Dashboard
        </a>

        <h1>My Bookings</h1>

        <% if (successMessage != null) { %>

            <div class="success">
                <%= successMessage %>
            </div>

        <% } %>


        <%
            if (bookings != null &&
                !bookings.isEmpty()) {

                for (Booking booking : bookings) {
        %>

            <div class="booking-card">

                <h2>
                    Booking #<%= booking.getBookingId() %>
                </h2>

                <div class="booking-info">

                    <strong>Room Name:</strong>
                    <%= booking.getRoomId() %>

                </div>

                <div class="booking-info">

                    <strong>Start:</strong>
                    <%= booking.getStartTime() %>

                </div>

                <div class="booking-info">

                    <strong>End:</strong>
                    <%= booking.getEndTime() %>

                </div>

                <div class="booking-info">

                    <strong>Attendees:</strong>
                    <%= booking.getAttendeeCount() %>

                </div>

                <div class="booking-info">

                    <strong>Purpose:</strong>
                    <%= booking.getPurpose() %>

                </div>

                <div class="booking-info">

                    <strong>Status:</strong>

                    <span class="status
                        <%= booking.getStatus().toLowerCase() %>">

                        <%= booking.getStatus() %>

                    </span>

                </div>

                <div class="booking-info">

                    <strong>Created:</strong>
                    <%= booking.getCreatedAt() %>

                </div>

            </div>

        <%
                }

            } else {
        %>

            <div class="empty">

                <h2>No bookings found</h2>

                <p>
                    You haven't created any bookings yet.
                </p>

                <a href="book-room" class="button">
                    Book a Room
                </a>

            </div>

        <%
            }
        %>

    </div>

</body>

</html>