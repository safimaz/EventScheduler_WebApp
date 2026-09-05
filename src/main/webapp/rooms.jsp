<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Room" %>

<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Room> rooms =
        (List<Room>) request.getAttribute("rooms");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Rooms - Event Room Scheduler</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
        }

        .navbar {
            background-color: #1f2937;
            color: white;
            padding: 18px 30px;
            display: flex;
            justify-content: space-between;
        }

        .container {
            padding: 30px;
        }

        .search-box {
            margin-bottom: 25px;
        }

        .search-box input {
            width: 300px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-box button {
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .rooms {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .room-card {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .room-card h2 {
            margin-top: 0;
        }

        .room-info {
            margin: 8px 0;
        }

        .status {
            font-weight: bold;
        }

        .available {
            color: green;
        }

        .maintenance {
            color: orange;
        }

        .inactive {
            color: red;
        }

        .back {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
        }

    </style>

</head>

<body>

    <div class="navbar">

        <h2>Event Room Scheduler</h2>

        <span>
            <%= session.getAttribute("loggedInUser") != null
                ? ((com.event.scheduler.model.User)
                    session.getAttribute("loggedInUser")).getName()
                : "" %>
        </span>

    </div>


    <div class="container">

        <a href="dashboard.jsp" class="back">
            ← Back to Dashboard
        </a>

        <h1>Meeting Rooms</h1>

        <div class="search-box">

            <form action="rooms" method="get">

                <input
                    type="text"
                    name="keyword"
                    placeholder="Search by name, location..."
                    value="<%= request.getParameter("keyword") != null
                            ? request.getParameter("keyword")
                            : "" %>"
                >

                <button type="submit">
                    Search
                </button>

            </form>

        </div>


        <div class="rooms">

        <%
            if (rooms != null && !rooms.isEmpty()) {

                for (Room room : rooms) {
        %>

            <div class="room-card">

                <h2>
                    <%= room.getRoomName() %>
                </h2>

                <div class="room-info">
                    <strong>Capacity:</strong>
                    <%= room.getCapacity() %> people
                </div>

                <div class="room-info">
                    <strong>Location:</strong>
                    <%= room.getLocation() %>
                </div>

                <div class="room-info">
                    <strong>Description:</strong>
                    <%= room.getDescription() %>
                </div>

                <div class="room-info status">

                    <strong>Status:</strong>

                    <span class="<%= room.getStatus()
                        .toLowerCase() %>">

                        <%= room.getStatus() %>

                    </span>

                </div>

            </div>

        <%
                }

            } else {
        %>

            <p>No rooms found.</p>

        <%
            }
        %>

        </div>

    </div>

</body>
</html>