package com.event.scheduler.servlet;

import java.io.IOException;
import java.util.List;

import com.event.scheduler.model.User;
import com.event.scheduler.service.UserService;
import com.event.scheduler.service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() throws ServletException {

        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check whether user is logged in
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get success message
        String successMessage =
                (String) session.getAttribute("successMessage");

        if (successMessage != null) {

            request.setAttribute(
                    "successMessage",
                    successMessage);

            session.removeAttribute("successMessage");
        }

        // Get all users
        List<User> users =
                userService.getAllUsers();

        // Send users to JSP
        request.setAttribute(
                "users",
                users);

        // Open user management page
        request.getRequestDispatcher(
                "users.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check whether user is logged in
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            // ------------------------------------
            // Read user information
            // ------------------------------------

            String name =
                    request.getParameter("name");

            String email =
                    request.getParameter("email");

            String password =
                    request.getParameter("password");

            String role =
                    request.getParameter("role");

            String status =
                    request.getParameter("status");

            // ------------------------------------
            // Create User object
            // ------------------------------------

            User user =
                    new User();

            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);
            user.setStatus(status);

            // ------------------------------------
            // Add user
            // ------------------------------------

            boolean created =
                    userService.addUser(user);

            // ------------------------------------
            // User created successfully
            // ------------------------------------

            if (created) {

                request.setAttribute(
                        "successMessage",
                        "User created successfully.");

                // Get updated user list
                List<User> users =
                        userService.getAllUsers();

                request.setAttribute(
                        "users",
                        users);

                // Show users page
                request.getRequestDispatcher(
                        "users.jsp")
                        .forward(request, response);

                return;
            }

            // ------------------------------------
            // User creation failed
            // ------------------------------------

            request.setAttribute(
                    "errorMessage",
                    "Unable to create user. "
                    + "The email may already exist.");

            request.getRequestDispatcher(
                    "create-user.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Unable to create user. "
                    + "The email may already exist or "
                    + "some information is invalid.");

            request.getRequestDispatcher(
                    "create-user.jsp")
                    .forward(request, response);
        }
    }
}