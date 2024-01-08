package mcp.studentServlets;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mcp.databaseConnection.DBConnection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.text.ParseException;
import java.util.Properties;
import mcp.mailHandling.MailContentGenerator;

public class BookingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String studentEmail = request.getSession().getAttribute("studentEmail").toString();
            String mentorEmail = request.getParameter("mentorEmail");
            String timeSlot = request.getParameter("timeSlot");
            String bookedDate = request.getParameter("date");
            String studentName = getStudentName(studentEmail);
            String mentorName = getMentorName(mentorEmail);

            String studentMailContent = MailContentGenerator.generateStudentMailContent(bookedDate, timeSlot);
            String mentorMailContent = MailContentGenerator.generateMentorMailContent(bookedDate, timeSlot);

            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO bookings (date, timeslot, studentname, studentemail, mentorname, mentoremail) VALUES (?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, bookedDate);
            pstmt.setString(2, timeSlot);
            pstmt.setString(3, studentName);
            pstmt.setString(4, studentEmail);
            pstmt.setString(5, mentorName);
            pstmt.setString(6, mentorEmail);

            if (isStudentAlreadyBooked(studentEmail)) {
                // The student has already booked a mentor
                request.setAttribute("errorMessage", "You have already booked a mentor. Multiple bookings are not allowed.");
                RequestDispatcher rd = request.getRequestDispatcher("Student/mentorList.jsp");
                rd.forward(request, response);
                return;
            }

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                sendConfirmationEmail(studentEmail, mentorEmail, studentMailContent, mentorMailContent);
                request.setAttribute("message", "Sucessfully Booked!");
                RequestDispatcher rd = request.getRequestDispatcher("Student/mentorList.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Error in booking");
                RequestDispatcher rd = request.getRequestDispatcher("Student/mentorList.jsp");
                rd.forward(request, response);
            }

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (SQLException | MessagingException ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private String getStudentName(String studentEmail) throws SQLException {

        String name = "";
        Connection con = DBConnection.getConnection();
        String query = "select fullname from student where email=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, studentEmail);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            name = rs.getString("fullname");
        }
        return name;
    }

    private String getMentorName(String mentorEmail) throws SQLException {

        String name = "";
        Connection con = DBConnection.getConnection();
        String query = "select fullname from mentor where email=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, mentorEmail);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            name = rs.getString("fullname");
        }
        return name;
    }

    private boolean isStudentAlreadyBooked(String studentEmail) throws SQLException {
        Connection con = DBConnection.getConnection();
        String query = "SELECT * FROM bookings WHERE studentemail = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, studentEmail);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    private void sendConfirmationEmail(String studentEmail, String mentorEmail, String studentContent, String mentorContent) throws MessagingException {
        final String username = "mycareerpartner777@gmail.com";
        final String password = "manb kylw hkjb vnfk";

        // Set up the mail properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        // Create a mail session with the specified properties
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        // Create messages for student and mentor
        Message studentMessage = new MimeMessage(session);
        Message mentorMessage = new MimeMessage(session);

        // Set the sender's and recipient's email addresses for student
        studentMessage.setFrom(new InternetAddress(username));
        studentMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(studentEmail));

        // Set the subject and content of the message for student
        studentMessage.setSubject("Booking Confirmation");
        studentMessage.setText(studentContent);

        // Set the sender's and recipient's email addresses for mentor
        mentorMessage.setFrom(new InternetAddress(username));
        mentorMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(mentorEmail));

        // Set the subject and content of the message for mentor
        mentorMessage.setSubject("Counselling booked from student side");
        mentorMessage.setText(mentorContent);

        // Send the messages
        Transport.send(studentMessage);
        Transport.send(mentorMessage);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
