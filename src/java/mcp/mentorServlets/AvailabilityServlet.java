package mcp.mentorServlets;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import mcp.databaseConnection.DBConnection;
import mcp.studentServlets.BookingServlet;

public class AvailabilityServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession();
            String mentorEmail = (String) session.getAttribute("email");

            if (mentorEmail == null) {
                response.sendRedirect("Mentor/mentorlogin.jsp");
                return;
            }
            String industry="";
            try (Connection con = DBConnection.getConnection()) {
                            
                            String query ="select industry from mentor where email=?";
                            PreparedStatement pstmt = con.prepareStatement(query);
                            pstmt.setString(1,mentorEmail);
                            ResultSet rs=pstmt.executeQuery();
                            while(rs.next())
                            {
                            industry = rs.getString("industry");
                            }
            
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String timeSlot = request.getParameter("timeSlot");

            
                // Check if the mentor has already set availability for the entered date range
                if (!isDateRangeAvailable(con, mentorEmail, fromDate, toDate)) {
                    String query1 = "INSERT INTO mentor_availability (email, from_date, to_date, time_slot, industry) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement pstmt1 = con.prepareStatement(query1)) {
                        pstmt1.setString(1, mentorEmail);
                        pstmt1.setString(2, fromDate);
                        pstmt1.setString(3, toDate);
                        pstmt1.setString(4, timeSlot);
                        pstmt1.setString(5, industry);

                        int rowsAffected = pstmt1.executeUpdate();

                        if (rowsAffected > 0) {
//                            out.println("<html><head><title>Success</title></head><body>");
//                            out.println("<h2>Availability set successfully!</h2>");
//                            out.println("</body></html>");
                            request.setAttribute("message", "Availability set successfully!");
                            RequestDispatcher rd = request.getRequestDispatcher("Mentor/Calendar.jsp");
                            rd.forward(request, response);
                        } else {
//                            out.println("<html><head><title>Error</title></head><body>");
//                            out.println("<h2>Error setting availability. Please try again.</h2>");
//                            out.println("</body></html>");
                            request.setAttribute("errorMessage", "Error setting availability");
                            RequestDispatcher rd = request.getRequestDispatcher("Mentor/Calendar.jsp");
                            rd.forward(request, response);
                        }
                    }
                } else {
//                    out.println("<html><head><title>Error</title></head><body>");
//                    out.println("<h2>Availability already set for the entered date range.</h2>");
//                    out.println("</body></html>");
                    request.setAttribute("errorMessage", "Already set for the entered date range");
                    RequestDispatcher rd = request.getRequestDispatcher("Mentor/Calendar.jsp");
                    rd.forward(request, response);
                }
            } catch (SQLException e) {
                out.println("<html><head><title>Error</title></head><body>");
                out.println("<h2>Database error. Please try again.</h2>");
                out.println(industry);
                Logger.getLogger(AvailabilityServlet.class.getName()).log(Level.SEVERE, null, e);
                out.println("</body></html>");
            }

        }
    }

    private boolean isDateRangeAvailable(Connection con, String mentorEmail, String fromDate, String toDate) throws SQLException {
        String query = "SELECT COUNT(*) FROM mentor_availability WHERE email = ? AND to_date >= ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, mentorEmail);
            pstmt.setString(2, fromDate);

            try (ResultSet rs = pstmt.executeQuery()) {
                rs.next();
                int count = rs.getInt(1);
                return count > 0;
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
