package com.event.scheduler.servlet;

import java.io.IOException;
import java.util.List;

import com.event.scheduler.model.Resource;
import com.event.scheduler.model.User;
import com.event.scheduler.service.ResourceService;
import com.event.scheduler.service.impl.ResourceServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/resources")
public class AdminResourceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ResourceService resourceService;


    @Override
    public void init() throws ServletException {

        resourceService =
                new ResourceServiceImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // Check admin access

        if (!isAdmin(request, response)) {
            return;
        }


        // Get all resources

        List<Resource> resources =
                resourceService.getAllResources();


        // Send resources to JSP

        request.setAttribute(
                "resources",
                resources);


        // Open admin resource page

        request.getRequestDispatcher(
                "/admin-resources.jsp")
                .forward(request, response);
    }


    private boolean isAdmin(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {


        HttpSession session =
                request.getSession(false);


        // User not logged in

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


        // User is not an admin

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