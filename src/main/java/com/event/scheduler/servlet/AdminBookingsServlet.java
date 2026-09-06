package com.event.scheduler.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.event.scheduler.model.Booking;
import com.event.scheduler.model.BookingResource;
import com.event.scheduler.model.Resource;
import com.event.scheduler.model.Room;
import com.event.scheduler.model.User;

import com.event.scheduler.service.BookingResourceService;
import com.event.scheduler.service.BookingService;
import com.event.scheduler.service.ResourceService;
import com.event.scheduler.service.RoomService;
import com.event.scheduler.service.UserService;

import com.event.scheduler.service.impl.BookingResourceServiceImpl;
import com.event.scheduler.service.impl.BookingServiceImpl;
import com.event.scheduler.service.impl.ResourceServiceImpl;
import com.event.scheduler.service.impl.RoomServiceImpl;
import com.event.scheduler.service.impl.UserServiceImpl;

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

    private RoomService roomService;

    private UserService userService;

    private BookingResourceService bookingResourceService;

    private ResourceService resourceService;

    @Override
    public void init() throws ServletException {

        bookingService =
                new BookingServiceImpl();

        roomService =
                new RoomServiceImpl();

        userService =
                new UserServiceImpl();

        bookingResourceService =
                new BookingResourceServiceImpl();

        resourceService =
                new ResourceServiceImpl();
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

        // Get all pending bookings
        List<Booking> pendingBookings =
                bookingService.getBookingsByStatus(
                        "PENDING");

        /*
         * Maps to store room names and user names.
         *
         * Key   = ID
         * Value = Name
         */
        Map<Integer, String> roomNames =
                new HashMap<>();

        Map<Integer, String> userNames =
                new HashMap<>();

        /*
         * Map to store resources for each booking.
         *
         * Key   = Booking ID
         * Value = List of BookingResource objects
         */
        Map<Integer, List<BookingResource>>
                bookingResourcesMap =
                new HashMap<>();

        /*
         * Map to store actual Resource objects.
         *
         * Key   = Resource ID
         * Value = Resource object
         */
        Map<Integer, Resource> resourcesMap =
                new HashMap<>();

        // Get room, user and resource information
        for (Booking booking : pendingBookings) {

            int roomId =
                    booking.getRoomId();

            int userId =
                    booking.getUserId();

            int bookingId =
                    booking.getBookingId();

            // Get room name
            if (!roomNames.containsKey(roomId)) {

                Room room =
                        roomService.getRoomById(roomId);

                if (room != null) {

                    roomNames.put(
                            roomId,
                            room.getRoomName());
                }
            }

            // Get user name
            if (!userNames.containsKey(userId)) {

                User user =
                        userService.getUserById(userId);

                if (user != null) {

                    userNames.put(
                            userId,
                            user.getName());
                }
            }

            // Get resources associated with booking
            List<BookingResource> bookingResources =
                    bookingResourceService
                            .getResourcesByBooking(
                                    bookingId);

            bookingResourcesMap.put(
                    bookingId,
                    bookingResources);

            /*
             * Get actual resource details
             * for every selected resource.
             */
            if (bookingResources != null) {

                for (BookingResource bookingResource
                        : bookingResources) {

                    int resourceId =
                            bookingResource.getResourceId();

                    if (!resourcesMap.containsKey(
                            resourceId)) {

                        Resource resource =
                                resourceService
                                        .getResourceById(
                                                resourceId);

                        if (resource != null) {

                            resourcesMap.put(
                                    resourceId,
                                    resource);
                        }
                    }
                }
            }
        }

        // Send booking data to JSP
        request.setAttribute(
                "pendingBookings",
                pendingBookings);

        // Send room names to JSP
        request.setAttribute(
                "roomNames",
                roomNames);

        // Send user names to JSP
        request.setAttribute(
                "userNames",
                userNames);

        // Send booking-resource associations
        request.setAttribute(
                "bookingResourcesMap",
                bookingResourcesMap);

        // Send actual resource details
        request.setAttribute(
                "resourcesMap",
                resourcesMap);

        // Forward to admin bookings page
        request.getRequestDispatcher(
                "/admin-bookings.jsp")
                .forward(request, response);
    }
}