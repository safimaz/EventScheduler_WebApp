<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Resource" %>
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

    List<Resource> resources =
            (List<Resource>) request.getAttribute("resources");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Resource Management | EventSync</title>

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


        /* Header */

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


        /* Container */

        .container {
            max-width: 1200px;

            margin: 35px auto;

            padding: 0 20px;
        }


        /* Page Header */

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

        .add-btn:hover {
            background: #1d4ed8;
        }


        /* Messages */

        .success-message {
            background: #dcfce7;

            color: #166534;

            padding: 12px 16px;

            border-radius: 6px;

            margin-bottom: 20px;
        }

        .error-message {
            background: #fee2e2;

            color: #991b1b;

            padding: 12px 16px;

            border-radius: 6px;

            margin-bottom: 20px;
        }


        /* Resource Grid */

        .resources-grid {
            display: grid;

            grid-template-columns:
                repeat(auto-fit, minmax(300px, 1fr));

            gap: 20px;
        }


        /* Resource Card */

        .resource-card {
            background: white;

            border-radius: 10px;

            padding: 22px;

            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.08);

            display: flex;

            flex-direction: column;
        }

        .resource-card h3 {
            margin-top: 0;

            margin-bottom: 12px;

            font-size: 21px;
        }

        .resource-info {
            margin: 8px 0;

            color: #555;
        }


        /* Status */

        .status {
            display: inline-block;

            align-self: flex-start;

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


        /* Resource Actions */

        .resource-actions {
            margin-top: 20px;

            display: flex;

            gap: 10px;

            flex-wrap: wrap;
        }

        .edit-btn {
            text-decoration: none;

            background: #2563eb;

            color: white;

            padding: 9px 16px;

            border-radius: 6px;

            font-weight: bold;
        }

        .edit-btn:hover {
            background: #1d4ed8;
        }


        /* Empty */

        .empty {
            background: white;

            padding: 40px;

            text-align: center;

            border-radius: 10px;

            color: #666;
        }


        /* Mobile */

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


    <!-- Header -->

    <div class="header">

        <h1>
            EventSync Admin
        </h1>


        <a
            href="<%= request.getContextPath() %>/dashboard.jsp"
            class="back-btn">

            Dashboard

        </a>

    </div>


    <!-- Main Container -->

    <div class="container">


        <!-- Page Header -->

        <div class="page-header">

            <h2>
                Resource Management
            </h2>


            <a
                href="<%= request.getContextPath() %>/add-resource.jsp"
                class="add-btn">

                + Add Resource

            </a>

        </div>


        <!-- Flash Messages -->

        <%

            String resourceSuccessMessage =
                    (String) session.getAttribute(
                            "resourceSuccessMessage");


            String resourceErrorMessage =
                    (String) session.getAttribute(
                            "resourceErrorMessage");


            session.removeAttribute(
                    "resourceSuccessMessage");


            session.removeAttribute(
                    "resourceErrorMessage");

        %>


        <% if (resourceSuccessMessage != null) { %>

            <div class="success-message">

                <%= resourceSuccessMessage %>

            </div>

        <% } %>


        <% if (resourceErrorMessage != null) { %>

            <div class="error-message">

                <%= resourceErrorMessage %>

            </div>

        <% } %>


        <!-- Resource List -->

        <%

            if (resources == null ||
                resources.isEmpty()) {

        %>


            <div class="empty">

                <h3>
                    No resources found
                </h3>

                <p>
                    There are currently no resources
                    available in the system.
                </p>

            </div>


        <%

            } else {

        %>


            <div class="resources-grid">


                <%

                    for (Resource resource :
                            resources) {


                        String status =
                                resource.getStatus();


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


                    <!-- Resource Card -->

                    <div class="resource-card">


                        <!-- Resource Name -->

                        <h3>

                            <%= resource.getResourceName() %>

                        </h3>


                        <!-- Resource Type -->

                        <div class="resource-info">

                            <strong>
                                Type:
                            </strong>

                            <%= resource.getResourceType() %>

                        </div>


                        <!-- Quantity -->

                        <div class="resource-info">

                            <strong>
                                Quantity:
                            </strong>

                            <%= resource.getQuantity() %>

                        </div>


                        <!-- Status -->

                        <div
                            class="status <%= statusClass %>">

                            <%= status %>

                        </div>


                        <!-- Resource Actions -->

                        <div class="resource-actions">


                            <!-- Edit Resource -->

                            <a
                                href="<%= request.getContextPath() %>/edit-resource.jsp?resourceId=<%= resource.getResourceId() %>"
                                class="edit-btn">

                                Edit Resource

                            </a>


                        </div>


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