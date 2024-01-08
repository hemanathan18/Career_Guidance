<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="mcp.databaseConnection.DBConnection" %>

<span style="font-family: verdana, geneva, sans-serif;"><!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <title>Mentor Dashboard</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/Mentor/style.css" />
      <!-- Font Awesome Cdn Link -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
      <style>
                table{
                    border-collapse: collapse;
                }
                td,h2,p{
                    text-align: center;
                }
                td,th{
                    border: 1px solid black;
                    padding: 8px;
                    text-align: center;
                }
                h2{
                    margin-bottom: 10px;
                }
                p{
                    margin-top: 10px;
                }

            </style>
    </head>
    <body>
      <div class="container">
        <nav>
          <ul>
            <li><a href="${pageContext.request.contextPath}/Mentor/index.jsp"" class="logo">
              <img src="${pageContext.request.contextPath}/Mentor/img/CD.jpg" alt="" style="width: 40px; height: 40px;">
              <span class="nav-item">
                  <%
                                        String username = "";
                                        String userToken = (String) session.getAttribute("userToken");
                                        String email = (String) session.getAttribute("email");
                                        if (userToken == null || email == null) {
                                            response.sendRedirect("mentorlogin.jsp");
                                            return;
                                        } else {
                                            username = email.split("@")[0].trim();
                                        }

                                    %>
                                    <%=username%><br>
              </span>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/Mentor/index.jsp">
              <i class="fas fa-home"></i>
              <span class="nav-item">Home</span>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/Mentor/profile.jsp">
              <i class="fas fa-user"></i>
              <span class="nav-item">My Profile</span>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/Mentor/counsel.jsp">
              <i class="fas fa-calendar"></i>
              <span class="nav-item">Counselling Session</span>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/Mentor/Contact.jsp">
              <i class="fas fa-question-circle"></i>
              <span class="nav-item">Contact Us</span>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/MLogoutServleturl" class="logout">
              <i class="fas fa-sign-out-alt"></i>
              <span class="nav-item">Log out</span>
            </a></li>
          </ul>
        </nav>

        <section class="main" >
            <div class="main-top">
            </div>
            <div class="main-skills">
              <div class="tabelcard">
                <h2>Scheduled Session</h2>
    <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DBConnection.getConnection();
            String query = "SELECT bookingid ,date,timeslot,studentname,studentemail from bookings where mentoremail =?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
        %>
        <table>
            <tr>
                <th width="50">Booking ID</th>
                <th width="250">Date</th>
                <th width="200">Time Slot</th>
                <th width="250">Student</th>
                <th width="270">Student Email</th>
            </tr>
            
            <%
                boolean hasRecords = false;

                while (rs.next()) {
                    hasRecords = true;
                    String bookingID = rs.getString(1);
                    String bookingDate = rs.getString(2);
                    String timeSlot = rs.getString(3);
                    String studentName = rs.getString(4);
                    String studentEmail = rs.getString("studentemail");
                   

            %>
            <tr>
                <td width="50"><%=bookingID%></td>
                <td width="250"><%=bookingDate%></td>
                <td width="200"><%=timeSlot%></td>
                <td width="250"><%=studentName%></td>
                <td width="270"><%=studentEmail%></td>
            </tr>
            
            <%
                }
                if (!hasRecords) {
            %>
        </table>
        <p>No Schedules found.</p>
        <%
            }
        %>                   
                
<!--                <table>
                  <tr>
                    <th>Booking ID</th>
                    <th>Student Name</th>
                    <th>Date</th>
                    <th>Time</th>
                  </tr>
                  <tr>
                    <td>123</td>
                    <td>Hemanadhan</td>
                    <td>28/12/2023</td>
                    <td>11:30</td>
                  </tr>
                  <tr>
                    <td>234</td>
                    <td>Saranya</td>
                    <td>28/12/2023</td>
                    <td>12:30</td>
                  </tr>
                  <tr>
                    <td>345</td>
                    <td>Saroja</td>
                    <td>28/12/2023</td>
                    <td>01.30</td>
                  </tr>-->
                  <!--<tr>
                    <td>Island Trading</td>
                    <td>Helen Bennett</td>
                    <td>UK</td>
                  </tr>
                  <tr>
                    <td>Laughing Bacchus Winecellars</td>
                    <td>Yoshi Tannamuri</td>
                    <td>Canada</td>
                  </tr>
                  <tr>
                    <td>Magazzini Alimentari Riuniti</td>
                    <td>Giovanni Rovelli</td>
                    <td>Italy</td>
                  </tr>-->
<!--                </table>-->

      </div>
    </body>
</html>
</span>