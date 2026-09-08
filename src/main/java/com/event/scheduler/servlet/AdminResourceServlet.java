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

        if (!isAdmin(request, response)) {
            return;
        }


        List<Resource> resources =
                resourceService.getAllResources();


        request.setAttribute(
                "resources",
                resources);


        request.getRequestDispatcher(
                "/admin-resources.jsp")
                .forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
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
             * UPDATE RESOURCE
             * ==========================
             */

            if ("update".equalsIgnoreCase(action)) {

                int resourceId =
                        Integer.parseInt(
                                request.getParameter("resourceId"));

                String resourceName =
                        request.getParameter("resourceName");

                String resourceType =
                        request.getParameter("resourceType");

                int quantity =
                        Integer.parseInt(
                                request.getParameter("quantity"));

                String status =
                        request.getParameter("status");


                Resource resource =
                        resourceService.getResourceById(
                                resourceId);


                if (resource == null) {

                    request.getSession().setAttribute(
                            "resourceErrorMessage",
                            "Resource not found.");

                } else {

                    /*
                     * Keep the same resource ID.
                     * Update the resource details.
                     */

                    resource.setResourceName(
                            resourceName);

                    resource.setResourceType(
                            resourceType);

                    resource.setQuantity(
                            quantity);

                    resource.setStatus(
                            status);


                    boolean updated =
                            resourceService.updateResource(
                                    resource);


                    if (updated) {

                        request.getSession().setAttribute(
                                "resourceSuccessMessage",
                                "Resource updated successfully.");

                    } else {

                        request.getSession().setAttribute(
                                "resourceErrorMessage",
                                "Unable to update resource.");
                    }
                }

            }


            /*
             * ==========================
             * ADD RESOURCE
             * ==========================
             */

            else {

                String resourceName =
                        request.getParameter("resourceName");

                String resourceType =
                        request.getParameter("resourceType");

                int quantity =
                        Integer.parseInt(
                                request.getParameter("quantity"));

                String status =
                        request.getParameter("status");


                Resource resource =
                        new Resource();


                resource.setResourceName(
                        resourceName);

                resource.setResourceType(
                        resourceType);

                resource.setQuantity(
                        quantity);

                resource.setStatus(
                        status);


                boolean added =
                        resourceService.addResource(
                                resource);


                if (added) {

                    request.getSession().setAttribute(
                            "resourceSuccessMessage",
                            "Resource added successfully.");

                } else {

                    request.getSession().setAttribute(
                            "resourceErrorMessage",
                            "Unable to add resource.");
                }
            }


        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "resourceErrorMessage",
                    "Resource ID and quantity must be valid numbers.");

        } catch (Exception e) {

            e.printStackTrace();

            request.getSession().setAttribute(
                    "resourceErrorMessage",
                    "An unexpected error occurred while processing the resource.");
        }


        response.sendRedirect(
                request.getContextPath()
                + "/admin/resources");
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