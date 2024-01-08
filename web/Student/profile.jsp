<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="mcp.databaseConnection.DBConnection" %>
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
                        <li><a href="${pageContext.request.contextPath}/Student/Contact.html">
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
                        <h1>Profile</h1>
                    </div>
                    <div class="main-skills">
                        <div class="profilecard">
                            <img src="${pageContext.request.contextPath}/Student/img/profileimg.png" alt="" style="width: 100px; height: 100px;"><br><br>
                            <%
                            Connection con = DBConnection.getConnection();
                            String query = "select fullname,email ,education,stream,gender from student where email=?";
                            PreparedStatement pstmt = con.prepareStatement(query);
                            pstmt.setString(1, studentEmail);
                            ResultSet rs = pstmt.executeQuery();
                                    while (rs.next()) {
                                    String fullName = rs.getString(1);
                                    String stuEmail = rs.getString(2);
                                    String education = rs.getString(3);
                                    String stream = rs.getString(4);
                                    String gender = rs.getString(5);
                  
                            %>
                            <h3><%=fullName%></h3><br>
                            <p><%=stuEmail%></p><br>
                            <p><%=education%></p><br>
                            <p><%=stream%></p><br>
                            <p><%=gender%></p><br>

                            <!--<button onclick="showUpdate()">Update Profile</button>-->  
                           <%}%>
                        </div>

                    </div>
                </section>
            </div>

            <script>

                function showUpdate() {
                    window.location.href = '${pageContext.request.contextPath}/Student/Update.jsp';
                }

            </script>
        </body>
    </html>
</span>