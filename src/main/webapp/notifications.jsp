<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.event.scheduler.model.Notification" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Notifications</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .container {
            width: 80%;
            max-width: 1000px;
            margin: 40px auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0;
            color: #333;
        }

        .unread-count {
            background-color: #007bff;
            color: white;
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 14px;
        }

        .actions {
            margin-bottom: 20px;
            text-align: right;
        }

        .btn {
            border: none;
            padding: 10px 16px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .notification-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .notification {
            background-color: white;
            padding: 18px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);

            display: flex;
            justify-content: space-between;
            align-items: center;

            border-left: 5px solid #ccc;
        }

        .notification.unread {
            border-left-color: #007bff;
            background-color: #eef6ff;
        }

        .notification-content {
            flex: 1;
        }

        .notification-message {
            font-size: 16px;
            color: #333;
            margin-bottom: 8px;
        }

        .notification-meta {
            font-size: 13px;
            color: #777;
        }

        .notification-type {
            display: inline-block;
            margin-right: 10px;
            font-weight: bold;
        }

        .read-status {
            margin-left: 15px;
        }

        .empty {
            background-color: white;
            padding: 40px;
            text-align: center;
            border-radius: 8px;
            color: #777;
        }

        .mark-read-form {
            margin-left: 20px;
        }

    </style>

</head>

<body>

<div class="container">

    <!-- ===================================== -->
    <!-- HEADER -->
    <!-- ===================================== -->

    <div class="header">

        <h1>Notifications</h1>

        <span class="unread-count">
            Unread:
            <%= request.getAttribute("unreadCount") %>
        </span>

    </div>


    <!-- ===================================== -->
    <!-- MARK ALL AS READ -->
    <!-- ===================================== -->

    <div class="actions">

        <form action="notifications"
              method="post">

            <input type="hidden"
                   name="action"
                   value="markAllRead">

            <button type="submit"
                    class="btn btn-primary">

                Mark All as Read

            </button>

        </form>

    </div>


    <!-- ===================================== -->
    <!-- NOTIFICATIONS -->
    <!-- ===================================== -->

    <div class="notification-list">

        <%
            List<Notification> notifications =
                    (List<Notification>)
                    request.getAttribute(
                            "notifications");

            if (notifications == null ||
                    notifications.isEmpty()) {
        %>

            <div class="empty">

                <h3>No notifications</h3>

                <p>
                    You don't have any notifications yet.
                </p>

            </div>

        <%
            } else {

                for (Notification notification
                        : notifications) {

                    boolean unread =
                            "N".equalsIgnoreCase(
                                    notification.getIsRead());
        %>

            <div class="notification
                <%= unread ? "unread" : "" %>">

                <div class="notification-content">

                    <div class="notification-message">

                        <%= notification.getMessage() %>

                    </div>

                    <div class="notification-meta">

                        <span class="notification-type">

                            <%= notification.getType() %>

                        </span>

                        <span>

                            <%= notification.getCreatedAt() %>

                        </span>

                        <span class="read-status">

                            <%= unread
                                ? "Unread"
                                : "Read" %>

                        </span>

                    </div>

                </div>


                <!-- ================================= -->
                <!-- MARK SINGLE NOTIFICATION AS READ -->
                <!-- ================================= -->

                <%
                    if (unread) {
                %>

                    <form action="notifications"
                          method="post"
                          class="mark-read-form">

                        <input type="hidden"
                               name="action"
                               value="markRead">

                        <input type="hidden"
                               name="notificationId"
                               value="<%= notification.getNotificationId() %>">

                        <button type="submit"
                                class="btn btn-primary">

                            Mark as Read

                        </button>

                    </form>

                <%
                    }
                %>

            </div>

        <%
                }
            }
        %>

    </div>

</div>

</body>
</html>