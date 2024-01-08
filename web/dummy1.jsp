<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="mcp.databaseConnection.DBConnection" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Mentor List</title>
        <style>
            table{
                margin: auto;
            }
            td,h2,p{
                text-align: center;
            }

        </style>
    </head>
    <body>

        <%

            String selectedDate = request.getParameter("selectedDate");
            String selectedTimeSlot = request.getParameter("selectedTimeSlot");
//            String mentorEmails="";
            Connection con = DBConnection.getConnection();
            String query = "SELECT DISTINCT email FROM mentor_availability WHERE from_date <= ? AND to_date >= ? AND time_slot = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, selectedDate);
            pstmt.setString(2, selectedDate);
            pstmt.setString(3, selectedTimeSlot);
            ResultSet rs = pstmt.executeQuery();

        %>
        <h2>Available Mentors</h2>
        <table border="1" >
            <tr>
                <th width="200">Email</th>
                <th width="100">Name</th>
                <th width="150">Industry</th>
                <th width="100">Action</th>
            </tr>

            <%               
                boolean hasRecords = false;
                while (rs.next()) {
                    hasRecords = true;
                    String mentorEmails = rs.getString("email");

                    String mentorDetailsQuery = "SELECT fullname, industry FROM mentor WHERE email = ?";
                    PreparedStatement mentorDetailsPstmt = con.prepareStatement(mentorDetailsQuery);
                    mentorDetailsPstmt.setString(1, mentorEmails);
                    ResultSet mentorDetailsRs = mentorDetailsPstmt.executeQuery();

                    if (mentorDetailsRs.next()) {
                        String mentorName = mentorDetailsRs.getString("fullname");
                        String mentorIndustry = mentorDetailsRs.getString("industry");


            %>
            <tr>
                <td width="200"><%= mentorEmails%></td>
                <td width="100"><%= mentorName%></td>
                <td width="150"><%= mentorIndustry%></td>
                <td width="100"><a href="#">Book</a></td>
            </tr>

            <%
                }
                }
                if (!hasRecords) {
            %>
        </table>
        <p>No mentors available at the selected date and time slot.</p>
        <%
            }
        %>
    </body>
</html>
