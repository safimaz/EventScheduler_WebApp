package com.event.scheduler.servlet;

import java.io.IOException;
import java.util.List;

import com.event.scheduler.model.Booking;
import com.event.scheduler.model.User;
import com.event.scheduler.service.BookingService;
import com.event.scheduler.service.impl.BookingServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BookingService bookingService;

    @Override
    public void init() throws ServletException {

        bookingService = new BookingServiceImpl();
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

        // Get bookings belonging to this user
        List<Booking> bookings =
                bookingService.getBookingsByUser(
                        loggedInUser.getUserId());

        request.setAttribute(
                "bookings",
                bookings);

        // Forward to JSP
        request.getRequestDispatcher(
                "my-bookings.jsp")
               .forward(request, response);
    }
}