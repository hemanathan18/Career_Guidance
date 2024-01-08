<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Admin Login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Admin/adminloginstyle.css" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

    </head>

    <body>
        <div class="container">
            <div class="image-container">
                <img src="${pageContext.request.contextPath}/Admin/img/adminloginbac.jpg" alt="login page image">
                <img id="logo" src="${pageContext.request.contextPath}/Admin/img/logo.png" alt="logo">
            </div>
            <div class="logincontainer">
                <h3>Admin Login</h3>
                <form  action="${pageContext.request.contextPath}/AdminLoginServleturl" method="post">
                    <label for="adminemail"><b>Email</b></label>
                    <input type="text" name="adminemail" id="adminemail" placeholder="Enter Email ID"  required /><br>
                    <label for="adminpassword"><b>Password</b></label>
                    <input type="password" name="adminpassword" id="adminpassword" placeholder="Enter Password" required /><br>
                    <div class="button-container">
                        <input type="submit" value="Login" id="mlogin" />
                       
                    </div>                
                </form>
            </div>
            <div class="error">
                    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                    <% if (errorMessage != null) {%>
                    <p style="color: red;"><%= errorMessage%></p>
                    <% }%>
                </div>
                               
        </div>
    </body>
    <script>
        function mentorSignupredirect() {
            window.location.href = '${pageContext.request.contextPath}/Mentor/mentorsignup.jsp';
        }
        
        function studentRedirect(){
            window.location.href = '${pageContext.request.contextPath}/Student/stu_login.jsp';
        }
       
    </script>
</html>