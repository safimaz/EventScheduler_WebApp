package com.event.scheduler.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.event.scheduler.util.DBConnection;

@WebServlet("/db-test")
public class DBConnectionTestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        try (Connection connection = DBConnection.getConnection()) {

            PrintWriter out = response.getWriter();

            out.println("<html>");
            out.println("<head><title>Database Test</title></head>");
            out.println("<body>");

            out.println("<h1>Database Connection Successful!</h1>");

            out.println("<p>Connected User: "
                    + connection.getMetaData().getUserName()
                    + "</p>");

            out.println("<p>Database: Oracle FREEPDB1</p>");

            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {

            response.setStatus(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            PrintWriter out = response.getWriter();

            out.println("<html>");
            out.println("<body>");

            out.println("<h1>Database Connection Failed!</h1>");

            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");

            out.println("</body>");
            out.println("</html>");
        }
    }
}