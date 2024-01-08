<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="mcp.databaseConnection.DBConnection" %>

<span style="font-family: verdana, geneva, sans-serif;"><!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <title>Student Dashboard</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/Student/style.css" />
            <!-- Font Awesome Cdn Link -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
            
            <style>
                table{
                    margin: auto;
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

            </style>
        </head>
        <body>
            <div class="container" >
                <nav>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/Student/index.jsp" class="logo">
                                <img src="${pageContext.request.contextPath}/Student/img/CD.jpg" alt="" style="width: 40px; height: 40px;">
                                <span class="nav-item">
                                    <%
                                        String username = "";
                                        String studentToken = (String) session.getAttribute("studentToken");
                                        String studentEmail = (String) session.getAttribute("studentEmail");
                                        if (studentToken == null || studentEmail == null) {
                                            response.sendRedirect("stu_login.jsp");
                                            return;
                                        } else {
                                            username = studentEmail.split("@")[0].trim();
                                        }

                                    %>
                                    <%=username%><br>
                                </span>
                            </a></li>
                        <li><a href="${pageContext.request.contextPath}/Student/index.jsp">
                                <i class="fas fa-home"></i>
                                <span class="nav-item" id="myBtn">Home</span>
                            </a></li>
                        <li><a href="${pageContext.request.contextPath}/Student/profile.jsp">
                                <i class="fas fa-user"></i>
                                <span class="nav-item">My Profile</span>
                            </a></li>
                        <li><a href="${pageContext.request.contextPath}/Student/Counselling.jsp">
                                <i class="fas fa-tasks"></i>
                                <span class="nav-item" id="contain">Counselling</span>
                            </a></li>
                        <li><a href="${pageContext.request.contextPath}/Student/Add-on Service.jsp">
                                <i class="fas fa-sticky-note"></i>
                                <span class="nav-item">Add-on Service</span>
                            </a></li>
                        <li><a href="${pageContext.request.contextPath}/Student/Contact.jsp">
                                <i class="fas fa-question-circle"></i>
                                <span class="nav-item">Contact Us</span>
                            </a></li>
                        <li><a href="${pageContext.request.contextPath}/LogoutServleturl" class="logout">
                                <i class="fas fa-sign-out-alt"></i>
                                <span class="nav-item">Log out</span>
                            </a></li>
                    </ul>
                </nav>


                <section class="main" >
                    <div class="main-top">
                        <h1>Counselling</h1>
                    </div>
                    <div class="main-skills">
                        <div class="counselcard">
                            <i class="fas fa-calendar-check"></i>
                            <h3>Slot Booking</h3>
                            <button onclick="showCalendar()">Book</button>
                        </div>

                    </div>


                    <section class="main" >
                        <div class="main-top"></div>
                        <div class="main-skills">
                            <div class="tabelcard">
                                <h2>Slot Booking Status</h2>

                                <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DBConnection.getConnection();
            String query = "SELECT bookingid ,date,timeslot,mentorname  from bookings where studentemail =?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, studentEmail);
            ResultSet rs = ps.executeQuery();
        %>
        <table>
            <tr>
                <th width="50">Booking ID</th>
                <th width="250">Date</th>
                <th width="200">Time Slot</th>
                <th width="250">Mentor</th>
                <!--  <th width="270">Mentor Email</th> -->  
            </tr>
            
            <%
                boolean hasRecords = false;

                while (rs.next()) {
                    hasRecords = true;
                    String bookingID = rs.getString(1);
                    String bookingDate = rs.getString(2);
                    String timeSlot = rs.getString(3);
                    String mentorName = rs.getString(4);
                  //String mentorEmail = rs.getString("mentoremail");
                   

            %>
            <tr>
                <td width="50"><%=bookingID%></td>
                <td width="250"><%=bookingDate%></td>
                <td width="200"><%=timeSlot%></td>
                <td width="250"><%=mentorName%></td>
              
            </tr>
            
            <%
                }
                if (!hasRecords) {
            %>
        </table>
        <p>No Bookings found.</p>
        <%
            }
        %>

            
       
        
        <!--                            <table>
                                    <tr>
                                        <th>BookingID</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th>Time</th>
                                        <th>Mentor Name</th>
<!--                                    </tr>
                                    <tr>
                                        <td>1234</td>
                                        <td>Booked</td>
                                        <td>20/10/2023</td>
                                        <td>10:52</td>
                                        <td>Sara</td>
                                    </tr>
                                    <tr>
                                        <td>2345</td>
                                        <td>Booked</td>
                                        <td>21/10/2023</td>
                                        <td>10:52</td>
                                        <td>Saro</td>
                                    </tr>
                                    <tr>
                                        <td>2345</td>
                                        <td>Booked</td>
                                        <td>21/10/2023</td>
                                        <td>10:52</td>
                                        <td>Saro</td>-->
<!--                                    </tr>
                                    <tr>
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
                                    </tr>
                                </table>-->


                            </div>

                        </div>

                    </section>
                </section>
            </div>

            <script>

                function showCalendar()
                {
                    window.location.href = '${pageContext.request.contextPath}/Student/Calendar.jsp';
                }

            </script>

        </body>
    </html>
</span>