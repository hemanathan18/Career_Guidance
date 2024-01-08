<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Student Login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Student/stu_login_styles.css" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

    </head>

    <body>
        <div class="container">
            <div class="image-container">
                <img src="${pageContext.request.contextPath}/Student/img/loginbac.jpg" alt="login page image">
                <img id="logo" src="${pageContext.request.contextPath}/Student/img/logo.png" alt="logo">
            </div>
            <div class="logincontainer">
                <div class="button-single">
                 <input type="button" value="Mentor" id="mentor" onclick="mentorRedirect()" />
                </div>
                <h3>Student Login</h3>
                <form  action="${pageContext.request.contextPath}/LoginServleturl2" method="post">
                    <label for="email"><b>Email</b></label>
                    <input type="text" name="email" id="email" placeholder="Enter Email ID"  required /><br>
                    <label for="password"><b>Password</b></label>
                    <input type="password" name="password" id="password" placeholder="Enter Password" required /><br>
                    <div class="button-container">
                        <input type="submit" value="Login" id="login" />
                        <input type="button" value="Signup" id="signup" onclick="signupredirect()" />
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
        function signupredirect() {
            window.location.href = '${pageContext.request.contextPath}/Student/stu_signup.jsp';

        }
        
        function mentorRedirect()
        {
            window.location.href = '${pageContext.request.contextPath}/Mentor/mentorlogin.jsp';
        }
       
    </script>
</html>
