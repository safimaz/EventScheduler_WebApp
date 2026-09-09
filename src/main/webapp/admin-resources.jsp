<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Resource" %>
<%@ page import="com.event.scheduler.model.User" %>

<%
    // =========================
    // ADMIN SESSION CHECK
    // =========================

    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null ||
            !"ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {

    	request.setAttribute(
                "errorMessage",
                "Access Denied. Admin Login is required."
            );

            request.getRequestDispatcher("/error.jsp")
                   .forward(request, response);
    	
    	
    	/*
        response.sendRedirect(
                request.getContextPath() + "/login.jsp");
		*/
        return;
    }

    // =========================
    // RESOURCE DATA
    // =========================

    List<Resource> resources =
            (List<Resource>) request.getAttribute("resources");

    // =========================
    // FLASH MESSAGES
    // =========================

    String successMessage =
            (String) session.getAttribute("resourceSuccessMessage");

    String errorMessage =
            (String) session.getAttribute("resourceErrorMessage");

    session.removeAttribute("resourceSuccessMessage");
    session.removeAttribute("resourceErrorMessage");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Resource Management - EventSync</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            color: #1f2937;
        }

        /* =========================
           HEADER
           ========================= */

        .header {
            background: #1e293b;
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
            background: #475569;
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #334155;
        }

        /* =========================
           MAIN CONTAINER
           ========================= */

        .container {
            max-width: 1200px;
            margin: 40px auto;
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

        /* =========================
           ADD RESOURCE BUTTON
           ========================= */

        .add-btn {
            text-decoration: none;
            background: #16a34a;
            color: white;
            padding: 11px 18px;
            border-radius: 6px;
            font-weight: bold;
        }

        .add-btn:hover {
            background: #15803d;
        }

        /* =========================
           FLASH MESSAGES
           ========================= */

        .success-message {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #86efac;
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .error-message {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        /* =========================
           RESOURCE GRID
           ========================= */

        .resource-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(300px, 1fr));

            gap: 20px;
        }

        /* =========================
           RESOURCE CARD
           ========================= */

        .resource-card {
            background: white;
            border-radius: 10px;
            padding: 22px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s ease;
        }

        .resource-card:hover {
            transform: translateY(-3px);
        }

        .resource-card h3 {
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 21px;
        }

        .resource-details {
            margin-bottom: 15px;
        }

        .resource-details p {
            margin: 8px 0;
            font-size: 15px;
        }

        .label {
            font-weight: bold;
        }

        /* =========================
           STATUS
           ========================= */

        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .status-available {
            background: #dcfce7;
            color: #166534;
        }

        .status-maintenance {
            background: #fef3c7;
            color: #92400e;
        }

        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        /* =========================
           RESOURCE ACTIONS
           ========================= */

        .resource-actions {
            display: flex;
            gap: 10px;
            margin-top: 18px;
            align-items: center;
        }

        /* =========================
           EDIT BUTTON
           ========================= */

        .edit-btn {
            display: inline-block;
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

        /* =========================
           DEACTIVATE BUTTON
           ========================= */

        .deactivate-btn {
            border: none;
            background: #dc2626;
            color: white;
            padding: 9px 16px;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        .deactivate-btn:hover {
            background: #b91c1c;
        }

        /* =========================
           NO RESOURCES
           ========================= */

        .no-resources {
            background: white;
            padding: 30px;
            text-align: center;
            border-radius: 10px;
            color: #64748b;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
        }

    </style>

</head>

<body>

    <!-- =========================
         HEADER
         ========================= -->

    <div class="header">

        <h1>EventSync - Resource Management</h1>

        <a
            href="<%= request.getContextPath() %>/admin"
    class="back-btn">

            Back to Admin Dashboard

        </a>

    </div>


    <!-- =========================
         MAIN CONTENT
         ========================= -->

    <div class="container">

        <div class="page-header">

            <h2>Manage Resources</h2>

            <a
                href="<%= request.getContextPath() %>/add-resource.jsp"
                class="add-btn">

                + Add Resource

            </a>

        </div>


        <!-- =========================
             SUCCESS MESSAGE
             ========================= -->

        <% if (successMessage != null) { %>

            <div class="success-message">

                <%= successMessage %>

            </div>

        <% } %>


        <!-- =========================
             ERROR MESSAGE
             ========================= -->

        <% if (errorMessage != null) { %>

            <div class="error-message">

                <%= errorMessage %>

            </div>

        <% } %>


        <!-- =========================
             RESOURCE LIST
             ========================= -->

        <% if (resources != null && !resources.isEmpty()) { %>

            <div class="resource-grid">

                <% for (Resource resource : resources) { %>

                    <div class="resource-card">

                        <!-- Resource Name -->

                        <h3>
                            <%= resource.getResourceName() %>
                        </h3>


                        <!-- Resource Details -->

                        <div class="resource-details">

                            <p>
                                <span class="label">
                                    Resource ID:
                                </span>

                                <%= resource.getResourceId() %>
                            </p>


                            <p>
                                <span class="label">
                                    Type:
                                </span>

                                <%= resource.getResourceType() %>
                            </p>


                            <p>
                                <span class="label">
                                    Quantity:
                                </span>

                                <%= resource.getQuantity() %>
                            </p>


                            <p>

                                <span class="label">
                                    Status:
                                </span>

                                <% if ("AVAILABLE".equalsIgnoreCase(
                                        resource.getStatus())) { %>

                                    <span class="status status-available">
                                        AVAILABLE
                                    </span>

                                <% } else if ("MAINTENANCE".equalsIgnoreCase(
                                        resource.getStatus())) { %>

                                    <span class="status status-maintenance">
                                        MAINTENANCE
                                    </span>

                                <% } else { %>

                                    <span class="status status-inactive">
                                        INACTIVE
                                    </span>

                                <% } %>

                            </p>

                        </div>


                        <!-- =========================
                             RESOURCE ACTIONS
                             ========================= -->

                        <div class="resource-actions">

                            <!-- EDIT RESOURCE -->

                            <a
                                href="<%= request.getContextPath() %>/edit-resource.jsp?resourceId=<%= resource.getResourceId() %>"
                                class="edit-btn">

                                Edit Resource

                            </a>


                            <!-- DEACTIVATE RESOURCE -->

                            <% if (!"INACTIVE".equalsIgnoreCase(
                                    resource.getStatus())) { %>

                                <form
                                    action="<%= request.getContextPath() %>/admin/resources"
                                    method="post"
                                    style="margin: 0;"
                                    onsubmit="return confirm('Are you sure you want to deactivate this resource?');">

                                    <input
                                        type="hidden"
                                        name="action"
                                        value="deactivate">

                                    <input
                                        type="hidden"
                                        name="resourceId"
                                        value="<%= resource.getResourceId() %>">

                                    <button
                                        type="submit"
                                        class="deactivate-btn">

                                        Deactivate Resource

                                    </button>

                                </form>

                            <% } %>

                        </div>

                    </div>

                <% } %>

            </div>

        <% } else { %>

            <div class="no-resources">

                <h3>No Resources Found</h3>

                <p>
                    There are currently no resources available
                    in the system.
                </p>

            </div>

        <% } %>

    </div>

</body>

</html>