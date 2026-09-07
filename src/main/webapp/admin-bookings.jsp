<%@ page import="java.util.List" %>

<%@ page import="java.util.Map" %>

<%@ page import="com.event.scheduler.model.Booking" %>

<%@ page import="com.event.scheduler.model.BookingResource" %>

<%@ page import="com.event.scheduler.model.Resource" %>

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

    Map<Integer, List<BookingResource>>
            bookingResourcesMap =
            (Map<Integer, List<BookingResource>>)
                    request.getAttribute(
                            "bookingResourcesMap");

    Map<Integer, Resource> resourcesMap =
            (Map<Integer, Resource>)
                    request.getAttribute(
                            "resourcesMap");

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

    <title>Pending Bookings - Admin | EventSync</title>

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
           HEADER
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

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 28px;
            gap: 20px;
        }

        h1 {
            font-size: 30px;
            line-height: 1.2;
            color: #0f172a;
            font-weight: 700;
            letter-spacing: -0.6px;
        }

        .subtitle {
            color: #64748b;
            margin-top: 8px;
            font-size: 14px;
            line-height: 1.5;
        }

        .admin-label {
            display: inline-flex;
            align-items: center;
            padding: 7px 12px;
            border-radius: 20px;
            background: #eff6ff;
            color: #2563eb;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }

        /* =========================
           MESSAGE
        ========================= */

        .message {
            display: flex;
            align-items: center;
            gap: 10px;
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            color: #166534;
            padding: 14px 16px;
            margin: 20px 0 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
        }

        .message-icon {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #22c55e;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 700;
            flex-shrink: 0;
        }

        /* =========================
           BOOKING LIST
        ========================= */

        .booking-list {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
        }

        /* =========================
           BOOKING CARD
        ========================= */

        .booking-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            padding: 25px;
            border-radius: 11px;
            box-shadow: 0 2px 7px rgba(15, 23, 42, 0.04);
            transition: all 0.2s ease;
        }

        .booking-card:hover {
            border-color: #cbd5e1;
            box-shadow: 0 7px 20px rgba(15, 23, 42, 0.08);
        }

        /* =========================
           BOOKING HEADER
        ========================= */

        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            padding-bottom: 18px;
            margin-bottom: 18px;
            border-bottom: 1px solid #f1f5f9;
        }

        .booking-title {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .booking-icon {
            width: 42px;
            height: 42px;
            border-radius: 9px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
            font-weight: 700;
            flex-shrink: 0;
        }

        .booking-heading h3 {
            color: #0f172a;
            font-size: 18px;
            font-weight: 700;
        }

        .booking-reference {
            color: #94a3b8;
            font-size: 12px;
            margin-top: 4px;
        }

        .status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 11px;
            border-radius: 20px;
            background: #fffbeb;
            color: #b45309;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }

        .status-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
        }

        /* =========================
           BOOKING DETAILS
        ========================= */

        .booking-details {
            display: grid;
            grid-template-columns:
                repeat(2, minmax(0, 1fr));
            gap: 0 30px;
        }

        .booking-info {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 11px 0;
            border-bottom: 1px solid #f8fafc;
            font-size: 14px;
            min-width: 0;
        }

        .booking-info strong {
            color: #64748b;
            font-size: 13px;
            font-weight: 500;
            min-width: 95px;
        }

        .booking-info-value {
            color: #334155;
            line-height: 1.4;
            word-break: break-word;
        }

        /* =========================
           RESOURCES SECTION
        ========================= */

        .resources-section {
            margin-top: 20px;
            padding: 18px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 9px;
        }

        .resources-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 13px;
        }

        .resources-icon {
            width: 32px;
            height: 32px;
            border-radius: 7px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 700;
        }

        .resources-section h4 {
            color: #0f172a;
            font-size: 14px;
            font-weight: 700;
        }

        .resource-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            padding: 11px 0;
            border-bottom: 1px solid #e2e8f0;
        }

        .resource-item:last-child {
            border-bottom: none;
        }

        .resource-name {
            color: #334155;
            font-size: 13px;
            font-weight: 600;
        }

        .resource-quantity {
            color: #64748b;
            font-size: 12px;
            margin-left: 8px;
        }

        .no-resources {
            color: #64748b;
            font-size: 13px;
            padding: 5px 0;
        }

        /* =========================
           ACTIONS
        ========================= */

        .actions {
            margin-top: 20px;
            padding-top: 18px;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .action-form {
            display: inline;
        }

        .approve-button,
        .reject-button {
            min-width: 100px;
            padding: 10px 18px;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .approve-button {
            background: #16a34a;
            color: #ffffff;
        }

        .approve-button:hover {
            background: #15803d;
        }

        .reject-button {
            background: #ffffff;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        .reject-button:hover {
            background: #fef2f2;
            border-color: #fca5a5;
        }
        
        /* =========================
   ACTION MESSAGE
========================= */

.message {
    display: flex;
    align-items: center;
    gap: 12px;
    background: #fffbeb;
    border: 1px solid #fde68a;
    color: #92400e;
    padding: 14px 16px;
    margin: 20px 0 24px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
}

.message-icon {
    width: 24px;
    height: 24px;
    border-radius: 50%;
    background: #f59e0b;
    color: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 13px;
    font-weight: 700;
    flex-shrink: 0;
}

        /* =========================
           EMPTY STATE
        ========================= */

        .empty {
            background: #ffffff;
            padding: 70px 30px;
            text-align: center;
            border: 1px solid #e2e8f0;
            border-radius: 11px;
            color: #64748b;
            box-shadow: 0 2px 7px rgba(15, 23, 42, 0.04);
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
            font-size: 14px;
            font-weight: 700;
        }

        .empty h3 {
            color: #0f172a;
            font-size: 20px;
            margin-bottom: 8px;
        }

        .empty p {
            color: #64748b;
            font-size: 14px;
            line-height: 1.5;
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

            .header {
                padding: 0 20px;
            }

            .container {
                padding: 28px 18px 45px;
            }

            .booking-details {
                grid-template-columns: 1fr;
            }

            .page-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .admin-details {
                display: none;
            }

        }

        @media (max-width: 550px) {

            .brand-name {
                font-size: 18px;
            }

            .booking-card {
                padding: 19px;
            }

            .booking-header {
                flex-direction: column;
            }

            .actions {
                flex-direction: column;
            }

            .approve-button,
            .reject-button {
                width: 100%;
            }

            .resource-item {
                align-items: flex-start;
                flex-direction: column;
                gap: 5px;
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
                ADMIN
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
            href="<%= request.getContextPath() %>/admin">

            Back to Admin Dashboard

        </a>


        <div class="page-header">

            <div>

                <h1>
                    Pending Bookings
                </h1>

                <p class="subtitle">
                    Review booking requests waiting for approval.
                </p>

            </div>

            <div class="admin-label">
                ADMIN REVIEW
            </div>

        </div>


        <%-- Admin action message --%>

        <%

            if (adminBookingMessage != null) {

        %>

            <div class="message">

		    <div class="message-icon">
		        !
		    </div>
		
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

                <div class="empty-icon">
                    EMPTY
                </div>

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

        %>

            <div class="booking-list">

        <%

                for (Booking booking : pendingBookings) {

                    int bookingId =
                            booking.getBookingId();

                    List<BookingResource>
                            bookingResources =
                            bookingResourcesMap.get(
                                    bookingId);

        %>


                <div class="booking-card">

                    <div class="booking-header">

                        <div class="booking-title">

                            <div class="booking-icon">
                                ID
                            </div>

                            <div class="booking-heading">

                                <h3>
                                    Booking #<%= bookingId %>
                                </h3>

                                <div class="booking-reference">
                                    Booking request awaiting review
                                </div>

                            </div>

                        </div>


                        <span class="status">

                            <span class="status-dot"></span>

                            <%= booking.getStatus() %>

                        </span>

                    </div>


                    <div class="booking-details">


                        <div class="booking-info">

                            <strong>
                                Room:
                            </strong>

                            <span class="booking-info-value">

                                <%= roomNames.get(
                                        booking.getRoomId()) %>

                            </span>

                        </div>


                        <div class="booking-info">

                            <strong>
                                Requested By:
                            </strong>

                            <span class="booking-info-value">

                                <%= userNames.get(
                                        booking.getUserId()) %>

                            </span>

                        </div>


                        <div class="booking-info">

                            <strong>
                                Start:
                            </strong>

                            <span class="booking-info-value">

                                <%= booking.getStartTime() %>

                            </span>

                        </div>


                        <div class="booking-info">

                            <strong>
                                End:
                            </strong>

                            <span class="booking-info-value">

                                <%= booking.getEndTime() %>

                            </span>

                        </div>


                        <div class="booking-info">

                            <strong>
                                Attendees:
                            </strong>

                            <span class="booking-info-value">

                                <%= booking.getAttendeeCount() %>

                            </span>

                        </div>


                        <div class="booking-info">

                            <strong>
                                Purpose:
                            </strong>

                            <span class="booking-info-value">

                                <%= booking.getPurpose() %>

                            </span>

                        </div>


                        <div class="booking-info">

                            <strong>
                                Created:
                            </strong>

                            <span class="booking-info-value">

                                <%= booking.getCreatedAt() %>

                            </span>

                        </div>


                        <div class="booking-info">

                            <strong>
                                Status:
                            </strong>

                            <span class="booking-info-value">

                                <%= booking.getStatus() %>

                            </span>

                        </div>


                    </div>


                    <!-- Resources -->

                    <div class="resources-section">

                        <div class="resources-header">

                            <div class="resources-icon">
                                RES
                            </div>

                            <h4>
                                Requested Resources
                            </h4>

                        </div>


                        <%

                            if (bookingResources == null ||
                                bookingResources.isEmpty()) {

                        %>

                            <div class="no-resources">

                                No additional resources requested.

                            </div>

                        <%

                            } else {

                                for (BookingResource
                                        bookingResource
                                        : bookingResources) {

                                    Resource resource =
                                            resourcesMap.get(
                                                    bookingResource
                                                            .getResourceId());

                                    if (resource != null) {

                        %>


                            <div class="resource-item">

                                <span class="resource-name">

                                    <%= resource.getResourceName() %>

                                </span>

                                <span class="resource-quantity">

                                    Quantity:

                                    <%= bookingResource.getQuantity() %>

                                </span>

                            </div>


                        <%

                                    }

                                }

                            }

                        %>

                    </div>


                    <!-- Approve / Reject -->

                    <div class="actions">


                        <!-- APPROVE -->

                        <form
                            class="action-form"
                            action="<%= request.getContextPath() %>/admin/booking-action"
                            method="post">

                            <input
                                type="hidden"
                                name="bookingId"
                                value="<%= bookingId %>">

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
                                value="<%= bookingId %>">

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

    </div>

</body>

</html>