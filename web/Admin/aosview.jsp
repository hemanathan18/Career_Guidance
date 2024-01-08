<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@page import="mcp.databaseConnection.DBConnection"%>
<span style="font-family: verdana, geneva, sans-serif;"><!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <title>Admin Dashboard</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/Admin/style.css" />
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
                        <div class="aosviewcard">

                            <h2>All E-books List</h2>

                            <table>
                                <tr>
                                    <th width="50">S.No</th>
                                    <th width="150">Book Name</th>
                                    <th width="200">Stream</th>
                                    <th width="70">Document</th>
                                </tr>


                                <%
                                    int sNo = 0;
                                    Connection con = DBConnection.getConnection();
                                    String query = "select filename,stream,filepath from ebooks;";
                                    PreparedStatement pstmt = con.prepareStatement(query);
                                    ResultSet rs = pstmt.executeQuery();
                                    while (rs.next()) {
                                        String fileName = rs.getString(1);
                                        String category = rs.getString(2);
                                        String documentBook = rs.getString(3);
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
                        </div>

                    </div>
                </section>

            </div>
        </body>
    </html>
</span>