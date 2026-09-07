package com.event.scheduler.servlet;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.event.scheduler.model.Booking;
import com.event.scheduler.model.BookingResource;
import com.event.scheduler.model.Resource;
import com.event.scheduler.model.Room;
import com.event.scheduler.model.User;
import com.event.scheduler.service.BookingService;
import com.event.scheduler.service.ResourceService;
import com.event.scheduler.service.RoomService;
import com.event.scheduler.service.impl.BookingServiceImpl;
import com.event.scheduler.service.impl.ResourceServiceImpl;
import com.event.scheduler.service.impl.RoomServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/book-room")
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BookingService bookingService;
    private RoomService roomService;
    private ResourceService resourceService;

    @Override
    public void init() throws ServletException {

        bookingService = new BookingServiceImpl();
        roomService = new RoomServiceImpl();
        resourceService = new ResourceServiceImpl();
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

        // Load rooms and resources
        loadFormData(request);

        // Open booking form
        request.getRequestDispatcher("book-room.jsp")
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
            // Get logged-in user
            // ------------------------------------

            User loggedInUser =
                    (User) session.getAttribute(
                            "loggedInUser");

            // ------------------------------------
            // Read room and booking information
            // ------------------------------------

            int roomId =
                    Integer.parseInt(
                            request.getParameter("roomId"));

            LocalDateTime startTime =
                    LocalDateTime.parse(
                            request.getParameter("startTime"));

            LocalDateTime endTime =
                    LocalDateTime.parse(
                            request.getParameter("endTime"));

            int attendeeCount =
                    Integer.parseInt(
                            request.getParameter(
                                    "attendeeCount"));

            String purpose =
                    request.getParameter("purpose");

            // ------------------------------------
            // Read selected resources
            // ------------------------------------

            String[] selectedResourceIds =
                    request.getParameterValues("resourceId");

            List<BookingResource> bookingResources =
                    new ArrayList<>();

            if (selectedResourceIds != null) {

                for (String resourceIdValue
                        : selectedResourceIds) {

                    int resourceId =
                            Integer.parseInt(
                                    resourceIdValue);

                    String quantityParameter =
                            "resourceQuantity_"
                            + resourceId;

                    String quantityValue =
                            request.getParameter(
                                    quantityParameter);

                    int quantity =
                            Integer.parseInt(
                                    quantityValue);

                    BookingResource bookingResource =
                            new BookingResource();

                    bookingResource.setResourceId(
                            resourceId);

                    bookingResource.setQuantity(
                            quantity);

                    bookingResources.add(
                            bookingResource);
                }
            }

            // ------------------------------------
            // Create Booking object
            // ------------------------------------

            Booking booking =
                    new Booking();

            booking.setRoomId(roomId);

            booking.setUserId(
                    loggedInUser.getUserId());

            booking.setStartTime(startTime);

            booking.setEndTime(endTime);

            booking.setAttendeeCount(
                    attendeeCount);

            booking.setPurpose(purpose);

            // ------------------------------------
            // Create booking + resources
            // ------------------------------------

            boolean created =
                    bookingService.createBooking(
                            booking,
                            bookingResources);

            // ------------------------------------
            // Booking successful
            // ------------------------------------

            if (created) {

                session.setAttribute(
                        "successMessage",
                        "Booking request submitted successfully.");

                response.sendRedirect(
                        "my-bookings");

                return;
            }

            // ------------------------------------
            // Booking failed
            // ------------------------------------

            request.setAttribute(
                    "errorMessage",
                    "Unable to create booking. "
                    + "Please check room availability, "
                    + "room capacity, time and "
                    + "resource availability.");

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "errorMessage",
                    "Invalid booking information. "
                    + "Please check all fields.");
        }

        // Reload rooms/resources if booking fails
        loadFormData(request);

        request.getRequestDispatcher(
                "book-room.jsp")
                .forward(request, response);
    }

    private void loadFormData(
            HttpServletRequest request) {

        List<Room> rooms =
                roomService.getAvailableRooms();

        List<Resource> resources =
                resourceService.getAvailableResources();

        request.setAttribute(
                "rooms",
                rooms);

        request.setAttribute(
                "resources",
                resources);
    }
}