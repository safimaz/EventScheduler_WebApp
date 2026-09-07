<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Resource" %>

<%
// Check whether user is logged in
if (session.getAttribute("loggedInUser") == null) {
response.sendRedirect("login.jsp");
return;
}


List<Resource> resources =
    (List<Resource>) request.getAttribute("resources");

String keyword = request.getParameter("keyword");

%>

<!DOCTYPE html>

<html>

<head>

```
<meta charset="UTF-8">

<title>Resources - EventSync</title>

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

    /* NAVBAR */

    .navbar {
        background-color: #1f2937;
        color: white;
        padding: 18px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .logo {
        font-size: 24px;
        font-weight: bold;
    }

    .back-link {
        color: white;
        text-decoration: none;
        font-size: 14px;
    }

    .back-link:hover {
        text-decoration: underline;
    }

    /* MAIN CONTAINER */

    .container {
        width: 90%;
        max-width: 1100px;
        margin: 40px auto;
    }

    /* HEADER */

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
    }

    .page-header h1 {
        margin: 0;
        font-size: 30px;
    }

    .add-button {
        background-color: #2563eb;
        color: white;
        padding: 11px 18px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 15px;
        font-weight: bold;
    }

    .add-button:hover {
        background-color: #1d4ed8;
    }

    /* SEARCH */

    .search-container {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 30px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    }

    .search-form {
        display: flex;
        gap: 10px;
    }

    .search-input {
        flex: 1;
        padding: 11px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 15px;
    }

    .search-button {
        padding: 11px 20px;
        border: none;
        background-color: #374151;
        color: white;
        border-radius: 6px;
        cursor: pointer;
        font-size: 15px;
    }

    .search-button:hover {
        background-color: #111827;
    }

    .clear-button {
        padding: 11px 20px;
        background-color: #e5e7eb;
        color: #333;
        border-radius: 6px;
        text-decoration: none;
        font-size: 15px;
    }

    /* RESOURCE GRID */

    .resource-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 20px;
    }

    /* RESOURCE CARD */

    .resource-card {
        background-color: white;
        border-radius: 10px;
        padding: 22px;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
    }

    .resource-card h3 {
        margin-top: 0;
        margin-bottom: 15px;
        font-size: 21px;
    }

    .resource-card p {
        margin: 9px 0;
        font-size: 15px;
    }

    .resource-card strong {
        color: #374151;
    }

    /* STATUS */

    .status {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 15px;
        font-size: 12px;
        font-weight: bold;
    }

    .available {
        background-color: #dcfce7;
        color: #166534;
    }

    .maintenance {
        background-color: #fef3c7;
        color: #92400e;
    }

    .inactive {
        background-color: #fee2e2;
        color: #991b1b;
    }

    /* ACTION BUTTONS */

    .actions {
        margin-top: 18px;
        display: flex;
        gap: 8px;
    }

    .edit-button {
        background-color: #f59e0b;
        color: white;
        padding: 8px 14px;
        border-radius: 5px;
        text-decoration: none;
        font-size: 14px;
    }

    .edit-button:hover {
        background-color: #d97706;
    }

    .delete-button {
        background-color: #dc2626;
        color: white;
        padding: 8px 14px;
        border-radius: 5px;
        text-decoration: none;
        font-size: 14px;
    }

    .delete-button:hover {
        background-color: #b91c1c;
    }

    /* EMPTY MESSAGE */

    .empty-message {
        background-color: white;
        padding: 40px;
        text-align: center;
        border-radius: 10px;
        color: #666;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    }

    /* ERROR MESSAGE */

    .error-message {
        background-color: #fee2e2;
        color: #991b1b;
        padding: 12px;
        border-radius: 6px;
        margin-bottom: 20px;
    }

    /* FOOTER */

    footer {
        text-align: center;
        padding: 25px;
        margin-top: 50px;
        color: #777;
        font-size: 14px;
    }

    /* MOBILE */

    @media (max-width: 600px) {

        .navbar {
            padding: 15px 20px;
        }

        .container {
            width: 92%;
        }

        .page-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 15px;
        }

        .search-form {
            flex-direction: column;
        }

    }

</style>
```

</head>

<body>

```
<!-- NAVBAR -->

<div class="navbar">

    <div class="logo">
        EventSync
    </div>

    <a href="dashboard.jsp" class="back-link">
        ← Back to Dashboard
    </a>

</div>


<!-- MAIN CONTENT -->

<div class="container">

    <!-- PAGE HEADER -->

    <div class="page-header">

        <h1>
            Shared Resources
        </h1>

        <a href="resources?action=add"
           class="add-button">
            + Add Resource
        </a>

    </div>


    <!-- ERROR MESSAGE -->

    <%
        String errorMessage =
            (String) request.getAttribute("errorMessage");

        if (errorMessage != null) {
    %>

        <div class="error-message">
            <%= errorMessage %>
        </div>

    <%
        }
    %>


    <!-- SEARCH -->

    <div class="search-container">

        <form action="resources"
              method="get"
              class="search-form">

            <input type="text"
                   name="keyword"
                   class="search-input"
                   placeholder="Search by resource name or type..."
                   value="<%= keyword != null ? keyword : "" %>">

            <button type="submit"
                    class="search-button">
                Search
            </button>

            <%
                if (keyword != null &&
                    !keyword.trim().isEmpty()) {
            %>

                <a href="resources"
                   class="clear-button">
                    Clear
                </a>

            <%
                }
            %>

        </form>

    </div>


    <!-- RESOURCE LIST -->

    <%
        if (resources != null && !resources.isEmpty()) {
    %>

        <div class="resource-grid">

            <%
                for (Resource resource : resources) {

                    String status =
                        resource.getStatus() != null
                        ? resource.getStatus().toUpperCase()
                        : "";

                    String statusClass =
                        status.toLowerCase();
            %>

                <!-- RESOURCE CARD -->

                <div class="resource-card">

                    <h3>
                        <%= resource.getResourceName() %>
                    </h3>

                    <p>
                        <strong>Type:</strong>
                        <%= resource.getResourceType() != null
                            ? resource.getResourceType()
                            : "Not specified" %>
                    </p>

                    <p>
                        <strong>Quantity:</strong>
                        <%= resource.getQuantity() %>
                    </p>

                    <p>
                        <strong>Status:</strong>

                        <span class="status <%= statusClass %>">
                            <%= status %>
                        </span>

                    </p>


                    <!-- EDIT / DELETE -->

                    <div class="actions">

                        <a href="resources?action=edit&id=<%= resource.getResourceId() %>"
                           class="edit-button">
                            Edit
                        </a>

                        <a href="resources?action=delete&id=<%= resource.getResourceId() %>"
                           class="delete-button"
                           onclick="return confirm('Are you sure you want to delete this resource?');">
                            Delete
                        </a>

                    </div>

                </div>

            <%
                }
            %>

        </div>

    <%
        } else {
    %>

        <!-- NO RESOURCES -->

        <div class="empty-message">

            <h3>
                No resources found
            </h3>

            <p>
                There are currently no resources available.
            </p>

            <a href="resources?action=add"
               class="add-button">
                + Add Resource
            </a>

        </div>

    <%
        }
    %>

</div>


<!-- FOOTER -->

<footer>

    EventSync &copy; 2026 |
    Event Room & Resource Scheduler

</footer>
```

</body>

</html>
