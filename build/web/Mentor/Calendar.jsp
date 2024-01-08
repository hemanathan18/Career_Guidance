<span style="font-family: verdana, geneva, sans-serif;"><!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <title>Mentor Dashboard</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/Mentor/style.css" />
            <!-- Font Awesome Cdn Link -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
            <style>
                p{
                    margin-top: 15px;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <nav>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/Mentor/index.jsp"" class="logo">
                                <img src="${pageContext.request.contextPath}/Mentor/img/CD.jpg" alt="" style="width: 40px; height: 40px;">
                                <span class="nav-item"><%
                                    String username = "";
                                    String userToken = (String) session.getAttribute("userToken");
                                    String email = (String) session.getAttribute("email");
                                    request.setAttribute("mentorEmail", email);
                                    if (userToken == null || email == null) {
                                        response.sendRedirect("mentorlogin.jsp");
                                        return;
                                    } else {
                                        username = email.split("@")[0].trim();
                                    }

                                    %>
                                    <%=username%><br></span>
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

                <section class="main">
                    <div class="main-top">
                    </div>
                    <div class="main-skills">
                        <div class="Calendarcard">
                            <h1>Mentor Availability Calendar</h1><br>
                            <form action="${pageContext.request.contextPath}/AvailabilityServleturl" method="post" id="availabilityForm">
                                <label for="fromDate">From Date:</label>
                                <input type="date" id="fromDate" name="fromDate" required>
                                <br><br>
                                <label for="toDate">To Date:</label>
                                <input type="date" id="toDate" name="toDate" required>
                                <br><br>
                                Time: <select id="timeSlot" name="timeSlot">
                                    <option>09:00AM - 11:00AM</option>
                                    <option>11:00AM - 01:00PM</option>
                                    <option>01:00PM - 03:00PM</option>
                                    <option>03:00PM - 05:00PM</option>
                                    <option>05:00PM - 07:00PM</option>
                                </select>
                                <!--<label for="fromTime">From Time:</label>
                                <input type="time" id="fromTime" name="fromTime" required>-->
                                <!--<label for="toTime">To Time:</label>
                                <input type="time" id="toTime" name="toTime" required>-->
                                <br><br>
                                <input type="hidden" id="mEmail" name="mEmail" value="<%= request.getAttribute("mentorEmail")%>">

                                <input type="submit" value="Set Availability">

                            </form> 

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

            <script>

                document.getElementById('availabilityForm').addEventListener('submit', function (event) {
                    event.preventDefault();

                    const fromDateInput = document.getElementById('fromDate');
                    const toDateInput = document.getElementById('toDate');

                    // Get the entered dates
                    const fromDate = new Date(fromDateInput.value);
                    const toDate = new Date(toDateInput.value);
                    const today = new Date();

                    // Perform date validation
                    if (isValidDateRange(fromDate, toDate, today)) {
                        document.getElementById('availabilityForm').submit();
                    } else {
                        alert('Please enter a valid date range (present or future dates only)!');
                    }
                });

                function isValidDateRange(fromDate, toDate, today) {
                    // Check if 'To' date is after or equal to 'From' date
                    // Check if both dates are present or future dates
                    return toDate >= fromDate && fromDate >= today && toDate >= today;
                }

//                document.getElementById('availabilityForm').addEventListener('submit', function (event) {
//                    event.preventDefault();
//                    const fromDateInput = document.getElementById('fromDate');
//                    const toDateInput = document.getElementById('toDate');
//
//                    // Get the entered dates
//                    const fromDate = new Date(fromDateInput.value);
//                    const toDate = new Date(toDateInput.value);
//
//                    // Perform date validation
//                    if (validateDateRange(fromDate, toDate)) {
//                        alert('Availability set successfully!');
//                        // Here you can add code to save the availability to a database or perform other actions
//                        fromDateInput.value = ''; // Clear input after successful submission
//                        toDateInput.value = ''; // Clear input after successful submission
//                    } else {
//                        alert('Please enter a valid date range!');
//                    }
//                });
//
//                function validateDateRange(fromDate, toDate) {
//                    // Check if 'To' date is after or equal to 'From' date
//                    return toDate >= fromDate;
//                }
            </script>
        </body>
    </html>
</span>