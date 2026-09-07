<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.event.scheduler.model.Room"%>
<%@ page import="com.event.scheduler.model.User"%>

<%
    // =========================
    // ADMIN LOGIN CHECK
    // =========================

    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect(
                request.getContextPath() + "/login.jsp");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(
            loggedInUser.getRole())) {

        response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Access Denied");
        return;
    }

    // Get rooms from servlet
    List<Room> rooms =
            (List<Room>) request.getAttribute("rooms");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Manage Rooms - EventSync</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            color: #333;
        }

        /* =========================
           HEADER
           ========================= */

        .header {
            background-color: #ffffff;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
        }

        .logo {
            font-size: 26px;
            font-weight: bold;
            color: #2c3e50;
        }

        .admin-info {
            font-size: 14px;
            color: #555;
        }

        /* =========================
           MAIN CONTAINER
           ========================= */

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 35px auto;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .page-header h1 {
            margin: 0;
            color: #2c3e50;
        }

        .back-btn {
            text-decoration: none;
            background-color: #2c3e50;
            color: white;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .back-btn:hover {
            background-color: #1f2d3a;
        }

        /* =========================
           ADD ROOM CARD
           ========================= */

        .card {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .card h2 {
            margin-top: 0;
            color: #2c3e50;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 6px;
            font-weight: bold;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        .add-btn {
            margin-top: 18px;
            padding: 11px 22px;
            border: none;
            border-radius: 6px;
            background-color: #27ae60;
            color: white;
            font-size: 15px;
            cursor: pointer;
        }

        .add-btn:hover {
            background-color: #219150;
        }

        /* =========================
           ROOM TABLE
           ========================= */

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #2c3e50;
            color: white;
            padding: 13px;
            text-align: left;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            vertical-align: top;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        /* =========================
           STATUS
           ========================= */

        .status {
            font-weight: bold;
        }

        /* =========================
           ACTION BUTTONS
           ========================= */

        .edit-btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .delete-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .edit-btn:hover {
            background-color: #2980b9;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        .edit-form input,
        .edit-form select {
            padding: 7px;
            width: 100%;
            margin-bottom: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .edit-form textarea {
            width: 100%;
            padding: 7px;
            margin-bottom: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .no-rooms {
            text-align: center;
            padding: 25px;
            color: #777;
        }

    </style>

</head>

<body>

<!-- =========================
     HEADER
     ========================= -->

<div class="header">

    <div class="logo">
        EventSync
    </div>

    <div class="admin-info">
        Welcome, <strong><%= loggedInUser.getName() %></strong>
        | Admin
    </div>

</div>


<!-- =========================
     MAIN CONTENT
     ========================= -->

<div class="container">

    <div class="page-header">

        <h1>Manage Rooms</h1>

        <a class="back-btn"
           href="<%= request.getContextPath() %>/admin">
            ← Back to Dashboard
        </a>

    </div>


    <!-- =========================
         ADD ROOM
         ========================= -->

    <div class="card">

        <h2>Add New Room</h2>

        <form method="post"
              action="<%= request.getContextPath() %>/admin/rooms">

            <input type="hidden"
                   name="action"
                   value="add">

            <div class="form-grid">

                <div class="form-group">

                    <label>Room Name</label>

                    <input type="text"
                           name="roomName"
                           required>

                </div>


                <div class="form-group">

                    <label>Capacity</label>

                    <input type="number"
                           name="capacity"
                           min="1"
                           required>

                </div>


                <div class="form-group">

                    <label>Location</label>

                    <input type="text"
                           name="location">

                </div>


                <div class="form-group">

                    <label>Description</label>

                    <input type="text"
                           name="description">

                </div>

            </div>

            <button type="submit"
                    class="add-btn">
                Add Room
            </button>

        </form>

    </div>


    <!-- =========================
         EXISTING ROOMS
         ========================= -->

    <div class="card">

        <h2>Existing Rooms</h2>

        <div class="table-container">

            <table>

                <thead>

                    <tr>
                        <th>ID</th>
                        <th>Room Name</th>
                        <th>Capacity</th>
                        <th>Location</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>

                </thead>

                <tbody>

                <%
                    if (rooms != null && !rooms.isEmpty()) {

                        for (Room room : rooms) {
                %>

                    <tr>

                        <td>
                            <%= room.getRoomId() %>
                        </td>

                        <td>

                            <form class="edit-form"
                                  method="post"
                                  action="<%= request.getContextPath() %>/admin/rooms">

                                <input type="hidden"
                                       name="action"
                                       value="update">

                                <input type="hidden"
                                       name="roomId"
                                       value="<%= room.getRoomId() %>">

                                <input type="text"
                                       name="roomName"
                                       value="<%= room.getRoomName() %>"
                                       required>

                        </td>

                        <td>

                                <input type="number"
                                       name="capacity"
                                       value="<%= room.getCapacity() %>"
                                       min="1"
                                       required>

                        </td>

                        <td>

                                <input type="text"
                                       name="location"
                                       value="<%= room.getLocation() == null ? "" : room.getLocation() %>">

                        </td>

                        <td>

                                <textarea name="description"
                                          rows="2"><%= room.getDescription() == null ? "" : room.getDescription() %></textarea>

                        </td>

                        <td>

                                <select name="status">

                                    <option value="AVAILABLE"
                                        <%= "AVAILABLE".equalsIgnoreCase(room.getStatus()) ? "selected" : "" %>>
                                        AVAILABLE
                                    </option>

                                    <option value="MAINTENANCE"
                                        <%= "MAINTENANCE".equalsIgnoreCase(room.getStatus()) ? "selected" : "" %>>
                                        MAINTENANCE
                                    </option>

                                    <option value="INACTIVE"
                                        <%= "INACTIVE".equalsIgnoreCase(room.getStatus()) ? "selected" : "" %>>
                                        INACTIVE
                                    </option>

                                </select>

                        </td>

                        <td>

                                <button type="submit"
                                        class="edit-btn">
                                    Update
                                </button>

                            </form>


                            <!-- DELETE FORM -->

                            <form method="post"
                                  action="<%= request.getContextPath() %>/admin/rooms"
                                  style="margin-top:8px;">

                                <input type="hidden"
                                       name="action"
                                       value="delete">

                                <input type="hidden"
                                       name="roomId"
                                       value="<%= room.getRoomId() %>">

                                <button type="submit"
                                        class="delete-btn"
                                        onclick="return confirm('Are you sure you want to delete this room?');">
                                    Delete
                                </button>

                            </form>

                        </td>

                    </tr>

                <%
                        }

                    } else {
                %>

                    <tr>

                        <td colspan="7"
                            class="no-rooms">

                            No rooms found.

                        </td>

                    </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>

</div>

</body>
</html>