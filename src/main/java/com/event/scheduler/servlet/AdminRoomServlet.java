package com.event.scheduler.servlet;

import java.io.IOException;
import java.util.List;

import com.event.scheduler.model.Room;
import com.event.scheduler.model.User;
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

    // =========================
    // GET - Display all rooms
    // =========================
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        // Check admin role
        User loggedInUser =
                (User) session.getAttribute("loggedInUser");

        if (!"ADMIN".equalsIgnoreCase(
                loggedInUser.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access Denied. Admin privileges required.");
            return;
        }

        // Get all rooms from database
        List<Room> rooms = roomService.getAllRooms();

        // Send rooms to JSP
        request.setAttribute("rooms", rooms);

        // Open admin rooms page
        request.getRequestDispatcher(
                "/admin-rooms.jsp")
                .forward(request, response);
    }

    // =========================
    // POST - Add / Update / Delete
    // =========================
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        // Check admin role
        User loggedInUser =
                (User) session.getAttribute("loggedInUser");

        if (!"ADMIN".equalsIgnoreCase(
                loggedInUser.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access Denied. Admin privileges required.");
            return;
        }

        String action = request.getParameter("action");

        // =========================
        // ADD ROOM
        // =========================
        if ("add".equalsIgnoreCase(action)) {

            String roomName =
                    request.getParameter("roomName");

            int capacity =
                    Integer.parseInt(
                            request.getParameter("capacity"));

            String location =
                    request.getParameter("location");

            String description =
                    request.getParameter("description");

            // Status defaults to AVAILABLE
            Room room = new Room(
                    roomName,
                    capacity,
                    location,
                    description,
                    "AVAILABLE"
            );

            roomService.addRoom(room);
        }

        // =========================
        // UPDATE ROOM
        // =========================
        else if ("update".equalsIgnoreCase(action)) {

            int roomId =
                    Integer.parseInt(
                            request.getParameter("roomId"));

            String roomName =
                    request.getParameter("roomName");

            int capacity =
                    Integer.parseInt(
                            request.getParameter("capacity"));

            String location =
                    request.getParameter("location");

            String description =
                    request.getParameter("description");

            String status =
                    request.getParameter("status");

            Room room = new Room(
                    roomId,
                    roomName,
                    capacity,
                    location,
                    description,
                    status
            );

            roomService.updateRoom(room);
        }

        // =========================
        // DELETE ROOM
        // =========================
        else if ("delete".equalsIgnoreCase(action)) {

            int roomId =
                    Integer.parseInt(
                            request.getParameter("roomId"));

            roomService.deleteRoom(roomId);
        }

        // After operation, return to admin rooms page
        response.sendRedirect(
                request.getContextPath() + "/admin/rooms");
    }
}