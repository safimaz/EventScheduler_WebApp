<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.event.scheduler.model.Booking" %>
<%@ page import="com.event.scheduler.model.User" %>
 
<%
    User loggedInUser =
        (User) session.getAttribute("loggedInUser");
 
    if (loggedInUser == null) {
        /*response.sendRedirect("login.jsp");*/
        
        request.setAttribute(
                "errorMessage",
                "Access Denied. Login is required."
            );

            request.getRequestDispatcher("/error.jsp")
                   .forward(request, response);
        
        
        return;
    }
 
    List<Booking> bookings =
        (List<Booking>) request.getAttribute("bookings");
 
    Map<Integer, String> roomNames =
        (Map<Integer, String>) request.getAttribute("roomNames");
 
    String successMessage =
        (String) session.getAttribute("successMessage");
 
    if (successMessage != null) {
        session.removeAttribute("successMessage");
    }
 
    String errorMessage =
        (String) session.getAttribute("errorMessage");
 
    if (errorMessage != null) {
        session.removeAttribute("errorMessage");
    }
%>
 
<!DOCTYPE html>
<html>
 
<head>
 
    <meta charset="UTF-8">
 
    <title>My Bookings - EventSync</title>
 
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
            background: #2563eb;
            color: #ffffff;
            border-radius: 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 17px;
            font-weight: 700;
        }
 
        .brand-name {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            letter-spacing: -0.3px;
        }
 
        .user-section {
            display: flex;
            align-items: center;
            gap: 12px;
        }
 
        .user-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 14px;
        }
 
        .user-details {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
 
        .user-name {
            font-size: 14px;
            font-weight: 600;
            color: #0f172a;
        }
 
        .user-label {
            font-size: 12px;
            color: #64748b;
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
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 28px;
        }
 
        .page-title-section h1 {
            font-size: 30px;
            line-height: 1.2;
            font-weight: 700;
            color: #0f172a;
            letter-spacing: -0.6px;
        }
 
        .page-title-section p {
            margin-top: 8px;
            font-size: 14px;
            color: #64748b;
        }
 
        .booking-count {
            background: #eff6ff;
            color: #2563eb;
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
 
        /* =========================
           SUCCESS MESSAGE
        ========================= */
 
        .success {
            display: flex;
            align-items: center;
            gap: 10px;
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            color: #166534;
            padding: 14px 16px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-size: 14px;
        }
 
        .success-icon {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #22c55e;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 700;
            flex-shrink: 0;
        }
 
        /* =========================
           ERROR MESSAGE
        ========================= */
 
        .error {
            display: flex;
            align-items: center;
            gap: 10px;
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #991b1b;
            padding: 14px 16px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-size: 14px;
        }
 
        .error-icon {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #dc2626;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 700;
            flex-shrink: 0;
        }
 
        /* =========================
           BOOKINGS GRID
        ========================= */
 
        .bookings-list {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 20px;
        }
 
        /* =========================
           BOOKING CARD
        ========================= */
 
        .booking-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 24px;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04);
            transition: all 0.2s ease;
        }
 
        .booking-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.08);
            transform: translateY(-2px);
        }
 
        /* =========================
           BOOKING HEADER
        ========================= */
 
        .booking-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 15px;
            padding-bottom: 18px;
            margin-bottom: 18px;
            border-bottom: 1px solid #f1f5f9;
        }
 
        .booking-title {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
 
        .booking-title h2 {
            font-size: 17px;
            font-weight: 700;
            color: #0f172a;
        }
 
        .booking-reference {
            font-size: 12px;
            color: #94a3b8;
            font-weight: 500;
        }
 
        /* =========================
           STATUS
        ========================= */
 
        .status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }
 
        .status::before {
            content: "";
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
        }
 
        .pending {
            color: #b45309;
            background: #fffbeb;
        }
 
        .confirmed {
            color: #15803d;
            background: #f0fdf4;
        }
 
        .rejected {
            color: #dc2626;
            background: #fef2f2;
        }
 
        .cancelled {
            color: #64748b;
            background: #f1f5f9;
        }
 
        .expired {
            color: #dc2626;
            background: #fef2f2;
        }
 
        .completed {
            color: #2563eb;
            background: #eff6ff;
        }
 
        /* =========================
           BOOKING INFORMATION
        ========================= */
 
        .booking-info {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            padding: 9px 0;
            font-size: 14px;
            border-bottom: 1px solid #f8fafc;
            color: #334155;
        }
 
        .booking-info:last-child {
            border-bottom: none;
        }
 
        .booking-info strong {
            color: #64748b;
            font-weight: 500;
            min-width: 100px;
        }
 
        /* =========================
           CANCEL BUTTON
        ========================= */
 
        .cancel-section {
            margin-top: 20px;
            padding-top: 18px;
            border-top: 1px solid #f1f5f9;
        }
 
        .cancel-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 18px;
            background: #dc2626;
            color: #ffffff;
            border: none;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease;
        }
 
        .cancel-button:hover {
            background: #b91c1c;
        }
 
        /* =========================
           EMPTY STATE
        ========================= */
 
        .empty {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 70px 30px;
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
 
        .empty h2 {
            font-size: 20px;
            color: #0f172a;
            margin-bottom: 8px;
        }
 
        .empty p {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 24px;
        }
 
        /* =========================
           BUTTON
        ========================= */
 
        .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 18px;
            background: #2563eb;
            color: #ffffff;
            text-decoration: none;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
            transition: background 0.2s ease;
        }
 
        .button:hover {
            background: #1d4ed8;
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
 
        @media (max-width: 800px) {
 
            .navbar {
                padding: 0 20px;
            }
 
            .container {
                padding: 28px 18px 45px;
            }
 
            .bookings-list {
                grid-template-columns: 1fr;
            }
 
            .page-header {
                align-items: flex-start;
                gap: 15px;
                flex-direction: column;
            }
 
        }
 
        @media (max-width: 500px) {
 
            .brand-name {
                font-size: 18px;
            }
 
            .user-details {
                display: none;
            }
 
            .booking-card {
                padding: 18px;
            }
 
            .booking-header {
                flex-direction: column;
            }
 
            .booking-info {
                flex-direction: column;
                gap: 3px;
            }
 
            .page-title-section h1 {
                font-size: 26px;
            }
 
            .cancel-button {
                width: 100%;
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
 
        <div class="user-section">
 
            <div class="user-avatar">
<%= loggedInUser.getName()
                        .substring(0, 1)
                        .toUpperCase() %>
</div>
 
            <div class="user-details">
 
                <div class="user-name">
<%= loggedInUser.getName() %>
</div>
 
                <div class="user-label">
                    Event Scheduler
</div>
 
            </div>
 
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
 
            <div class="page-title-section">
 
                <h1>My Bookings</h1>
 
                <p>
                    View and track all the rooms you have booked.
</p>
 
            </div>
 
            <%
                if (bookings != null) {
            %>
 
                <div class="booking-count">
<%= bookings.size() %> Booking(s)
</div>
 
            <%
                }
            %>
 
        </div>
 
 
        <!-- =========================
             SUCCESS MESSAGE
        ========================= -->
 
        <% if (successMessage != null) { %>
 
            <div class="success">
 
                <div class="success-icon">
                    ✓
</div>
 
                <%= successMessage %>
 
            </div>
 
        <% } %>
 
 
        <!-- =========================
             ERROR MESSAGE
        ========================= -->
 
        <% if (errorMessage != null) { %>
 
            <div class="error">
 
                <div class="error-icon">
                    !
</div>
 
                <%= errorMessage %>
 
            </div>
 
        <% } %>
 
 
        <%
            if (bookings != null &&
                !bookings.isEmpty()) {
        %>
 
            <div class="bookings-list">
 
            <%
                for (Booking booking : bookings) {
            %>
 
                <div class="booking-card">
 
                    <!-- =========================
                         BOOKING HEADER
                    ========================= -->
 
                    <div class="booking-header">
 
                        <div class="booking-title">
 
                            <h2>
                                Booking #<%= booking.getBookingId() %>
</h2>
 
                            <div class="booking-reference">
                                Event Room Reservation
</div>
 
                        </div>
 
                        <span class="status
<%= booking.getStatus()
                                    .toLowerCase() %>">
 
                            <%= booking.getStatus() %>
 
                        </span>
 
                    </div>
 
 
                    <!-- =========================
                         ROOM
                    ========================= -->
 
                    <div class="booking-info">
 
                        <strong>Room Name:</strong>
 
                        <span>
<%= roomNames.get(
                                    booking.getRoomId()) %>
</span>
 
                    </div>
 
 
                    <!-- =========================
                         START TIME
                    ========================= -->
 
                    <div class="booking-info">
 
                        <strong>Start:</strong>
 
                        <span>
<%= booking.getStartTime() %>
</span>
 
                    </div>
 
 
                    <!-- =========================
                         END TIME
                    ========================= -->
 
                    <div class="booking-info">
 
                        <strong>End:</strong>
 
                        <span>
<%= booking.getEndTime() %>
</span>
 
                    </div>
 
 
                    <!-- =========================
                         ATTENDEES
                    ========================= -->
 
                    <div class="booking-info">
 
                        <strong>Attendees:</strong>
 
                        <span>
<%= booking.getAttendeeCount() %>
</span>
 
                    </div>
 
 
                    <!-- =========================
                         PURPOSE
                    ========================= -->
 
                    <div class="booking-info">
 
                        <strong>Purpose:</strong>
 
                        <span>
<%= booking.getPurpose() %>
</span>
 
                    </div>
 
 
                    <!-- =========================
                         STATUS
                    ========================= -->
 
                    <div class="booking-info">
 
                        <strong>Status:</strong>
 
                        <span class="status
<%= booking.getStatus()
                                    .toLowerCase() %>">
 
                            <%= booking.getStatus() %>
 
                        </span>
 
                    </div>
 
 
                    <!-- =========================
                         CREATED TIME
                    ========================= -->
 
                    <div class="booking-info">
 
                        <strong>Created:</strong>
 
                        <span>
<%= booking.getCreatedAt() %>
</span>
 
                    </div>
 
 
                    <!-- =========================
                         CANCEL BOOKING
                    ========================= -->
 
                    <%
                        String bookingStatus =
                                booking.getStatus();
 
                        boolean canCancel =
                                "PENDING".equalsIgnoreCase(
                                        bookingStatus)
                                ||
                                "CONFIRMED".equalsIgnoreCase(
                                        bookingStatus);
                    %>
 
                    <% if (canCancel) { %>
 
                        <div class="cancel-section">
 
                            <form action="my-bookings"
                                  method="post">
 
                                <input type="hidden"
                                       name="bookingId"
                                       value="<%= booking.getBookingId() %>">
 
                                <button type="submit"
                                        class="cancel-button"
                                        onclick="return confirm(
                                            'Are you sure you want to cancel Booking #<%= booking.getBookingId() %>?'
                                        );">
 
                                    Cancel Booking
 
                                </button>
 
                            </form>
 
                        </div>
 
                    <% } %>
 
                </div>
 
            <%
                }
            %>
 
            </div>
 
        <%
            } else {
        %>
 
            <!-- =========================
                 EMPTY STATE
            ========================= -->
 
            <div class="empty">
 
                <div class="empty-icon">
                    📅
</div>
 
                <h2>
                    No bookings found
</h2>
 
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
 
 
    <!-- =========================
         FOOTER
    ========================= -->
 
    <div class="footer">
 
        EventSync &nbsp;•&nbsp;
        Event Room & Resource Scheduler
 
    </div>
 
</body>
 
</html>