package com.event.scheduler.servlet;

import java.io.IOException;

import com.event.scheduler.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check whether the user is logged in
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        User loggedInUser =
                (User) session.getAttribute(
                        "loggedInUser");

        // Check whether the logged-in user is ADMIN
        if (!"ADMIN".equalsIgnoreCase(
                loggedInUser.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access Denied. Admin privileges required.");

            return;
        }

        // User is authenticated and is an ADMIN
        request.getRequestDispatcher(
                "/admin-dashboard.jsp")
                .forward(request, response);
    }
}