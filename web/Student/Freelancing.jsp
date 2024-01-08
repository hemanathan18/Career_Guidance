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
                                <span class="nav-item">Counselling</span>

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
                    </div>
                    <div class="main-skills">
                        <div class="freecard">

                            <h3>Freelancing Sites</h1>
                                <p>Upwork</p>
                                <p>Fiverr</p>
                                <p>Toptal</p>
                                <p>Freelance</p>
                                <p>Guru</p>
                                <p>Servicescape</p>
                                <p>PeoplePerHour</p>
                                <p>Flexjobs</p>

                                <h3>Design & Developer jobs</h3>
                                <p>Solidgigs</p>
                                <!--<br>
                                <h3>Design jobs</h3><br>-->
                                <p>99designs</p>
                                <p>Dribbble</p>

                                <!--<h3>Video Editors Jobs</h3><br>
                                <p>Production HUB</p>
                                <p>Media Bistro</p>
                                <br>-->
                                <h3>Marketing jobs</h3>
                                <p>Time etc</p>
                                <p>Clickworker</p>
                        </div>
                    </div>
                </section>

            </div>
        </body>
    </html>
</span>