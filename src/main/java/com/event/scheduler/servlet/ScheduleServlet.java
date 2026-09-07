package com.event.scheduler.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import com.event.scheduler.model.Booking;
import com.event.scheduler.model.Room;
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

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BookingService bookingService;
    private RoomService roomService;

    @Override
    public void init() throws ServletException {

        bookingService =
                new BookingServiceImpl();

        roomService =
                new RoomServiceImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check login
        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get selected date
        String dateParameter =
                request.getParameter("date");

        LocalDate selectedDate;

        try {

            if (dateParameter == null ||
                    dateParameter.trim().isEmpty()) {

                selectedDate =
                        LocalDate.now();

            } else {

                selectedDate =
                        LocalDate.parse(
                                dateParameter);
            }

        } catch (Exception e) {

            selectedDate =
                    LocalDate.now();

            request.setAttribute(
                    "errorMessage",
                    "Invalid date selected. "
                    + "Showing today's schedule.");
        }

        // Get confirmed bookings for selected date
        List<Booking> bookings =
                bookingService.getBookingsByDate(
                        selectedDate);

        // Get all rooms
        List<Room> rooms =
                roomService.getAllRooms();

        // Send selected date to JSP
        request.setAttribute(
                "selectedDate",
                selectedDate);

        // Send confirmed bookings to JSP
        request.setAttribute(
                "bookings",
                bookings);

        // Send all rooms to JSP
        request.setAttribute(
                "rooms",
                rooms);

        // Open schedule page
        request.getRequestDispatcher(
                "schedule.jsp")
                .forward(request, response);
    }
}