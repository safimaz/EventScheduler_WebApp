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
}