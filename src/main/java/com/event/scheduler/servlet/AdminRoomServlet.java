package com.event.scheduler.servlet;

import java.io.IOException;
import java.util.List;

import com.event.scheduler.model.Room;
import com.event.scheduler.service.RoomService;
import com.event.scheduler.service.impl.RoomServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/rooms")
public class AdminRoomServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RoomService roomService;

    @Override
    public void init() throws ServletException {

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

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp");

            return;
        }

        // Check admin role
        String role =
                ((com.event.scheduler.model.User)
                        session.getAttribute(
                                "loggedInUser"))
                        .getRole();

        if (!"ADMIN".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/dashboard.jsp");

            return;
        }

        // Get all rooms
        List<Room> rooms =
                roomService.getAllRooms();

        request.setAttribute(
                "rooms",
                rooms);

        // Open admin room page
        request.getRequestDispatcher(
                "/admin-rooms.jsp")
                .forward(request, response);
    }
}