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
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

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

        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Basic validation
        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            request.setAttribute(
                    "errorMessage",
                    "Email and password are required."
            );

            request.getRequestDispatcher("error.jsp")
                   .forward(request, response);

            return;
        }

        email = email.trim();

        // Validate login
        boolean validLogin =
                userService.validateLogin(email, password);

        if (validLogin) {

            User user = userService.getUserByEmail(email);

            HttpSession session = request.getSession();

            session.setAttribute(
                    "loggedInUser",
                    user
            );

            // Redirect based on role
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {

                response.sendRedirect(
                        request.getContextPath() + "/admin"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath() + "/dashboard.jsp"
                );
            }

        } else {

        	request.setAttribute(
        	        "errorMessage",
        	        "User is not registerd."
        	    );

        	    request.getRequestDispatcher("/error.jsp")
        	           .forward(request, response);
        }
    }
}