<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="mcp.databaseConnection.DBConnection" %>
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
              <h1>Profile</h1>
              <!--<i class="fas fa-user"></i>-->
            </div>
            <div class="main-skills">
              <div class="profilecard">
                <img src="${pageContext.request.contextPath}/Mentor/img/profileimg.png" alt="" style="width: 100px; height: 100px;">
                 <%
                            Connection con = DBConnection.getConnection();
                            String query = "select fullname,email,industry,experience,gender from mentor where email=?";
                            PreparedStatement pstmt = con.prepareStatement(query);
                            pstmt.setString(1, email);
                            ResultSet rs = pstmt.executeQuery();
                                    while (rs.next()) {
                                    String fullName = rs.getString(1);
                                    String menEmail = rs.getString(2);
                                    String industry = rs.getString(3);
                                    String experience = rs.getString(4);
                                    String gender = rs.getString(5);
                  
                            %>
                
                
                
                
                   <h3><%=fullName%></h3><br>
                   <p><%=menEmail%></p><br>
                   <p><%=industry%></p><br>
                   <p><%=experience%> Years</p><br>
                   <p><%=gender%></p><br>
                   <!--<button onclick="showUpdate()">Update Profile</button>-->
                   <%}%>
              </div>
            </div>
        </section>
        
      </div>

      <script>

        function showUpdate(){
          window.location.href='${pageContext.request.contextPath}/Mentor/update.jsp';
        }
      </script>
    </body>
    </html></span>