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

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        List<Room> rooms =
                roomService.getAllRooms();

        request.setAttribute(
                "rooms",
                rooms);

        request.getRequestDispatcher(
                "/admin-rooms.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        try {

            String action =
                    request.getParameter("action");


            /*
             * ==========================
             * UPDATE ROOM
             * ==========================
             */

            if ("update".equalsIgnoreCase(action)) {

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


                Room room = new Room();

                room.setRoomId(roomId);

                room.setRoomName(roomName);

                room.setCapacity(capacity);

                room.setLocation(location);

                room.setDescription(description);

                room.setStatus(status);


                boolean updated =
                        roomService.updateRoom(room);


                if (updated) {

                    request.getSession().setAttribute(
                            "roomSuccessMessage",
                            "Room updated successfully.");

                } else {

                    request.getSession().setAttribute(
                            "roomErrorMessage",
                            "Unable to update room.");
                }

            }


            /*
             * ==========================
             * DEACTIVATE ROOM
             * ==========================
             */

            else if ("deactivate".equalsIgnoreCase(action)) {

                int roomId =
                        Integer.parseInt(
                                request.getParameter("roomId"));


                // Get the existing room using its ID

                Room room =
                        roomService.getRoomById(roomId);


                if (room == null) {

                    request.getSession().setAttribute(
                            "roomErrorMessage",
                            "Room not found.");

                } else {

                    /*
                     * Keep the existing room ID
                     * and all other room details.
                     *
                     * Only change the status.
                     */

                    room.setStatus("INACTIVE");


                    boolean deactivated =
                            roomService.updateRoom(room);


                    if (deactivated) {

                        request.getSession().setAttribute(
                                "roomSuccessMessage",
                                "Room deactivated successfully.");

                    } else {

                        request.getSession().setAttribute(
                                "roomErrorMessage",
                                "Unable to deactivate room.");
                    }
                }

            }


            /*
             * ==========================
             * ADD ROOM
             * ==========================
             */

            else {

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


                Room room = new Room();

                room.setRoomName(roomName);

                room.setCapacity(capacity);

                room.setLocation(location);

                room.setDescription(description);

                room.setStatus(status);


                boolean added =
                        roomService.addRoom(room);


                if (added) {

                    request.getSession().setAttribute(
                            "roomSuccessMessage",
                            "Room added successfully.");

                } else {

                    request.getSession().setAttribute(
                            "roomErrorMessage",
                            "Unable to add room.");
                }
            }


        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "roomErrorMessage",
                    "Room ID and capacity must be valid numbers.");

        } catch (Exception e) {

            e.printStackTrace();

            request.getSession().setAttribute(
                    "roomErrorMessage",
                    "An unexpected error occurred while processing the room.");
        }


        response.sendRedirect(
                request.getContextPath()
                + "/admin/rooms");
    }
    private boolean isAdmin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute(
                        "loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp");

            return false;
        }

        User loggedInUser =
                (User) session.getAttribute(
                        "loggedInUser");

        if (!"ADMIN".equalsIgnoreCase(
                loggedInUser.getRole())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/dashboard.jsp");

            return false;
        }

        return true;
    }
}