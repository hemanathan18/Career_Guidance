<span style="font-family: verdana, geneva, sans-serif;"><!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <title>Admin Dashboard</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/Admin/style.css" />
      <!-- Font Awesome Cdn Link -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    </head>
    <body>
      <div class="container">
        <nav>
          <ul>
            <li><a href="#" class="logo">
              <img src="${pageContext.request.contextPath}/Admin/img/CD.jpg" alt="" style="width: 40px; height: 40px;">
              <span class="nav-item">
                  <%
                                        String adminName = "";
                                        String adminEmail = (String) session.getAttribute("adminEmail");
                                        String adminToken = (String) session.getAttribute("adminToken");
                                        if (adminToken == null || adminEmail == null) {
                                            response.sendRedirect("adminlogin.jsp");
                                            return;
                                        } else {
                                            adminName = adminEmail.split("@")[0].trim();
                                        }

                                    %>
                                    <%=adminName%>
              </span>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/Admin/index.jsp">
              <i class="fas fa-home"></i>
              <span class="nav-item">Home</span>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/Admin/manageusers.jsp">
              <i class="fas fa-user"></i>
              <span class="nav-item">Manage Users</span>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/Admin/managesessions.jsp" >
              <i class="fas fa-tasks"></i>
              <span class="nav-item">Manage Sessions</span>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/Admin/reports.jsp">
              <i class="fas fa-sticky-note"></i>
              <span class="nav-item">Reports</span>
            </a></li>
            <!--<li><a href="pendingmentor.jsp">
              <i class="fas fa-question-circle"></i>
              <span class="nav-item">Pending Mentors</span>
            </a></li>-->
            <li><a href="${pageContext.request.contextPath}/AdminLogoutServleturl" class="logout">
              <i class="fas fa-sign-out-alt"></i>
              <span class="nav-item">Log out</span>
            </a></li>
          </ul>
        </nav>

        <section class="main">
            <div class="main-top"></div>
            <div class="main-skills">
              
                <div class="reportcard">
                <img src="${pageContext.request.contextPath}/Admin/img/profileimg.png" alt="" style="width: 20px; height: 20px;">
                <h3>Student</h3>
                <button onclick="showliststudent()">List of Students</button>
              </div>

              <div class="reportcard">
                <img src="${pageContext.request.contextPath}/Admin/img/profileimg.png" alt="" style="width: 20px; height: 20px;">
                <h3>Mentor</h3>
                <button onclick="showlistmentor()">List of Mentors</button>
              </div>

              <div class="reportcard">
                <i class="fa fa-graduation-cap"></i>
                <h3>Counselling Session</h3>
                <button onclick="showlistbooked()">List of Booked Sessions</button>
              </div>
                            
            </div>
            </section>
      </div>

      <script>

        function showliststudent()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/liststudent.jsp";
        }
        function showlistmentor()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/listmentor.jsp";
        }
        function showlistbooked()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/listbooked.jsp";
        }

      </script>
    </body>
</html>
</span>
