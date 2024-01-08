<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
              <div class="mucard">
                <img src="${pageContext.request.contextPath}/Admin/img/profileimg.png" alt="" style="width: 20px; height: 20px;">
                <h3>Student</h3>
                <button onclick="showstview()">View</button>
                <button onclick="showstupdate()">Update</button>
                <button onclick="showstdelete()">Delete</button>
              </div>

              <div class="mucard">
                <img src="${pageContext.request.contextPath}/Admin/img/profileimg.png" alt="" style="width: 20px; height: 20px;">
                <h3>Mentor</h3>
                <button onclick="showmpending()">Pending</button>
                <button onclick="showmview()">View</button>
                <button onclick="showmupdate()">Update</button>
                <button onclick="showmdelete()">Delete</button>
              </div> 

              <div class="mucard">
                <img src="${pageContext.request.contextPath}/Admin/img/profileimg.png" alt="" style="width: 20px; height: 20px;">
                <h3>Add-on Services</h3>
                <button onclick="showaosadd()">Add</button>
                <button onclick="showaosview()">View</button>
                <button onclick="showaosupdate()">Update</button>
                <button onclick="showaosdelete()">Delete</button>
              </div>

            </div>
        </section>

        <!--<section class="main">
            <div class="main-top"></div>
            <div class="main-skills">
              <div class="mucard">
                <img src="img/profileimg.png" alt="" style="width: 20px; height: 20px;">
                <h3>Student</h3>
                <button>View</button>
                <button>Update</button>
                <button>Delete</button>
              </div>

            </div>
        </section>-->

      </div>

      <script>

        function showstview()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/stview.jsp";
        }
        function showstupdate()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/stupdate.jsp";
        }
        function showstdelete()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/stdelete.jsp";
        }

        function showmpending()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/mpending.jsp";
        }
        function showmview()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/mview.jsp";
        }
        function showmupdate()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/mupdate.jsp";
        }
        function showmdelete()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/mdelete.jsp";
        }
        
        function showaosadd()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/aosadd.jsp";
        }
        function showaosview()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/aosview.jsp";
        }
        function showaosupdate()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/aosupdate.jsp";
        }
        function showaosdelete()
        {
          window.location.href="${pageContext.request.contextPath}/Admin/aosdelete.jsp";
        }

      </script>
    </body>
</html>
</span>
