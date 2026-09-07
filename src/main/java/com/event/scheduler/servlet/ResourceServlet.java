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
 
        // Check login
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
 
        String action = request.getParameter("action");
 
        try {
 
            // EDIT page
            if ("edit".equals(action)) {
 
                int resourceId =
                        Integer.parseInt(request.getParameter("id"));
 
                Resource resource =
                        resourceService.getResourceById(resourceId);
 
                request.setAttribute("resource", resource);
 
                request.getRequestDispatcher("resource-edit.jsp")
                       .forward(request, response);
 
                return;
            }
 
            // ADD page
            if ("add".equals(action)) {
 
                request.getRequestDispatcher("resource-form.jsp")
                       .forward(request, response);
 
                return;
            }
 
            // DELETE
            if ("delete".equals(action)) {
 
                int resourceId =
                        Integer.parseInt(request.getParameter("id"));
 
                resourceService.deleteResource(resourceId);
 
                response.sendRedirect("resources");
                return;
            }
 
            // Normal list/search
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
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            request.setAttribute("errorMessage",
                    "Unable to process resource request.");
 
            request.getRequestDispatcher("resources.jsp")
                   .forward(request, response);
        }
    }
 
    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {
 
        HttpSession session = request.getSession(false);
 
        // Check login
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
 
        String action = request.getParameter("action");
 
        try {
 
            // ADD RESOURCE
            if ("add".equals(action)) {
 
                String resourceName =
                        request.getParameter("resourceName");
 
                String resourceType =
                        request.getParameter("resourceType");
 
                int quantity =
                        Integer.parseInt(request.getParameter("quantity"));
 
                String status =
                        request.getParameter("status");
 
                Resource resource = new Resource(
                        resourceName,
                        resourceType,
                        quantity,
                        status
                );
 
                resourceService.addResource(resource);
 
                response.sendRedirect("resources");
                return;
            }
 
            // UPDATE RESOURCE
            if ("update".equals(action)) {
 
                int resourceId =
                        Integer.parseInt(request.getParameter("resourceId"));
 
                String resourceName =
                        request.getParameter("resourceName");
 
                String resourceType =
                        request.getParameter("resourceType");
 
                int quantity =
                        Integer.parseInt(request.getParameter("quantity"));
 
                String status =
                        request.getParameter("status");
 
                Resource resource = new Resource(
                        resourceId,
                        resourceName,
                        resourceType,
                        quantity,
                        status
                );
 
                resourceService.updateResource(resource);
 
                response.sendRedirect("resources");
                return;
            }
 
        } catch (Exception e) {
 
            e.printStackTrace();
 
            request.setAttribute("errorMessage",
                    "Unable to save resource.");
 
            request.getRequestDispatcher("resources.jsp")
                   .forward(request, response);
        }
    }
}