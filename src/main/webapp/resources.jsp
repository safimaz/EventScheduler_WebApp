<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Resource" %>

<%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Resource> resources =
        (List<Resource>) request.getAttribute("resources");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Resources - Event Room Scheduler</title>

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

        .back {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
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

        .resources {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .resource-card {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .resource-card h2 {
            margin-top: 0;
        }

        .resource-info {
            margin: 8px 0;
        }

        .available {
            color: green;
            font-weight: bold;
        }

        .maintenance {
            color: orange;
            font-weight: bold;
        }

        .inactive {
            color: red;
            font-weight: bold;
        }

    </style>

</head>

<body>

    <div class="navbar">

        <h2>Event Room Scheduler</h2>

        <span>
            Resources
        </span>

    </div>


    <div class="container">

        <a href="dashboard.jsp" class="back">
            ← Back to Dashboard
        </a>

        <h1>Shared Resources</h1>


        <div class="search-box">

            <form action="resources" method="get">

                <input
                    type="text"
                    name="keyword"
                    placeholder="Search resources..."
                    value="<%= request.getParameter("keyword") != null
                            ? request.getParameter("keyword")
                            : "" %>"
                >

                <button type="submit">
                    Search
                </button>

            </form>

        </div>


        <div class="resources">

        <%
            if (resources != null && !resources.isEmpty()) {

                for (Resource resource : resources) {
        %>

            <div class="resource-card">

                <h2>
                    <%= resource.getResourceName() %>
                </h2>

                <div class="resource-info">
                    <strong>Type:</strong>
                    <%= resource.getResourceType() %>
                </div>

                <div class="resource-info">
                    <strong>Quantity:</strong>
                    <%= resource.getQuantity() %>
                </div>

                <div class="resource-info">

                    <strong>Status:</strong>

                    <span class="<%= resource.getStatus()
                        .toLowerCase() %>">

                        <%= resource.getStatus() %>

                    </span>

                </div>

            </div>

        <%
                }

            } else {
        %>

            <p>No resources found.</p>

        <%
            }
        %>

        </div>

    </div>

</body>

</html>