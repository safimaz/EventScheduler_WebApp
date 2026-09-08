package com.event.scheduler.servlet;

import java.io.IOException;
import java.util.List;

import com.event.scheduler.model.Notification;
import com.event.scheduler.model.User;
import com.event.scheduler.service.NotificationService;
import com.event.scheduler.service.impl.NotificationServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private NotificationService notificationService;

    @Override
    public void init() throws ServletException {

        notificationService =
                new NotificationServiceImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user
        User loggedInUser =
                (User) session.getAttribute(
                        "loggedInUser");

        int userId =
                loggedInUser.getUserId();

        // Get all notifications
        List<Notification> notifications =
                notificationService
                .getNotificationsByUser(userId);

        // Get unread notification count
        int unreadCount =
                notificationService
                .getUnreadNotificationCount(userId);

        // Send data to JSP
        request.setAttribute(
                "notifications",
                notifications);

        request.setAttribute(
                "unreadCount",
                unreadCount);

        // Open notifications page
        request.getRequestDispatcher(
                "notifications.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser =
                (User) session.getAttribute(
                        "loggedInUser");

        try {

            String action =
                    request.getParameter("action");

            // =========================================
            // MARK ONE NOTIFICATION AS READ
            // =========================================

            if ("markRead".equals(action)) {

                int notificationId =
                    Integer.parseInt(
                        request.getParameter("notificationId")
                    );

                notificationService.markAsRead(
                    notificationId,
                    loggedInUser.getUserId()
                );

            // =========================================
            // MARK ALL NOTIFICATIONS AS READ
            // =========================================

            } else if ("markAllRead"
                    .equalsIgnoreCase(action)) {

                notificationService.markAllAsRead(
                        loggedInUser.getUserId());
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();

        } catch (Exception e) {

            e.printStackTrace();
        }

        // Return to notification page
        response.sendRedirect("notifications");
    }
}