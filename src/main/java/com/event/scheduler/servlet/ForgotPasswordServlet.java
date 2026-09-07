package com.event.scheduler.servlet;

import java.io.IOException;

import com.event.scheduler.model.User;
import com.event.scheduler.service.UserService;
import com.event.scheduler.service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if fields are empty
        if (email == null || password == null || confirmPassword == null
                || email.trim().isEmpty()
                || password.trim().isEmpty()
                || confirmPassword.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("forgot-password.jsp")
                   .forward(request, response);
            return;
        }

        // Check whether passwords match
        if (!password.equals(confirmPassword)) {

            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("forgot-password.jsp")
                   .forward(request, response);
            return;
        }

        // Find user using email
        User user = userService.getUserByEmail(email);

        if (user == null) {

            request.setAttribute("error",
                    "No account found with this email address.");

            request.getRequestDispatcher("forgot-password.jsp")
                   .forward(request, response);
            return;
        }

        // Update password
        user.setPassword(password);

        boolean updated = userService.updateUser(user);

        if (updated) {

            response.sendRedirect("login.jsp?reset=success");

        } else {

            request.setAttribute("error",
                    "Password reset failed. Please try again.");

            request.getRequestDispatcher("forgot-password.jsp")
                   .forward(request, response);
        }
    }
}