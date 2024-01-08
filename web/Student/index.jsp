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
                    <div class="main-top"></div>
                    <div class="main-skills">
                        <div class="homecard">

                            <!-- <h3>Home</h3>-->
                            <p>Our Career Counselling Session begins with an assessment of an individual's skills, interests, and strengths. This information is then used to identify potential career paths that may be a good fit. Our Mentors will provide information about various occupations, such as job requirements, growth potential, and earning potential. <br><b>Book your Session now!!!</b></p>
                            <!--<p>A Career Guidance System where students can see various career opportunities, the system shows various fields available after 12th for graduation and also fields available after graduation. It also lists various colleges available where students can search colleges by their courses. Next the system also allows users to give a guidance. It is actually very helpful for choosing a correct way to achieve our destiny. After getting the guidance you may feel confident to choose your career path. By this a 12th finished students will also have some clarity in choosing their career</p>-->
                        </div>

                    </div>

                    <!--<section class="main">
                      <div class="main-top">
                        <h1>Profile</h1>
                        <i class="fas fa-user"></i>
                      </div>
                      <div class="main-skills">
                        <div class="profilecard">
                          <img src="img/profileimg.png" alt="" style="width: 100px; height: 100px;">
                             <h3>SarojaBaskaran</h3>
                             <p>Saroja2510@gmail.com</p>
                             <p>BE CSE</p>
                             <p>Information Technology</p>
                             <p>Female</p>
                             <a href="Update.html">
                             <button>Update Profile</button>
                            </a>
                        </div>
                        
                      </div>
            
             <section class="main">
                    <div class="main-top">
                      <h1>Profile</h1>
                      <i class="fas fa-home"></i>
                    </div>
                    <div class="main-skills">
                      <div class="card">
                        <img src="img/student.jpg" alt="" style="width: 40px; height: 40px;">
                         <h3 class="name">shaikh anas</h3>
                         <p class="role">studen</p>
                         <button>Update Profile</button>
                      </div>
                      
                    </div>
            
            
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
                  </section>
                </div> -->

                </section>

               
            </div>
        </body>
    </html></span>