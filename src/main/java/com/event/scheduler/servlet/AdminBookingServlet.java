package com.event.scheduler.servlet;

import java.io.IOException;

import com.event.scheduler.dao.NotificationDAO;
import com.event.scheduler.dao.impl.NotificationDAOImpl;
import com.event.scheduler.model.Booking;
import com.event.scheduler.model.Notification;
import com.event.scheduler.model.User;
import com.event.scheduler.service.BookingService;
import com.event.scheduler.service.impl.BookingServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/booking-action")
public class AdminBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BookingService bookingService;
    private NotificationDAO notificationDAO;

    @Override
    public void init() throws ServletException {

        bookingService =
                new BookingServiceImpl();

        notificationDAO =
                new NotificationDAOImpl();
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

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp");

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

        try {

            int bookingId =
                    Integer.parseInt(
                            request.getParameter(
                                    "bookingId"));

            String action =
                    request.getParameter("action");

            boolean success = false;
            String message;

            // =========================================
            // APPROVE BOOKING
            // =========================================

            if ("approve".equalsIgnoreCase(action)) {

                success =
                        bookingService.approveBooking(
                                bookingId);

                if (success) {

                    // Get the booking to find the user
                    // who created the booking
                    Booking booking =
                            bookingService.getBookingById(
                                    bookingId);

                    // Create notification for the user
                    if (booking != null) {

                        Notification notification =
                                new Notification(
                                        booking.getUserId(),
                                        "Your booking has been approved.",
                                        "BOOKING_APPROVED",
                                        "N"
                                );

                        notificationDAO.addNotification(
                                notification);
                    }

                    message =
                            "Booking #"
                            + bookingId
                            + " approved successfully.";

                } else {

                    message =
                            "Unable to approve Booking #"
                            + bookingId
                            + ". "
                            + "The booking may no longer be "
                            + "available or there may be a "
                            + "room/resource conflict.";
                }

            // =========================================
            // REJECT BOOKING
            // =========================================

            } else if ("reject".equalsIgnoreCase(action)) {

                success =
                        bookingService.updateBookingStatus(
                                bookingId,
                                "REJECTED");

                if (success) {

                    // Get the booking to find the user
                    // who created the booking
                    Booking booking =
                            bookingService.getBookingById(
                                    bookingId);

                    // Create notification for the user
                    if (booking != null) {

                        Notification notification =
                                new Notification(
                                        booking.getUserId(),
                                        "Your booking has been rejected.",
                                        "BOOKING_REJECTED",
                                        "N"
                                );

                        notificationDAO.addNotification(
                                notification);
                    }

                    message =
                            "Booking #"
                            + bookingId
                            + " rejected successfully.";

                } else {

                    message =
                            "Unable to reject Booking #"
                            + bookingId
                            + ".";
                }

            } else {

                message =
                        "Invalid booking action.";
            }

            session.setAttribute(
                    "adminBookingMessage",
                    message);

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "adminBookingMessage",
                    "Invalid booking ID.");

        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute(
                    "adminBookingMessage",
                    "An unexpected error occurred "
                    + "while processing the booking.");
        }

        // Return to pending bookings page
        response.sendRedirect(
                request.getContextPath()
                + "/admin/bookings");
    }
}