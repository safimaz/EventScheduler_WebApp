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

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RoomService roomService;

    @Override
    public void init() throws ServletException {
        roomService = new RoomServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        String keyword = request.getParameter("keyword");

        List<Room> rooms;

        if (keyword != null && !keyword.trim().isEmpty()) {
            rooms = roomService.searchRooms(keyword.trim());
        } else {
            rooms = roomService.getAllRooms();
        }

        request.setAttribute("rooms", rooms);

        request.getRequestDispatcher("rooms.jsp")
               .forward(request, response);
    }
}