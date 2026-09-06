<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Room" %>
<%@ page import="com.event.scheduler.model.User" %>
<%@ page import="com.event.scheduler.model.Resource" %>

<%
    User loggedInUser =
        (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Room> rooms =
        (List<Room>) request.getAttribute("rooms");

    List<Resource> resources =
        (List<Resource>) request.getAttribute("resources");

    String errorMessage =
        (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Book a Room - EventSync</title>

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
        justify-content: space-between;
        align-items: center;
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
        font-size: 16px;
        font-weight: 700;
    }

    .brand-name {
        font-size: 20px;
        font-weight: 700;
        color: #0f172a;
        letter-spacing: -0.3px;
    }

    .welcome {
        display: flex;
        align-items: center;
        gap: 10px;
        color: #64748b;
        font-size: 14px;
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
        font-size: 14px;
        font-weight: 700;
    }

    /* =========================
       MAIN CONTAINER
    ========================= */

    .container {
        max-width: 850px;
        margin: 0 auto;
        padding: 38px 25px 60px;
    }

    /* =========================
       BACK LINK
    ========================= */

    .back {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 24px;
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
       BOOKING CARD
    ========================= */

    .booking-card {
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        padding: 32px;
        box-shadow: 0 3px 10px rgba(15, 23, 42, 0.05);
    }

    /* =========================
       PAGE HEADER
    ========================= */

    .booking-header {
        display: flex;
        align-items: flex-start;
        gap: 16px;
        padding-bottom: 25px;
        margin-bottom: 28px;
        border-bottom: 1px solid #e2e8f0;
    }

    .header-icon {
        width: 48px;
        height: 48px;
        flex-shrink: 0;
        border-radius: 10px;
        background: #eff6ff;
        color: #2563eb;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 22px;
    }

    .booking-header h1 {
        font-size: 27px;
        line-height: 1.2;
        color: #0f172a;
        font-weight: 700;
        letter-spacing: -0.5px;
    }

    .booking-header p {
        margin-top: 7px;
        color: #64748b;
        font-size: 14px;
        line-height: 1.5;
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
        padding: 13px 15px;
        margin-bottom: 24px;
        border-radius: 8px;
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
       FORM
    ========================= */

    .form-group {
        margin-bottom: 23px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        color: #334155;
        font-size: 14px;
        font-weight: 600;
    }

    input,
    select,
    textarea {
        width: 100%;
        padding: 11px 13px;
        border: 1px solid #cbd5e1;
        border-radius: 7px;
        background: #ffffff;
        color: #0f172a;
        font-family: Arial, Helvetica, sans-serif;
        font-size: 14px;
        outline: none;
        transition: border-color 0.2s ease,
                    box-shadow 0.2s ease;
    }

    input:focus,
    select:focus,
    textarea:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.10);
    }

    input::placeholder,
    textarea::placeholder {
        color: #94a3b8;
    }

    textarea {
        resize: vertical;
        min-height: 110px;
        line-height: 1.5;
    }

    select {
        cursor: pointer;
    }

    /* =========================
       DATE / ATTENDEE GRID
    ========================= */

    .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 18px;
    }

    /* =========================
       ROOM INFORMATION
    ========================= */

    .room-info {
        margin-top: 7px;
        font-size: 12px;
        color: #64748b;
    }

    /* =========================
       RESOURCES SECTION
    ========================= */

    .resources-section {
        margin-top: 4px;
    }

    .resource-description {
        margin-bottom: 12px;
        color: #64748b;
        font-size: 12px;
    }

    .resource-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
        padding: 14px 15px;
        margin-bottom: 10px;
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        transition: border-color 0.2s ease,
                    background 0.2s ease;
    }

    .resource-row:hover {
        background: #ffffff;
        border-color: #cbd5e1;
    }

    .resource-left {
        display: flex;
        align-items: center;
        gap: 11px;
        min-width: 0;
    }

    .resource-row input[type="checkbox"] {
        width: 17px;
        height: 17px;
        margin: 0;
        accent-color: #2563eb;
        cursor: pointer;
        flex-shrink: 0;
    }

    .resource-name {
        color: #0f172a;
        font-size: 14px;
        font-weight: 600;
    }

    .resource-quantity {
        color: #64748b;
        font-size: 12px;
        margin-left: 7px;
    }

    .resource-row input[type="number"] {
        width: 80px;
        padding: 8px 10px;
        text-align: center;
    }

    /* =========================
       NO RESOURCES
    ========================= */

    .no-resources {
        padding: 16px;
        border: 1px dashed #cbd5e1;
        border-radius: 8px;
        background: #f8fafc;
        color: #64748b;
        font-size: 13px;
        text-align: center;
    }

    /* =========================
       SUBMIT BUTTON
    ========================= */

    .button {
        width: 100%;
        padding: 13px 18px;
        margin-top: 4px;
        border: none;
        border-radius: 7px;
        background: #2563eb;
        color: #ffffff;
        cursor: pointer;
        font-size: 15px;
        font-weight: 600;
        transition: background 0.2s ease,
                    transform 0.1s ease;
    }

    .button:hover {
        background: #1d4ed8;
    }

    .button:active {
        transform: translateY(1px);
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

        .booking-card {
            padding: 23px 18px;
        }

        .form-row {
            grid-template-columns: 1fr;
            gap: 0;
        }

        .welcome-text {
            display: none;
        }

        .resource-row {
            align-items: flex-start;
        }
    }

    @media (max-width: 450px) {

        .brand-name {
            font-size: 18px;
        }

        .booking-header h1 {
            font-size: 24px;
        }

        .resource-row {
            flex-direction: column;
            gap: 12px;
        }

        .resource-row input[type="number"] {
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

    <div class="welcome">

        <div class="user-avatar">
            <%= loggedInUser.getName().substring(0, 1).toUpperCase() %>
        </div>

        <span class="welcome-text">
            Welcome, <%= loggedInUser.getName() %>
        </span>

    </div>

</div>


<!-- =========================
     MAIN CONTENT
========================= -->

<div class="container">

    <a href="dashboard.jsp" class="back">
        ← Back to Dashboard
    </a>


    <div class="booking-card">

        <div class="booking-header">

            <div class="header-icon">
                📅
            </div>

            <div>

                <h1>
                    Book a Room
                </h1>

                <p>
                    Submit a booking request for an
                    available meeting room.
                </p>

            </div>

        </div>


        <% if (errorMessage != null) { %>

            <div class="error">

                <div class="error-icon">
                    !
                </div>

                <%= errorMessage %>

            </div>

        <% } %>


        <form action="book-room" method="post">


            <!-- ROOM -->

            <div class="form-group">

                <label>
                    Select Room
                </label>

                <select name="roomId" required>

                    <option value="">
                        -- Select Room --
                    </option>

                    <%

                        if (rooms != null) {

                            for (Room room : rooms) {

                    %>

                        <option
                            value="<%= room.getRoomId() %>">

                            <%= room.getRoomName() %>
                            -
                            Capacity:
                            <%= room.getCapacity() %>
                            -
                            <%= room.getLocation() %>

                        </option>

                    <%

                            }

                        }

                    %>

                </select>

            </div>


            <!-- DATE AND TIME -->

            <div class="form-row">

                <div class="form-group">

                    <label>
                        Start Date & Time
                    </label>

                    <input
                        type="datetime-local"
                        name="startTime"
                        required>

                </div>


                <div class="form-group">

                    <label>
                        End Date & Time
                    </label>

                    <input
                        type="datetime-local"
                        name="endTime"
                        required>

                </div>

            </div>


            <!-- ATTENDEES -->

            <div class="form-group">

                <label>
                    Number of Attendees
                </label>

                <input
                    type="number"
                    name="attendeeCount"
                    min="1"
                    required>

            </div>


            <!-- PURPOSE -->

            <div class="form-group">

                <label>
                    Purpose
                </label>

                <textarea
                    name="purpose"
                    maxlength="500"
                    placeholder="Enter purpose of booking..."
                    required></textarea>

            </div>


            <!-- RESOURCES -->

            <div class="form-group resources-section">

                <label>
                    Resources
                </label>

                <div class="resource-description">
                    Select any additional resources required for your booking.
                </div>

                <%

                    if (resources != null &&
                        !resources.isEmpty()) {

                        for (Resource resource : resources) {

                %>

                    <div class="resource-row">

                        <div class="resource-left">

                            <input
                                type="checkbox"
                                name="resourceId"
                                value="<%= resource.getResourceId() %>">

                            <div>

                                <strong class="resource-name">
                                    <%= resource.getResourceName() %>
                                </strong>

                                <span class="resource-quantity">
                                    Available:
                                    <%= resource.getQuantity() %>
                                </span>

                            </div>

                        </div>


                        <div>

                            <input
                                type="number"
                                name="resourceQuantity_<%= resource.getResourceId() %>"
                                min="1"
                                max="<%= resource.getQuantity() %>"
                                value="1">

                        </div>

                    </div>

                <%

                        }

                    } else {

                %>

                    <div class="no-resources">

                        No resources are currently available.

                    </div>

                <%

                    }

                %>

            </div>


            <!-- SUBMIT -->

            <button
                type="submit"
                class="button">

                Submit Booking Request

            </button>


        </form>

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