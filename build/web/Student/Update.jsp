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
                    <div class="main-top">
                    </div>
                    <div class="main-skills">
                        <div class="Updatecard">

                            <center>
                                <h1>Update Profile</h1><br>
                                <form>
                                    <table>

                                        <tr>
                                            <td>Full Name:</td> <td> <input type="text" style="border-color: black;"></td>
                                        </tr>

                                        <tr>
                                            <td>Email:</td> <td> <input type="email"></td>
                                        </tr>

                                        <tr>
                                            <td>Educational Details</td>
                                            <td>
                                                <select>
                                                    <option>Postgraduate</option>
                                                    <option>Under graduate</option>
                                                    <option>HSC</option>
                                                    <option>SSLC</option>
                                                </select>
                                            </td>
                                        </tr><br>

                                        <tr>
                                            <td>Area of interest</td>
                                            <td>
                                                <select>
                                                    <option>Animation & Graphics</option>
                                                    <option>Arts & Economics</option>
                                                    <option>Architecture & Civil</option>
                                                    <option>Commerce & Accounts</option>
                                                    <option>Computer Application & IT</option>
                                                    <option>Defense</option>
                                                    <option>Distribution & Logistics</option>
                                                    <option>Education and Training</option>
                                                    <option>Engineering</option>
                                                    <option>Entrepreneurship</option>
                                                    <option>Finance & Banking</option>
                                                    <option>Food and Agriculture</option>
                                                    <option>Hotel Management</option>
                                                    <option>Law & Legal studies</option>
                                                    <option>Life science</option>
                                                    <option>Management & Administration</option>
                                                    <option>Marketing & Sales</option>
                                                    <option>Maths & Statistics</option>
                                                    <option>Media & Communication</option>
                                                    <option>Medicine</option>
                                                </select>
                                            </td>
                                        </tr><br>

                                        <!--<tr>
                                            <td>Password:</td> <td> <input type="text"></td>
                                        </tr>
                        
                                        <tr>
                                            <td>Confirm Password:</td> <td> <input type="text"></td>
                                        </tr>-->

                                        <tr>
                                            <td>Gender:</td> 
                                            <td>
                                                <select>
                                                    <option>Male</option>
                                                    <option>Female</option>
                                                    <option>Other</option>
                                                </select>
                                            </td>
                                        </tr>

                                        <!-- <tr>
                                             <td>Email:</td> <td><input type="text"></td>
                                         </tr>
                         
                                         <tr>
                                             <td><input type="button" value="Submit" style="background: orangered; color: #fff; padding: 7px 15px; border-radius: 10px; cursor: pointer;"></td>
                                         </tr>-->

                                    </table>

                                    <br>

                                    <input type="button" value="Submit" style="background: orangered; color: #fff; padding: 7px 15px; border-radius: 10px; cursor: pointer; ">

                                </form>
                            </center>

                        </div>

                    </div>
                </section>
            </div>

            <script>

                function showHome() {

                    window.location.href = '${pageContext.request.contextPath}/Student/index.jsp';

                }

            </script>

        </body>
    </html></span>