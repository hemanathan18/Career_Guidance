<%@page contentType="text/html" import="java.sql.*"pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .accept {
                display: inline-block;
                /*margin-left: 53px;*/
                margin-right: 10px;
                font-size: 20px;
                color: #4CAF50;
            }

            .reject {
                display: inline-block;
                margin-right: 10px;
                font-size: 20px;
                color: red;
            }
            table{
                margin: auto;
            }
            td,p{
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1></h1>
        <jsp:useBean id="db" class="mcp.databaseConnection.DBConnection"/>

        <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = db.getConnection();
            String selectQuery = "SELECT fullname,email,industry,experience,documentpath,gender,status FROM mentorverification WHERE status='pending'";
            PreparedStatement selectStatement = con.prepareStatement(selectQuery);
            ResultSet rs = selectStatement.executeQuery();
        %>

        <table border="1" >
            <tr>
                <th width="120">Name</th>
                <th width="200">Email</th>
                <th width="160">Industry</th>
                <th width="80">Experience</th>
                <th width="100">Document</th>
                <th width="80">Gender</th>
                <th width="80">Status</th>
                <th width="150">Actions</th>
            </tr>

            <%
                boolean hasRecords = false;

                while (rs.next()) {
                    hasRecords = true;
                    String dbName = rs.getString(1);
                    String dbEmail = rs.getString("email");
                    String dbIndustry = rs.getString(3);
                    String dbExperience = rs.getString(4);
                    String document = rs.getString("documentpath");
                    String dbGender = rs.getString(6);
                    String dbStatus = rs.getString(7);
                    //                session.setAttribute("document", document);

            %>
            <tr>
                <td width="120"><%=dbName%></td>
                <td width="200"><%=dbEmail%></td>
                <td width="160"><%=dbIndustry%></td>
                <td width="80"><%=dbExperience%></td>
                <td width="100"><a href="${pageContext.request.contextPath}/DownloadServleturl?filename=<%=document%>"><i class="fas fa-file"></i></a></td>
                <td width="80"><%=dbGender%></td>
                <td width="80"><%=dbStatus%></td>
                <td width="150">
                    <a href="${pageContext.request.contextPath}/AcceptServleturl?email=<%=dbEmail%>" class="accept"><i class="fas fa-check"></i></a>
                    <a href="${pageContext.request.contextPath}/RejectServleturl?email=<%=dbEmail%>" class="reject"><i class="fas fa-times"></i></a>
                </td>
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


    </body>


</html>
