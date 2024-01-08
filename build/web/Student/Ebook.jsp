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
            <style>
                table{
                    /*margin-right: 100px;*/
                    border-collapse: collapse;
                    /*margin-left: 15%;*/
                    /*margin-right: 40%;*/
                    
                }
                td,h2,p{
                    text-align: center;
                }
                td,th{
                    border: 1px solid black;
                    padding: 8px;
                    text-align: center;
                }

            </style>
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


                <section class="main" >
                    <div class="main-top">
                    </div>
                    <div class="main-skills">
                        <div class="ebooktabelcard">
                            <h2>E-books</h2>
                            
                            <table>
                                <tr>
                                    <th width="50">S.No</th>
                                    <th width="150">Book Name</th>
                                    <th width="200">Stream</th>
                                    <th width="70">Document</th>
                                </tr>
                            
                            <%
                            int sNo=0;    
                            String stream="";
                            Connection con = DBConnection.getConnection();
                            String query ="select stream from student where email=?";
                            PreparedStatement pstmt = con.prepareStatement(query);
                            pstmt.setString(1,studentEmail);
                            ResultSet rs=pstmt.executeQuery();
                            while(rs.next())
                            {
                            stream = rs.getString("stream");
                            }
                             
                            String ebookQuery ="select filename,stream,filepath from ebooks where stream=?";
                            PreparedStatement ebookps = con.prepareStatement(ebookQuery);
                            ebookps.setString(1, stream);
                            ResultSet rs2 =ebookps.executeQuery();
                            while(rs2.next())
                            {
                            String fileName=rs2.getString(1);
                            String category=rs2.getString(2);
                            String documentBook=rs2.getString(3);
                            sNo++;
                            
                            %>
                            <tr>
                                <td width="50"><%=sNo%></td>
                                <td width="150"><%=fileName%></td>
                                <td width="200"><%=category%></td>
                                <td width="70"><a href="${pageContext.request.contextPath}/Ebook?filename=<%=documentBook%>"> <i class="fas fa-book"></i></a>
                                </td>
                                
                            </tr>
                            <%}%>
                            </table>
                            <!-- <table>
                                <tr>
                                    <th>S.No</th>
                                    <th>Ebook Name</th>
                                    <th>Download Link</th>
                                </tr>
                                <tr>
                                    <td>1</td>
                                    <td>HTML</td>
                                    <td>html</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>CSS</td>
                                    <td>css</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>JavaScript</td>
                                    <td>Js</td>
                                </tr>
                                <!--<tr>
                                  <td>Island Trading</td>
                                  <td>Helen Bennett</td>
                                  <td>UK</td>
                                </tr>
                                <tr>
                                  <td>Laughing Bacchus Winecellars</td>
                                  <td>Yoshi Tannamuri</td>
                                  <td>Canada</td>
                                </tr>
                                <tr>
                                  <td>Magazzini Alimentari Riuniti</td>
                                  <td>Giovanni Rovelli</td>
                                  <td>Italy</td>
                                </tr>
                            </table>-->

                        </div>
                    </div>
                </section>

            </div>
        </body>
    </html>
</span>