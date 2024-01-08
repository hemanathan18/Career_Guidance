<!DOCTYPE html>
<html>

    <head>
        <title>Mentor Login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Mentor/mentorlogin_styles.css" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

    </head>

    <body>
        <div class="container">
            <div class="image-container">
                <img src="${pageContext.request.contextPath}/Mentor/img/mentorloginbac.jpg" alt="login page image">
                <img id="logo" src="${pageContext.request.contextPath}/Mentor/img/logo.png" alt="logo">
            </div>
            <div class="logincontainer">
                <div class="button-single">
                 <input type="button" value="Student" id="student" onclick="studentRedirect()" />
                </div>
                <h3>Mentor Login</h3>
                <form  action="${pageContext.request.contextPath}/MLoginServleturl2" method="post">
                    <label for="mentoremail"><b>Email</b></label>
                    <input type="text" name="mentoremail" id="mentoremail" placeholder="Enter Email ID"  required /><br>
                    <label for="password"><b>Password</b></label>
                    <input type="password" name="mpassword" id="mpassword" placeholder="Enter Password" required /><br>
                    <div class="button-container">
                        <input type="submit" value="Login" id="mlogin" />
                        <input type="button" value="Signup" id="msignup" onclick="mentorSignupredirect()" />
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