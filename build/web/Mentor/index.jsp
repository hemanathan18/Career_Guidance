<span style="font-family: verdana, geneva, sans-serif;"><!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <title>Mentor Dashboard</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/Mentor/style.css" />
      <!-- Font Awesome Cdn Link -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
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

        <section class="main">
            <div class="main-top">
            </div>
            <div class="main-skills">
              <div class="homecard">
                <!--<h3>Home</h3>-->
                <p>Share your knowledge and experience with the mentees to not only set better goals but to also choose the right paths. You could even guide the mentees in overcoming their weaknesses and roadblocks to help them succeed in their professional lives. <b>Mark your availability now to connect with our students!!!</b></p>
              </div>
              
            </div>
        </section>

      </div>
    </body>
</html>
</span>