<span style="font-family: verdana, geneva, sans-serif;"><!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <title>Student Dashboard</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/Student/style.css" />
            <!-- Font Awesome Cdn Link -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
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
                                        if (studentToken == null || studentEmail == null) {
                                            response.sendRedirect("mentorlogin.jsp");
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
                        <div class="slotcard">
                            <h3>Slot Booking</h3><br>
                            <form action="${pageContext.request.contextPath}/Student/mentorList.jsp" method="post">
                                Date: <input type="date" id="selectedDate" name="selectedDate"  ><br>
                                <br>
                                Time: <select id="selectedTimeSlot" name="selectedTimeSlot">
                                    <option>09:00AM - 11:00AM</option>
                                    <option>11:00AM - 01:00PM</option>
                                    <option>01:00PM - 03:00PM</option>
                                    <option>03:00PM - 05:00PM</option>
                                    <option>05:00PM - 07:00PM</option>
                                    <!--              <option>09:00AM - 09:15AM</option>
                                                      <option>09:15AM - 09:30AM</option>
                                                      <option>09:30AM - 09:45AM</option>
                                                      <option>09:45AM - 10:00AM</option>
                                                      <option>10:00AM - 10:15AM</option>
                                                      <option>10:15AM - 10:30AM</option>
                                                      <option>10:30AM - 10:45AM</option>
                                                      <option>10:45AM - 11:00AM</option>
                                                      <option>11:00AM - 11:15AM</option>
                                                      <option>11:15AM - 11:30AM</option>
                                                      <option>11:30AM - 11:45AM</option>
                                                      <option>11:45AM - 12:00PM</option>
                                                      <option>12:00PM - 12:15PM</option>
                                                      <option>12:15PM - 12:30PM</option>
                                                      <option>12:30PM - 12:45PM</option>
                                                      <option>12:45PM - 01:00PM</option>
                                                      <option>01:00PM - 01:15PM</option>
                                                      <option>01:15PM - 01:30PM</option>
                                                      <option>01:30PM - 01:45PM</option>
                                                      <option>01:45PM - 02:00PM</option>
                                                      <option>02:00PM - 02:15PM</option>
                                                      <option>02:15PM - 02:30PM</option>
                                                      <option>02:30PM - 02:45PM</option>
                                                      <option>02:45PM - 03:00PM</option>
                                                      <option>03:00PM - 03:15PM</option>
                                                      <option>03:15PM - 03:30PM</option>
                                                      <option>03:30PM - 03:45PM</option>
                                                      <option>03:45PM - 04:00PM</option>
                                                      <option>04:00PM - 04:15PM</option>
                                                      <option>04:15PM - 04:30PM</option>
                                                      <option>04:30PM - 04:45PM</option>
                                                      <option>04:45PM - 05:00PM</option>
                                                      <option>05:00PM - 05:15PM</option>
                                                      <option>05:15PM - 05:30PM</option>
                                                      <option>05:30PM - 05:45PM</option>
                                                      <option>05:45PM - 06:00PM</option>
                                                      <option>06:00PM - 06:15PM</option>
                                                      <option>06:15PM - 06:30PM</option>
                                                      <option>06:30PM - 06:45PM</option>
                                                      <option>06:45PM - 07:00PM</option>-->
                                </select><br>
                                <!--<input type="time" ><br><br>-->
                                <!--<button onclick="showMentorList()">Go</button>-->
                                <button type="submit" value="GO">Go</button>
                            </form>
                        </div>

                    </div>

            </div>

            <script>

                function showMentorList()
                {
                    window.location.href = '${pageContext.request.contextPath}/Student/mentorList.jsp';
                }

            </script>

        </body>
    </html></span>