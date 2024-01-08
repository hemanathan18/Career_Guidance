<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="mcp.databaseConnection.DBConnection" %>

<span style="font-family: verdana, geneva, sans-serif;">
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <title>Student Dashboard</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/Student/style.css" />
            <!-- Font Awesome Cdn Link -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

            <style>
                table{
/*                    margin-right: 100px;*/
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
                p{
                    margin-top: 20px;
                }

            </style>

        </head>
        <body>
            <div class="container">
                <nav>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/Student/index.jsp" class="logo">
                                <img src="${pageContext.request.contextPath}/Student/img/CD.jpg" alt="" style="width: 40px; height: 40px;">
                                <span class="nav-item">
                                    <%
                                        String username = "";
                                        String studentToken = (String) session.getAttribute("studentToken");
                                        String studentEmail = (String) session.getAttribute("studentEmail");
                                        session.setAttribute("studentEmail", studentEmail);
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
                                <span class="nav-item">Home</span>
                            </a></li>
                        <li><a href="${pageContext.request.contextPath}/Student/profile.jsp">
                                <i class="fas fa-user"></i>
                                <span class="nav-item">My Profile</span>
                            </a></li>
                        <li><a href="${pageContext.request.contextPath}/Student/Counselling.jsp" >
                                <i class="fas fa-tasks"></i>
                                <span class="nav-item" >Counselling</span>
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

                <section class="main">

                    <div class="main-skills">
                        <div class="mlistcard">
                            <h2>Available Mentors</h2><br>
                            <%

                                String selectedDate = request.getParameter("selectedDate");
                                String selectedTimeSlot = request.getParameter("selectedTimeSlot");
                                String stream="";
                                Connection con = DBConnection.getConnection();
                                String query ="select stream from student where email=?";
                                PreparedStatement pstmt = con.prepareStatement(query);
                                pstmt.setString(1,studentEmail);
                           	ResultSet rs=pstmt.executeQuery();

                           	 while(rs.next())
                           	 {
                          	  stream = rs.getString("stream");
                                    }
                                String query1 = "SELECT DISTINCT email FROM mentor_availability WHERE from_date <= ? AND to_date >= ? AND time_slot = ? AND industry= ?";
                                PreparedStatement pstmt1 = con.prepareStatement(query1);
                                
                                pstmt1.setString(1, selectedDate);
                                pstmt1.setString(2, selectedDate);
                                pstmt1.setString(3, selectedTimeSlot);
                                pstmt1.setString(4, stream);
                                ResultSet rs1 = pstmt1.executeQuery();

                            %>

                            <table border="1" >
                                <tr>
                                   <!-- <th width="200">Email</th> -->
                                    <th width="100">Name</th>
                                    <th width="150">Industry</th>
                                    <th width="100">Action</th>
                                </tr>
                                
                                
                                 <%                                   
                                    boolean hasRecords = false;
                                    while (rs1.next()) {
                                        hasRecords = true;
                                        String mentorEmail = rs1.getString("email");
                                        
                                        String mentorDetailsQuery = "SELECT fullname, industry FROM mentor WHERE email = ?";
                                        PreparedStatement mentorDetailsPstmt = con.prepareStatement(mentorDetailsQuery);
                                        mentorDetailsPstmt.setString(1, mentorEmail);
                                        ResultSet mentorDetailsRs = mentorDetailsPstmt.executeQuery();

                                        if (mentorDetailsRs.next()) {
                                            String mentorName = mentorDetailsRs.getString("fullname");
                                            String mentorIndustry = mentorDetailsRs.getString("industry");


                                %>
                                
                                <tr>
                                   <!-- <td width="200"><%= mentorEmail%></td> -->
                                    <td width="100"><%= mentorName%></td>
                                    <td width="150"><%= mentorIndustry%></td>
                                   <!--//  <td width="100"><a href="${pageContext.request.contextPath}/BookingServleturl?mentorEmail=<%= mentorEmail%>&timeSlot=<%=selectedTimeSlot%>&date=<%=selectedDate%>">Book</a></td>-->
                                    <td width="100">
                                        <form action="${pageContext.request.contextPath}/BookingServleturl" method="post">
                                            <input type="hidden" name="mentorEmail" value="<%= mentorEmail%>" />
                                            <input type="hidden" name="timeSlot" value="<%= selectedTimeSlot%>" />
                                            <input type="hidden" name="date" value="<%= selectedDate%>" />
                                            <input style="background: orangered;" type="submit" value="Book">
                                        </form>
                                    </td>
                                </tr>

                                <%
                                        }
                                    }
                                    //if (!hasRecords) {
                                %>
                            </table>
                         <!-- <p>No mentors available at the selected date and time slot.</p>
                            <%
                                //}
                            %>

                            <!-- Table structure -->
                            <!--                            <table id="mentorsTable" border="1">
                                                            <thead>
                                                                <tr>
                                                                    <th>Mentor Name</th>
                                                                    <th>Expertise</th>
                                                                     Add more columns as needed 
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr class="mentorRow">
                                                                    <td>John Doe</td>
                                                                    <td>Programming</td>
                                                                     Add more columns as needed 
                                                                </tr>
                                                                <tr class="mentorRow">
                                                                    <td>Jane Smith</td>
                                                                    <td>Design</td>
                                                                     Add more columns as needed 
                                                                </tr>
                                                                 Add more mentor rows as needed 
                                                            </tbody>
                                                        </table>-->

                            <% String Message = (String) request.getAttribute("message"); %>
                            <% if (Message != null) {%>
                            <p style="color: green;"><%= Message%></p>
                            <% }%>

                            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                            <% if (errorMessage != null) {%>
                            <p style="color: red;"><%= errorMessage%></p>
                            <% }%>
                        </div>

                    </div>

                </section>

            </div>

            <!--<script>
      
              const mentorRows = document.querySelectorAll('.mentorRow');
      
              mentorRows.forEach(row => {
              row.addEventListener('click', function() {
                  const mentorName = row.cells[0].innerText; // Assuming mentor name is in the first column
                  confirmBooking(mentorName);
              });
              });
      
              function confirmBooking(mentorName) {
              // Here you can perform actions like booking confirmation, updating a database, etc.
              alert(`Booking confirmed for ${mentorName}!`);
              // You might want to perform further actions like redirecting or displaying a confirmation message.
              }
            </script>-->

            <script>
                let selectedMentor = null;

                const mentorRows = document.querySelectorAll('.mentorRow');

                mentorRows.forEach(row => {
                    row.addEventListener('click', function () {
                        const mentorName = row.dataset.mentor;

                        if (selectedMentor === mentorName) {
                            alert('You have already selected this mentor!');
                        } else {
                            if (selectedMentor !== null) {
                                alert('You have already selected a mentor! Please confirm or cancel the booking.');
                                return;
                            }

                            selectedMentor = mentorName;
                            confirmBooking(mentorName);
                        }
                    });
                });

                function confirmBooking(mentorName) {
                    // Here you can perform actions like booking confirmation, updating a database, etc.
                    alert(`Booking confirmed for {mentorName}!`);
                    // You might want to perform further actions like redirecting or displaying a confirmation message.
                }
                
                
                
            </script>

        </body>
    </html>
</span>