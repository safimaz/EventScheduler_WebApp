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

@WebServlet("/admin/bookings")
public class AdminBookingsServlet extends HttpServlet {

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

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        User loggedInUser =
                (User) session.getAttribute(
                        "loggedInUser");

        // Check admin role
        if (!"ADMIN".equalsIgnoreCase(
                loggedInUser.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access Denied. Admin privileges required.");

            return;
        }

        // Get all pending bookings
        List<Booking> pendingBookings =
                bookingService.getBookingsByStatus(
                        "PENDING");

        request.setAttribute(
                "pendingBookings",
                pendingBookings);

        request.getRequestDispatcher(
                "/admin-bookings.jsp")
                .forward(request, response);
    }
}