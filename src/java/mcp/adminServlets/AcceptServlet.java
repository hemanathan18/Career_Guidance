package mcp.adminServlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mcp.databaseConnection.DBConnection;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class AcceptServlet extends HttpServlet {

    private static final String approvedStatus = "Approved";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");

            // Update status in the mentorverification table
            updateStatusInDatabase(email, approvedStatus);

            // Retrieve mentor data from mentorverification
            String[] mentorData = getMentorData(email);

            // Insert approved mentor data into the mentor table
            insertMentorData(mentorData);

            // Send an email to the respective mentor
            sendApprovalEmail(mentorData[1]);

            response.sendRedirect("Admin/mpending.jsp");

        } catch (SQLException e) {
            // Log the error
            log("Error processing request", e);

        }
    }

    private void updateStatusInDatabase(String email, String status) throws SQLException {
        try (Connection con = DBConnection.getConnection()) {
            String updateQuery = "UPDATE mentorverification SET status=? WHERE email=?";
            try (PreparedStatement updateStatement = con.prepareStatement(updateQuery)) {
                updateStatement.setString(1, status);
                updateStatement.setString(2, email);
                updateStatement.executeUpdate();
            }
        }
    }

    private String[] getMentorData(String email) throws SQLException {
        try (Connection con = DBConnection.getConnection()) {
            String selectQuery = "SELECT fullname, email, industry, experience, gender, password FROM mentorverification WHERE email=?";
            try (PreparedStatement selectStatement = con.prepareStatement(selectQuery)) {
                selectStatement.setString(1, email);
                ResultSet rs = selectStatement.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullname");
                    String industry = rs.getString("industry");
                    String experience = rs.getString("experience");
                    String gender = rs.getString("gender");
                    String password = rs.getString("password");
                    // Returning mentor data as an array
                    return new String[]{fullName, email, industry, experience, gender, password};
                }
            }
        }
        return null;
    }

    private void insertMentorData(String[] mentorData) throws SQLException {
        if (mentorData != null) {
            try (Connection con = DBConnection.getConnection()) {
                String insertQuery = "INSERT INTO mentor (fullname, email, industry, experience, gender, password) VALUES (?, ?, ?, ?, ?,?)";
                try (PreparedStatement insertStatement = con.prepareStatement(insertQuery)) {
                    // Setting parameters from mentorData array
                    for (int i = 0; i < mentorData.length; i++) {
                        insertStatement.setString(i + 1, mentorData[i]);
                    }
                    insertStatement.executeUpdate();
                }
            }
        }
    }

    private void sendApprovalEmail(String recipientEmail) {
        final String username = "mycareerpartner777@gmail.com";
        final String password = "manb kylw hkjb vnfk";

        // Set up the mail properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Create a message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Your Mentor Application has been Approved");
            message.setText("Dear Mentor,\n\nCongratulations! Your mentor application has been approved.");

            // Send the message
            Transport.send(message);

            System.out.println("Email sent to: " + recipientEmail);
        } catch (MessagingException e) {
            e.printStackTrace(); 
        }
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
        return "Short description";
    }
}
