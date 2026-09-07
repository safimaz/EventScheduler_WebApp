package com.event.scheduler.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.event.scheduler.model.Booking;
import com.event.scheduler.model.Room;
import com.event.scheduler.model.User;
import com.event.scheduler.service.BookingService;
import com.event.scheduler.service.RoomService;
import com.event.scheduler.service.impl.BookingServiceImpl;
import com.event.scheduler.service.impl.RoomServiceImpl;

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
    private RoomService roomService;

    @Override
    public void init() throws ServletException {

        bookingService = new BookingServiceImpl();
        roomService = new RoomServiceImpl();
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

        // Create roomId -> roomName mapping
        Map<Integer, String> roomNames =
                new HashMap<>();

        if (bookings != null) {

            for (Booking booking : bookings) {

                Room room =
                        roomService.getRoomById(
                                booking.getRoomId());

                if (room != null) {

                    roomNames.put(
                            booking.getRoomId(),
                            room.getRoomName());
                }
            }
        }

        request.setAttribute(
                "bookings",
                bookings);

        request.setAttribute(
                "roomNames",
                roomNames);

        // Forward to JSP
        request.getRequestDispatcher(
                "my-bookings.jsp")
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
     
        try {
     
            User loggedInUser =
                    (User) session.getAttribute(
                            "loggedInUser");
     
            int bookingId =
                    Integer.parseInt(
                            request.getParameter(
                                    "bookingId"));
     
            // Get the booking
            Booking booking =
                    bookingService.getBookingById(
                            bookingId);
     
            // Check whether booking exists
            if (booking == null) {
     
                session.setAttribute(
                        "errorMessage",
                        "Booking not found.");
     
                response.sendRedirect(
                        "my-bookings");
     
                return;
            }
     
            // Make sure the booking belongs
            // to the logged-in user
            if (booking.getUserId()
                    != loggedInUser.getUserId()) {
     
                session.setAttribute(
                        "errorMessage",
                        "You are not authorized to cancel "
                        + "this booking.");
     
                response.sendRedirect(
                        "my-bookings");
     
                return;
            }
     
            // Cancel booking
            boolean cancelled =
                    bookingService.cancelBooking(
                            bookingId);
     
            if (cancelled) {
     
                session.setAttribute(
                        "successMessage",
                        "Booking #"
                        + bookingId
                        + " cancelled successfully.");
     
            } else {
     
                session.setAttribute(
                        "errorMessage",
                        "Unable to cancel Booking #"
                        + bookingId
                        + ". "
                        + "Only PENDING or CONFIRMED "
                        + "bookings can be cancelled.");
            }
     
        } catch (NumberFormatException e) {
     
            session.setAttribute(
                    "errorMessage",
                    "Invalid booking ID.");
     
        } catch (Exception e) {
     
            e.printStackTrace();
     
            session.setAttribute(
                    "errorMessage",
                    "An unexpected error occurred "
                    + "while cancelling the booking.");
        }
     
        response.sendRedirect("my-bookings");
    }






}
