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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() throws ServletException {

        userService = new UserServiceImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("register.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Get data from registration form

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword =
                request.getParameter("confirmPassword");


        // Check whether all fields are filled

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || confirmPassword == null
                || confirmPassword.trim().isEmpty()) {

            request.setAttribute(
                    "errorMessage",
                    "All fields are required."
            );

            request.getRequestDispatcher("register.jsp")
                    .forward(request, response);

            return;
        }


        // Remove unnecessary spaces

        name = name.trim();
        email = email.trim();


        // Check whether passwords match

        if (!password.equals(confirmPassword)) {

            request.setAttribute(
                    "errorMessage",
                    "Passwords do not match."
            );

            request.getRequestDispatcher("register.jsp")
                    .forward(request, response);

            return;
        }


        // Check whether email already exists

        User existingUser =
                userService.getUserByEmail(email);

        if (existingUser != null) {

            request.setAttribute(
                    "errorMessage",
                    "An account with this email already exists."
            );

            request.getRequestDispatcher("register.jsp")
                    .forward(request, response);

            return;
        }


        // Create a new User object

        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);


        // Set default values

        user.setRole("USER");
        user.setStatus("ACTIVE");


        // Save user in database

        boolean registered =
                userService.addUser(user);


        // Check whether registration was successful

        if (registered) {

            request.setAttribute(
                    "successMessage",
                    "Registration successful! Please login."
            );

            request.getRequestDispatcher("login.jsp")
                    .forward(request, response);

        } else {

            request.setAttribute(
                    "errorMessage",
                    "Registration failed. Please try again."
            );

            request.getRequestDispatcher("register.jsp")
                    .forward(request, response);
        }
    }
}