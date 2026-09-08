<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.event.scheduler.model.Room" %>
<%@ page import="com.event.scheduler.model.User" %>
<%@ page import="com.event.scheduler.service.RoomService" %>
<%@ page import="com.event.scheduler.service.impl.RoomServiceImpl" %>

<%
    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(
            loggedInUser.getRole())) {

        response.sendRedirect("dashboard.jsp");
        return;
    }

    String roomIdParameter =
            request.getParameter("roomId");

    if (roomIdParameter == null ||
            roomIdParameter.trim().isEmpty()) {

        response.sendRedirect("admin/rooms");
        return;
    }

    int roomId;

    try {

        roomId =
                Integer.parseInt(roomIdParameter);

    } catch (NumberFormatException e) {

        response.sendRedirect("admin/rooms");
        return;
    }

    RoomService roomService =
            new RoomServiceImpl();

    Room room =
            roomService.getRoomById(roomId);

    if (room == null) {

        response.sendRedirect("admin/rooms");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Edit Room | EventSync</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            color: #333;
        }

        .header {
            background: #1f2937;
            color: white;
            padding: 20px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
            font-size: 24px;
        }

        .back-btn {
            text-decoration: none;
            color: white;
            background: #374151;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .container {
            max-width: 700px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .form-card {
            background: white;
            padding: 30px;
            border-radius: 10px;

            box-shadow:
                0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .form-card h2 {
            margin-top: 0;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 11px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 15px;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        .submit-btn {
            border: none;
            background: #2563eb;
            color: white;
            padding: 12px 22px;
            border-radius: 6px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }

        .cancel-btn {
            text-decoration: none;
            background: #6b7280;
            color: white;
            padding: 12px 22px;
            border-radius: 6px;
            font-size: 15px;
        }

    </style>

</head>

<body>

    <div class="header">

        <h1>EventSync Admin</h1>

        <a
            href="<%= request.getContextPath() %>/admin/rooms"
            class="back-btn">

            Room Management

        </a>

    </div>


    <div class="container">

        <div class="form-card">

            <h2>Edit Room</h2>

            <form
                action="<%= request.getContextPath() %>/admin/rooms"
                method="post">

                <input
                    type="hidden"
                    name="action"
                    value="update">

                <input
                    type="hidden"
                    name="roomId"
                    value="<%= room.getRoomId() %>">


                <div class="form-group">

                    <label for="roomName">
                        Room Name
                    </label>

                    <input
                        type="text"
                        id="roomName"
                        name="roomName"
                        value="<%= room.getRoomName() %>"
                        maxlength="100"
                        required>

                </div>


                <div class="form-group">

                    <label for="capacity">
                        Capacity
                    </label>

                    <input
                        type="number"
                        id="capacity"
                        name="capacity"
                        value="<%= room.getCapacity() %>"
                        min="1"
                        required>

                </div>


                <div class="form-group">

                    <label for="location">
                        Location
                    </label>

                    <input
                        type="text"
                        id="location"
                        name="location"
                        value="<%= room.getLocation() %>"
                        maxlength="150">

                </div>


                <div class="form-group">

                    <label for="description">
                        Description
                    </label>

                    <textarea
                        id="description"
                        name="description"
                        maxlength="500"><%= room.getDescription() != null
                            ? room.getDescription()
                            : "" %></textarea>

                </div>


                <div class="form-group">

                    <label for="status">
                        Status
                    </label>

                    <select
                        id="status"
                        name="status">

                        <option
                            value="AVAILABLE"
                            <%= "AVAILABLE".equalsIgnoreCase(
                                    room.getStatus())
                                    ? "selected"
                                    : "" %>>

                            AVAILABLE

                        </option>

                        <option
                            value="MAINTENANCE"
                            <%= "MAINTENANCE".equalsIgnoreCase(
                                    room.getStatus())
                                    ? "selected"
                                    : "" %>>

                            MAINTENANCE

                        </option>

                        <option
                            value="INACTIVE"
                            <%= "INACTIVE".equalsIgnoreCase(
                                    room.getStatus())
                                    ? "selected"
                                    : "" %>>

                            INACTIVE

                        </option>

                    </select>

                </div>


                <div class="button-group">

                    <button
                        type="submit"
                        class="submit-btn">

                        Update Room

                    </button>

                    <a
                        href="<%= request.getContextPath() %>/admin/rooms"
                        class="cancel-btn">

                        Cancel

                    </a>

                </div>

            </form>

        </div>

    </div>

</body>

</html>