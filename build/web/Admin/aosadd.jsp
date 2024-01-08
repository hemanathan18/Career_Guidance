<span style="font-family: verdana, geneva, sans-serif;">
    <!DOCTYPE html>
    <html>
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
              <div class="aosaddcard">
                  <div class="uploadcontainer">
                <form class="uploadForm" action="${pageContext.request.contextPath}/EbookUploadServleturl" method="post" enctype="multipart/form-data">
            <label for="filename"><b>File Name</b></label><br>
            <input type="text" id="filename" name="filename"/><br>
            <label for="stream"><b>Stream</b></label><br>
            <select name="stream" id="stream">
                <option value="NULL">Select an option</option>
                <option value="Animation & Graphics">Animation & Graphics</option>
                <option value="Arts & Economics">Arts & Economics</option>
                <option value="Architecture & Civil">Architecture & Civil</option>
                <option value="Commerce & Accounts">Commerce & Accounts</option>
                <option value="Computer Application & IT">Computer Application & IT</option>
                <option value="Defense">Defense</option>
                <option value="Distribution & Logistics">Distribution & Logistics</option>
                <option value="Education and Training">Education and Training</option>
                <option value="Engineering">Engineering</option>
                <option value="Entrepreneurship">Entrepreneurship</option>
                <option value="Finance & Banking">Finance & Banking</option>
                <option value="Food and Agriculture">Food and Agriculture</option>
                <option value="Hotel Management">Hotel Management</option>
                <option value="Law & Legal studies">Law & Legal studies</option>
                <option value="Life science">Life science</option>
                <option value="Management & Administration">Management & Administration</option>
                <option value="Marketing & Sales">Marketing & Sales</option>
                <option value="Maths & Statistics">Maths & Statistics</option>
                <option value="Media & Communication">Media & Communication</option>
                <option value="Medicine">Medicine</option>

                <!--                <option value="NULL">Select an option</option>
                                <option value="Information Technology">Information Technology</option>
                                <option value="Mechanical">Mechanical</option>
                                <option value="Civil">Civil</option>
                                <option value="Automobile">Automobile</option>-->
            </select><br>
            <label for="ebook"><b>Ebook Filename</b></label><br>
            <input type=file name="ebook" id="ebook" accept=".pdf, .doc, .docx" onchange="validateFileSize()" required /><br>
            <small>*Only PDF, DOC, DOCX. Within 5MB</small><br>
            <input type="submit" value="upload"/>

        </form>
        <% String Message = (String) request.getAttribute("success"); %>
        <% if (Message != null) {%>
        <p style="color: green;"><%= Message%></p>
        <% }%>
              </div>
              </div>
              
            </div>
        </section>

      </div>
    </body>
    <script>
        function validateFileSize() {
            var input = document.getElementById('edoc');
            var fileSize = input.files[0].size; // Size in bytes
            var maxSizeInBytes = 5 * 1024 * 1024; // 5 MB
            var allowedFormats = ['.pdf', '.doc', '.docx'];
            var fileName = input.value.toLowerCase();
            var fileExtension = fileName.substring(fileName.lastIndexOf('.'));
            var isValidFormat = allowedFormats.includes(fileExtension);



            if (fileSize > maxSizeInBytes || !isValidFormat) {
                if (fileSize > maxSizeInBytes) {
                    alert('Check the size or format of the file');
                } else if (!isValidFormat) {
                    alert('Invalid file format');
                }
                // Reset the file input if needed
                input.value = '';
            }
        }
    </script>
</html>
</span>