<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="com.event.scheduler.model.Booking" %>
<%@ page import="com.event.scheduler.model.User" %>

<%
    User loggedInUser =
        (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    LocalDate selectedDate =
        (LocalDate) request.getAttribute("selectedDate");

    List<Booking> bookings =
        (List<Booking>) request.getAttribute("bookings");

    if (selectedDate == null) {
        selectedDate = LocalDate.now();
    }

    if (bookings == null) {
        bookings = new java.util.ArrayList<>();
    }

    String errorMessage =
        (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Schedule - EventSync</title>

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
        }

        .user-name {
            font-size: 14px;
            font-weight: 600;
        }

        .user-label {
            font-size: 12px;
            color: #64748b;
            margin-top: 2px;
        }

        /* =========================
           CONTAINER
        ========================= */

        .container {
            max-width: 1250px;
            margin: 0 auto;
            padding: 38px 28px 60px;
        }

        /* =========================
           BACK
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
        }

        .back:hover {
            color: #2563eb;
        }

        /* =========================
           HEADER
        ========================= */

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 28px;
        }

        .page-title-section h1 {
            font-size: 30px;
            font-weight: 700;
        }

        .page-title-section p {
            margin-top: 8px;
            font-size: 14px;
            color: #64748b;
        }

        /* =========================
           DATE SELECTOR
        ========================= */

        .date-form {
            display: flex;
            align-items: center;
            gap: 10px;
            background: #ffffff;
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
        }

        .date-form label {
            font-size: 13px;
            font-weight: 600;
            color: #475569;
        }

        .date-input {
            padding: 9px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
            color: #0f172a;
        }

        .view-button {
            padding: 9px 16px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: #ffffff;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        .view-button:hover {
            background: #1d4ed8;
        }

        /* =========================
           ERROR
        ========================= */

        .error {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #991b1b;
            padding: 14px 16px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-size: 14px;
        }

        /* =========================
           DATE DISPLAY
        ========================= */

        .schedule-date {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 18px 20px;
            margin-bottom: 20px;
        }

        .schedule-date strong {
            font-size: 15px;
        }

        .schedule-date span {
            color: #64748b;
            font-size: 14px;
            margin-left: 8px;
        }

        /* =========================
           LEGEND
        ========================= */

        .legend {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 7px;
            font-size: 13px;
            color: #475569;
        }

        .legend-box {
            width: 14px;
            height: 14px;
            border-radius: 4px;
        }

        .available-box {
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
        }

        .occupied-box {
            background: #fef2f2;
            border: 1px solid #fecaca;
        }

        /* =========================
           SCHEDULE TABLE
        ========================= */

        .schedule-wrapper {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            overflow-x: auto;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04);
        }

        .schedule-table {
            width: 100%;
            min-width: 1100px;
            border-collapse: collapse;
        }

        .schedule-table th {
            background: #f8fafc;
            padding: 14px 12px;
            border-bottom: 1px solid #e2e8f0;
            border-right: 1px solid #f1f5f9;
            font-size: 12px;
            color: #475569;
            text-align: center;
        }

        .schedule-table th.room-column {
            min-width: 180px;
            text-align: left;
            padding-left: 20px;
        }

        .schedule-table td {
            padding: 8px;
            border-bottom: 1px solid #f1f5f9;
            border-right: 1px solid #f1f5f9;
            text-align: center;
            vertical-align: middle;
            height: 75px;
        }

        .room-name {
            text-align: left !important;
            padding-left: 20px !important;
            font-weight: 600;
            color: #0f172a;
        }

        /* =========================
           SLOT
        ========================= */

        .slot {
            min-height: 55px;
            border-radius: 7px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 7px;
            font-size: 11px;
        }

        .available {
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            color: #15803d;
        }

        .occupied {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #b91c1c;
        }

        .slot-title {
            font-weight: 700;
        }

        .slot-time {
            margin-top: 3px;
            font-size: 10px;
        }

        /* =========================
           EMPTY
        ========================= */

        .empty {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 50px 30px;
            text-align: center;
        }

        .empty h2 {
            font-size: 20px;
            margin-bottom: 8px;
        }

        .empty p {
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

        @media (max-width: 850px) {

            .navbar {
                padding: 0 20px;
            }

            .container {
                padding: 28px 18px 45px;
            }

            .page-header {
                align-items: flex-start;
                flex-direction: column;
                gap: 20px;
            }

            .date-form {
                width: 100%;
                flex-wrap: wrap;
            }

        }

        @media (max-width: 500px) {

            .user-details {
                display: none;
            }

            .brand-name {
                font-size: 18px;
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

                <h1>Room Schedule</h1>

                <p>
                    View room availability and confirmed bookings.
                </p>

            </div>


            <!-- DATE SELECTOR -->

            <form action="schedule"
                  method="get"
                  class="date-form">

                <label for="date">
                    Select Date:
                </label>

                <input type="date"
                       id="date"
                       name="date"
                       class="date-input"
                       value="<%= selectedDate %>"
                       required>

                <button type="submit"
                        class="view-button">
                    View Schedule
                </button>

            </form>

        </div>


        <!-- =========================
             ERROR MESSAGE
        ========================= -->

        <% if (errorMessage != null) { %>

            <div class="error">
                <%= errorMessage %>
            </div>

        <% } %>


        <!-- =========================
             SELECTED DATE
        ========================= -->

        <div class="schedule-date">

            <strong>
                Schedule for:
            </strong>

            <span>
                <%= selectedDate %>
            </span>

        </div>


        <!-- =========================
             LEGEND
        ========================= -->

        <div class="legend">

            <div class="legend-item">

                <div class="legend-box available-box"></div>

                Available

            </div>

            <div class="legend-item">

                <div class="legend-box occupied-box"></div>

                Occupied

            </div>

        </div>


        <%
            if (bookings.isEmpty()) {
        %>

            <!-- =========================
                 NO BOOKINGS
            ========================= -->

            <div class="empty">

                <h2>
                    No confirmed bookings
                </h2>

                <p>
                    There are no confirmed room bookings
                    for the selected date.
                </p>

            </div>

        <%
            } else {
        %>

            <!-- =========================
                 SCHEDULE TABLE
            ========================= -->

            <div class="schedule-wrapper">

                <table class="schedule-table">

                    <thead>

                        <tr>

                            <th class="room-column">
                                Room
                            </th>

                            <th>
                                09:00 - 10:00
                            </th>

                            <th>
                                10:00 - 11:00
                            </th>

                            <th>
                                11:00 - 12:00
                            </th>

                            <th>
                                12:00 - 13:00
                            </th>

                            <th>
                                13:00 - 14:00
                            </th>

                            <th>
                                14:00 - 15:00
                            </th>

                            <th>
                                15:00 - 16:00
                            </th>

                            <th>
                                16:00 - 17:00
                            </th>
                            
                            <th>
                                17:00 - 18:00
                            </th>
                            
                            <th>
                                18:00 - 19:00
                            </th>
                            
                            <th>
                                19:00 - 20:00
                            </th>
                            

                        </tr>

                    </thead>

                    <tbody>

                        <%
                            java.util.Set<Integer> roomIds =
                                new java.util.LinkedHashSet<>();

                            for (Booking booking : bookings) {
                                roomIds.add(
                                    booking.getRoomId()
                                );
                            }

                            for (Integer roomId : roomIds) {
                        %>

                            <tr>

                                <td class="room-name">

                                    Room #<%= roomId %>

                                </td>


                                <%
                                    for (int hour = 9;
                                         hour < 20;
                                         hour++) {

                                        LocalDateTime slotStart =
                                            selectedDate
                                                .atTime(hour, 0);

                                        LocalDateTime slotEnd =
                                            selectedDate
                                                .atTime(hour + 1, 0);

                                        Booking occupiedBooking =
                                            null;

                                        for (Booking booking :
                                                bookings) {

                                            if (booking.getRoomId()
                                                    == roomId) {

                                                LocalDateTime
                                                    bookingStart =
                                                        booking
                                                            .getStartTime();

                                                LocalDateTime
                                                    bookingEnd =
                                                        booking
                                                            .getEndTime();

                                                if (bookingStart
                                                        .isBefore(
                                                            slotEnd)
                                                    &&
                                                    bookingEnd
                                                        .isAfter(
                                                            slotStart)) {

                                                    occupiedBooking =
                                                        booking;

                                                    break;
                                                }
                                            }
                                        }
                                %>

                                    <td>

                                        <%
                                            if (occupiedBooking
                                                    != null) {
                                        %>

                                            <div class="slot occupied">

                                                <div class="slot-title">
                                                    BOOKED
                                                </div>

                                                <div class="slot-time">

                                                    <%= occupiedBooking
                                                            .getStartTime()
                                                            .toLocalTime() %>

                                                    -

                                                    <%= occupiedBooking
                                                            .getEndTime()
                                                            .toLocalTime() %>

                                                </div>

                                            </div>

                                        <%
                                            } else {
                                        %>

                                            <div class="slot available">

                                                <div class="slot-title">
                                                    AVAILABLE
                                                </div>

                                            </div>

                                        <%
                                            }
                                        %>

                                    </td>

                                <%
                                    }
                                %>

                            </tr>

                        <%
                            }
                        %>

                    </tbody>

                </table>

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