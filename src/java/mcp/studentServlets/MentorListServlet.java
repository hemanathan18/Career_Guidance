package mcp.studentServlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mcp.databaseConnection.DBConnection;


public class MentorListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            // Retrieve the selected date and time slot from the request
            String selectedDate = request.getParameter("selectedDate");
            String selectedTimeSlot = request.getParameter("selectedTimeSlot");

            try (Connection con = DBConnection.getConnection()) {
                // Retrieve the list of available mentors for the selected date and time slot
                List<String> availableMentors = getAvailableMentors(con, selectedDate, selectedTimeSlot);

                // Display the list of available mentors
                out.println("<html><head><title>Mentor List</title></head><body>");
                out.println("<h2>Available Mentors</h2>");
                if (availableMentors.isEmpty()) {
                    out.println("<p>No mentors available at the selected date and time slot.</p>");
                } else {
                    out.println("<ul>");
                    for (String mentor : availableMentors) {
                        out.println("<li>" + mentor + "</li>");
                    }
                    out.println("</ul>");
                }
                out.println("</body></html>");
            } catch (SQLException e) {
                out.println("<html><head><title>Error</title></head><body>");
                out.println("<h2>Database error. Please try again.</h2>");
                out.println("</body></html>");
            }
        }
    }

    private List<String> getAvailableMentors(Connection con, String selectedDate, String selectedTimeSlot) throws SQLException {
        List<String> mentors = new ArrayList<>();
        String query = "SELECT DISTINCT email FROM mentor_availability WHERE from_date <= ? AND to_date >= ? AND time_slot = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, selectedDate);
            pstmt.setString(2, selectedDate);
            pstmt.setString(3, selectedTimeSlot);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    mentors.add(rs.getString("email"));
                }
            }
        }
        return mentors;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Mentor List Servlet";
    }

}
