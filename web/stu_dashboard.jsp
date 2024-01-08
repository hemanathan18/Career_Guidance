<%@page contentType="text/html" pageEncoding="UTF-8" import="jakarta.servlet.http.HttpSession"import="jakarta.servlet.http.HttpServletRequest"%>

<span style="font-family: verdana, geneva, sans-serif;"><!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <title>Student Dashboard</title>
            <link rel="stylesheet" href="Styles/dashboardstyle.css" />
            <!-- Font Awesome Cdn Link -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
        </head>
        <body>
            <div class="container">
                <nav>
                    <ul>
                        <li><a href="#" class="logo">
                                <img src="Media/logo.png" alt="" style="width: 40px; height: 40px;">
                                <span class="nav-item">
                                    <%
                                        String username = "";
                                        String userToken = (String) session.getAttribute("userToken");
                                        String email = (String) session.getAttribute("email");
                                        if (userToken == null || email == null) {
                                            response.sendRedirect("stu_login.jsp");
                                            return;
                                        } else {
                                            username = email.split("@")[0].trim();
                                        }

                                    %>
                                    <%=username%><br>


                                </span>
                            </a></li>
                        <li><a href="#">
                                <i class="fas fa-home"></i>
                                <span class="nav-item">Home</span>
                            </a></li>
                        <li><a href="">
                                <i class="fas fa-user"></i>
                                <span class="nav-item">My Profile</span>
                            </a></li>
                        <li><a href="">
                                <i class="fas fa-tasks"></i>
                                <span class="nav-item">Counselling</span>
                            </a></li>
                        <li><a href="">
                                <i class="fas fa-sticky-note"></i>
                                <span class="nav-item">Additional Guides</span>
                            </a></li>
                        <li><a href="">
                                <i class="fas fa-question-circle"></i>
                                <span class="nav-item">Help</span>
                            </a></li>
                        <li><a href="" class="logout">
                                <i class="fas fa-sign-out-alt"></i>
                                <span class="nav-item">Log out</span>
                            </a></li>
                    </ul>
                </nav>

                <section class="main">
                    <div class="main-top">
                        <h1>Counselling</h1>
                        <i class="fas fa-tasks"></i>
                    </div>
                    <div class="main-skills">
                        <div class="card">
                            <i class="fa fa-bookmark"></i>
                            <h3>Book</h3>
                            <button>Book</button>
                        </div>
                        <div class="card">
                            <i class="fa fa-eye"></i>
                            <h3>View</h3>
                            <button>View</button>
                        </div>

                    </div>


                    <section class="main">
                        <div class="main-top">
                            <h1>Additional Guides</h1>
                            <i class="fas fa-sticky-note "></i>
                        </div>
                        <div class="main-skills">
                            <div class="card">
                                <i class="fas fa-book"></i>
                                <h3>Ebooks</h3>
                                <button>View</button>
                            </div>
                            <div class="card">
                                <i class="fa fa-graduation-cap"></i>
                                <h3>Academic details</h3>
                                <button>View</button>
                            </div>

                        </div>

                    </section>
                </section>
            </div>
        </body>
    </html></span>