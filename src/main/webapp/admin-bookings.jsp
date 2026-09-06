<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.event.scheduler.model.Booking" %>
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

    List<Booking> pendingBookings =
            (List<Booking>) request.getAttribute(
                    "pendingBookings");
    
    Map<Integer, String> roomNames =
            (Map<Integer, String>) request.getAttribute(
                    "roomNames");

    Map<Integer, String> userNames =
            (Map<Integer, String>) request.getAttribute(
                    "userNames");

    String adminBookingMessage =
            (String) session.getAttribute(
                    "adminBookingMessage");

    if (adminBookingMessage != null) {

        session.removeAttribute(
                "adminBookingMessage");
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Pending Bookings - Admin</title>

    <style>

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

        h1 {
            margin-bottom: 10px;
        }

        .subtitle {
            color: #666;
            margin-bottom: 25px;
        }

        .message {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            margin: 20px 0;
            border-radius: 6px;
            font-weight: bold;
        }

        .booking-card {
            background-color: white;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;

            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .booking-card h3 {
            margin-top: 0;
        }

        .booking-info {
            margin: 8px 0;
        }

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 5px;

            background-color: #fff3cd;
            color: #856404;

            font-weight: bold;
        }

        .actions {
            margin-top: 20px;
            padding-top: 15px;

            border-top: 1px solid #e5e7eb;

            display: flex;
            gap: 10px;
        }

        .action-form {
            display: inline;
        }

        .approve-button,
        .reject-button {
            padding: 9px 18px;

            border: none;
            border-radius: 5px;

            cursor: pointer;

            font-size: 14px;
            font-weight: bold;
        }

        .approve-button {
            background-color: #198754;
            color: white;
        }

        .approve-button:hover {
            background-color: #157347;
        }

        .reject-button {
            background-color: #dc3545;
            color: white;
        }

        .reject-button:hover {
            background-color: #bb2d3b;
        }

        .empty {
            background-color: white;
            padding: 30px;

            text-align: center;

            border-radius: 8px;

            color: #666;
        }

    </style>

</head>

<body>

    <div class="header">

        <h2>
            Event Room Scheduler
        </h2>

        <div>

            Admin:

            <strong>
                <%= loggedInUser.getName() %>
            </strong>

        </div>

    </div>

    <div class="container">

        <a
            class="back-link"
            href="<%= request.getContextPath() %>/admin">

            ← Back to Admin Dashboard

        </a>

        <h1>
            Pending Bookings
        </h1>

        <p class="subtitle">
            Review booking requests waiting for approval.
        </p>


        <%-- Display action message --%>

        <%
            if (adminBookingMessage != null) {
        %>

            <div class="message">

                <%= adminBookingMessage %>

            </div>

        <%
            }
        %>


        <%
            if (pendingBookings == null ||
                pendingBookings.isEmpty()) {
        %>

            <div class="empty">

                <h3>
                    No Pending Bookings
                </h3>

                <p>
                    There are currently no booking
                    requests waiting for approval.
                </p>

            </div>

        <%
            } else {

                for (Booking booking : pendingBookings) {
        %>

            <div class="booking-card">

                <h3>

                    Booking #<%= booking.getBookingId() %>

                </h3>


                <div class="booking-info">

                    <strong>
					    Room:
					</strong>
					
					<%= roomNames.get(booking.getRoomId()) %>

                </div>


                <div class="booking-info">

                    <strong>
					    Requested By:
					</strong>
					
					<%= userNames.get(booking.getUserId()) %>

                </div>


                <div class="booking-info">

                    <strong>
                        Start:
                    </strong>

                    <%= booking.getStartTime() %>

                </div>


                <div class="booking-info">

                    <strong>
                        End:
                    </strong>

                    <%= booking.getEndTime() %>

                </div>


                <div class="booking-info">

                    <strong>
                        Attendees:
                    </strong>

                    <%= booking.getAttendeeCount() %>

                </div>


                <div class="booking-info">

                    <strong>
                        Purpose:
                    </strong>

                    <%= booking.getPurpose() %>

                </div>


                <div class="booking-info">

                    <strong>
                        Created:
                    </strong>

                    <%= booking.getCreatedAt() %>

                </div>


                <div class="booking-info">

                    <strong>
                        Status:
                    </strong>

                    <span class="status">

                        <%= booking.getStatus() %>

                    </span>

                </div>


                <!-- Approve / Reject Actions -->

                <div class="actions">


                    <!-- APPROVE -->

                    <form
                        class="action-form"
                        action="<%= request.getContextPath() %>/admin/booking-action"
                        method="post">

                        <input
                            type="hidden"
                            name="bookingId"
                            value="<%= booking.getBookingId() %>">

                        <input
                            type="hidden"
                            name="action"
                            value="approve">

                        <button
                            type="submit"
                            class="approve-button">

                            Approve

                        </button>

                    </form>


                    <!-- REJECT -->

                    <form
                        class="action-form"
                        action="<%= request.getContextPath() %>/admin/booking-action"
                        method="post">

                        <input
                            type="hidden"
                            name="bookingId"
                            value="<%= booking.getBookingId() %>">

                        <input
                            type="hidden"
                            name="action"
                            value="reject">

                        <button
                            type="submit"
                            class="reject-button">

                            Reject

                        </button>

                    </form>

                </div>

            </div>

        <%
                }
            }
        %>

    </div>

</body>

</html>