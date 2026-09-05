package com.event.scheduler.servlet;

import java.io.IOException;
import java.util.List;

import com.event.scheduler.model.Resource;
import com.event.scheduler.service.ResourceService;
import com.event.scheduler.service.impl.ResourceServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/resources")
public class ResourceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ResourceService resourceService;

    @Override
    public void init() throws ServletException {
        resourceService = new ResourceServiceImpl();
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

        List<Resource> resources;

        if (keyword != null && !keyword.trim().isEmpty()) {

            resources =
                resourceService.searchResources(keyword.trim());

        } else {

            resources =
                resourceService.getAllResources();
        }

        request.setAttribute("resources", resources);

        request.getRequestDispatcher("resources.jsp")
               .forward(request, response);
    }
}