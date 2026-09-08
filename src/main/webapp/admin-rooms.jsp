<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Room" %>
<%@ page import="com.event.scheduler.model.User" %>

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

    List<Room> rooms =
            (List<Room>) request.getAttribute("rooms");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Room Management | EventSync</title>

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
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .page-header h2 {
            margin: 0;
            font-size: 28px;
        }

        .add-btn {
            text-decoration: none;
            background: #2563eb;
            color: white;
            padding: 12px 20px;
            border-radius: 6px;
            font-weight: bold;
        }

        .rooms-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .room-card {
            background: white;
            border-radius: 10px;
            padding: 22px;
            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .room-card h3 {
            margin-top: 0;
            margin-bottom: 12px;
            font-size: 21px;
        }

        .room-info {
            margin: 8px 0;
            color: #555;
        }

        .status {
            display: inline-block;
            margin-top: 12px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .available {
            background: #dcfce7;
            color: #166534;
        }

        .maintenance {
            background: #fef3c7;
            color: #92400e;
        }

        .inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        .description {
            margin-top: 15px;
            color: #666;
            line-height: 1.5;
        }

        .empty {
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 10px;
            color: #666;
        }

        @media (max-width: 600px) {

            .header {
                padding: 18px 20px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

        }

    </style>

</head>

<body>

    <div class="header">

        <h1>EventSync Admin</h1>

        <a
            href="<%= request.getContextPath() %>/dashboard.jsp"
            class="back-btn">
            Dashboard
        </a>

    </div>


    <div class="container">

        <div class="page-header">

            <h2>Room Management</h2>

            <!-- We will implement this in the next step -->
            <a href="<%= request.getContextPath() %>/add-room.jsp"
               class="add-btn">
                + Add Room
            </a>

        </div>


        <%
            if (rooms == null || rooms.isEmpty()) {
        %>

            <div class="empty">

                <h3>No rooms found</h3>

                <p>
                    There are currently no rooms
                    available in the system.
                </p>

            </div>

        <%
            } else {
        %>

            <div class="rooms-grid">

                <%
                    for (Room room : rooms) {

                        String status =
                                room.getStatus();

                        String statusClass =
                                "available";

                        if ("MAINTENANCE"
                                .equalsIgnoreCase(status)) {

                            statusClass =
                                    "maintenance";

                        } else if ("INACTIVE"
                                .equalsIgnoreCase(status)) {

                            statusClass =
                                    "inactive";
                        }
                %>

                    <div class="room-card">

                        <h3>
                            <%= room.getRoomName() %>
                        </h3>

                        <div class="room-info">

                            <strong>Capacity:</strong>

                            <%= room.getCapacity() %>
                            people

                        </div>


                        <div class="room-info">

                            <strong>Location:</strong>

                            <%= room.getLocation() %>

                        </div>


                        <div
                            class="status <%= statusClass %>">

                            <%= status %>

                        </div>


                        <%
                            if (room.getDescription()
                                    != null &&
                                !room.getDescription()
                                    .trim().isEmpty()) {
                        %>

                            <div class="description">

                                <strong>
                                    Description:
                                </strong>

                                <br>

                                <%= room.getDescription() %>

                            </div>

                        <%
                            }
                        %>

                    </div>

                <%
                    }
                %>

            </div>

        <%
            }
        %>

    </div>

</body>

</html>