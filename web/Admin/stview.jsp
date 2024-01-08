<%@page import="mcp.databaseConnection.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>

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
              <div class="stviewcard">
             
                   <h2>Students List</h2>
                <jsp:useBean id="db" class="mcp.databaseConnection.DBConnection"/>

        <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = db.getConnection();
            String selectQuery = "SELECT fullname,email,education,stream,gender FROM student";
            PreparedStatement selectStatement = con.prepareStatement(selectQuery);
            ResultSet rs = selectStatement.executeQuery();
        %>

        <table border="1" >
            <tr>
                <th width="120">Name</th>
                <th width="200">Email</th>
                <th width="80">Education</th>
                <th width="160">Stream</th>
                <th width="80">Gender</th>
               
            </tr>

            <%
                boolean hasRecords = false;

                while (rs.next()) {
                    hasRecords = true;
                    String dbName = rs.getString(1);
                    String dbEmail = rs.getString("email");
                    String dbEducation = rs.getString(3);
                    String dbStream = rs.getString(4);
                    String dbGender = rs.getString(5);
                   
                    //                session.setAttribute("document", document);

            %>
            <tr>
                <td width="120"><%=dbName%></td>
                <td width="200"><%=dbEmail%></td>
                <td width="80"><%=dbEducation%></td>
                <td width="160"><%=dbStream%></td>
                <td width="80"><%=dbGender%></td>
               
            </tr>
            <%
                }
                if (!hasRecords) {
            %>
        </table>
        <p>No records found.</p>
        <%
            }
        %>
              
                  
                  
                  
              
              </div>
              
            </div>
        </section>

      </div>
    </body>
</html>
</span>
