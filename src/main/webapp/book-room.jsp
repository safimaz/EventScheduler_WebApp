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

<title>Book a Room - Event Room Scheduler</title>

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
        align-items: center;
    }

    .container {
        max-width: 750px;
        margin: 35px auto;
        padding: 0 20px;
    }

    .booking-card {
        background-color: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
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
    select,
    textarea {
        width: 100%;
        padding: 11px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    textarea {
        resize: vertical;
        min-height: 100px;
    }

    .room-info {
        font-size: 13px;
        color: #666;
    }

    .error {
        background-color: #fee2e2;
        color: #991b1b;
        padding: 12px;
        margin-bottom: 20px;
        border-radius: 5px;
    }

    .button {
        width: 100%;
        padding: 12px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    .back {
        display: inline-block;
        margin-bottom: 20px;
        text-decoration: none;
    }
    
    .resource-row {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    padding: 12px;
	    margin-bottom: 10px;
	    background-color: #f9fafb;
	    border: 1px solid #e5e7eb;
	    border-radius: 6px;
	}
	
	.resource-row input[type="checkbox"] {
	    width: auto;
	    margin-right: 8px;
	}
	
	.resource-row input[type="number"] {
	    width: 80px;
	}
	
	.resource-quantity {
	    color: #666;
	    font-size: 13px;
	    margin-left: 8px;
	}

</style>

</head>

<body>

<div class="navbar">

    <h2>Event Room Scheduler</h2>

    <span>
        Welcome,
        <%= loggedInUser.getName() %>
    </span>

</div>

<div class="container">

    <a href="dashboard.jsp" class="back">
        ← Back to Dashboard
    </a>

    <div class="booking-card">

        <h1>Book a Room</h1>

        <p>
            Submit a booking request for an
            available meeting room.
        </p>

        <% if (errorMessage != null) { %>

            <div class="error">
                <%= errorMessage %>
            </div>

        <% } %>

        <form action="book-room" method="post">

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
            
            <div class="form-group">

    <label>
        Resources
    </label>

    <%
        if (resources != null &&
            !resources.isEmpty()) {

            for (Resource resource : resources) {
    %>

        <div class="resource-row">

            <div>

                <input
                    type="checkbox"
                    name="resourceId"
                    value="<%= resource.getResourceId() %>">

                <strong>
                    <%= resource.getResourceName() %>
                </strong>

                <span class="resource-quantity">
                    Available:
                    <%= resource.getQuantity() %>
                </span>

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
		
		        <p>
		            No resources are currently available.
		        </p>
		
		    <%
		        }
		    %>
		
		</div>

            <button
                type="submit"
                class="button">

                Submit Booking Request

            </button>

        </form>

    </div>

</div>

</body>

</html>