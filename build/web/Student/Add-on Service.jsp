<span style="font-family: verdana, geneva, sans-serif;">
    <!DOCTYPE html>
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



                <section class="main">
                    <div class="main-top">
                        <!--<h1>Additional Guides</h1>-->
                    </div>
                    <div class="main-skills">
                        <div class="agcard">
                            <i class="fas fa-book"></i>
                            <h3>Ebooks</h3>
                            <button onclick="showEbook()">View</button>
                        </div>

                        <div class="agcard">
                            <i class="fa fa-graduation-cap"></i>
                            <h3>Freelancing sites list</h3>
                            <button onclick="showFreelance()">View</button>
                        </div>


                    </div>
                </section>
            </div>

            <script>
                function showEbook() {
                    window.location.href = '${pageContext.request.contextPath}/Student/Ebook.jsp';
                }

                function showFreelance() {
                    window.location.href = '${pageContext.request.contextPath}/Student/Freelancing.jsp';
                }
            </script>
        </body>
    </html></span>