<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Student/stu_signup_styles.css" />
        <title>Student Signup</title>
    </head>

    <body>
        <div class="container">
            <div class="title">
                <input type="button" name="back" id="back" value="Back" onclick="back()"/>
                <h3>Signup</h3>
            </div>
            <div class="signup-container">
                <form action="${pageContext.request.contextPath}/SignupServleturl" method="post" onsubmit="return validateForm()">
                    <label for="name"><b>Full Name</b></label><br>
                    <input type="text" name="name" id="fullname" placeholder="Enter your Fullname" required /><br>
                    <!--                    <label for="username"><b>User ID</b></label><br>
                                        <input type="text" name="userid" id="userid" placeholder="Enter your Userid" required /><br>-->
                    <label for="email"><b>Email</b></label><br>
                    <input type="text" name="email" id="email" placeholder="Enter your Email" required /><br>
                    <label for="education"><b>Education</b></label><br>
                    <select name="education" id="education">
                        <option value="NULL">Select an option</option>
                        <option value="Postgraduate">Post Graduate</option>
                        <option value="UnderGraduate">Under Graduate</option>
                        <option value="HSC">HSC</option>
                        <option value="SSLC">SSLC</option>     
                    </select><br>
                    <label for="interest"><b>Area of Interest</b></label><br>
                    <select name="interest" id="interest">
                        <option value="NULL">Select an option</option>
                        <option value="Animation & Graphics">Animation & Graphics</option>
                        <option value="Arts & Economics">Arts & Economics</option>
                        <option value="Architecture & Civil">Architecture & Civil</option>
                        <option value="Commerce & Accounts">Commerce & Accounts</option>
                        <option value="Computer Application & IT">Computer Application & IT</option>
                        <option value="Defense">Defense</option>
                        <option value="Distribution & Logistics">Distribution & Logistics</option>
                        <option value="Education and Training">Education and Training</option>
                        <option value="Engineering">Engineering</option>
                        <option value="Entrepreneurship">Entrepreneurship</option>
                        <option value="Finance & Banking">Finance & Banking</option>
                        <option value="Food and Agriculture">Food and Agriculture</option>
                        <option value="Hotel Management">Hotel Management</option>
                        <option value="Law & Legal studies">Law & Legal studies</option>
                        <option value="Life science">Life science</option>
                        <option value="Management & Administration">Management & Administration</option>
                        <option value="Marketing & Sales">Marketing & Sales</option>
                        <option value="Maths & Statistics">Maths & Statistics</option>
                        <option value="Media & Communication">Media & Communication</option>
                        <option value="Medicine">Medicine</option>



                        <!--                        <option value="NULL">Select an option</option>
                                                <option value="Information Technology">Information Technology</option>
                                                <option value="Mechanical">Mechanical</option>
                                                <option value="Civil">Civil</option>
                                                <option value="Automobile">Automobile</option>-->
                    </select><br>
                    <label for="password"><b>Password</b></label><br>
                    <input type="password" name="password" id="pass" placeholder="Enter your Password" required /><br>
                    <label for="confirmpass"><b>Confirm Password</b></label><br>
                    <input type="password" id="confirmpass" placeholder="Confirm your Password" required /><br>
                    <label for="gender"><b>Gender</b></label>
                    <div id="gender-container" class="gender-list">
                        <select name="gender" id="gender">
                            <option value="NULL">Select an option</option>
                            <option value="Female">Female</option>
                            <option value="Male">Male</option>
                            <option value="Others">Other</option>  
                        </select>    
                    </div>
                    <div class="button-container">
                        <input type="submit" value="Signup" id="signup" />
                    </div>
                    <% if (request.getAttribute("signupError") != null) { %>
                    <p style="color: red;">Email already exists!</p>
                    <%}%>

                    <p id="passError" class="error-message"></p>
                    <% if (request.getAttribute("signupSuccess") != null) { %>
                    <p style="color: green;">Signup successful!</p>
                    <%}%>


                </form>
            </div>
        </div>
        <img id="logo" src="${pageContext.request.contextPath}/Student/img/logo.png" alt="logo">

    </body>
    <script>
        function validateForm() {
            var password = document.getElementById("pass").value;
            var confirmPassword = document.getElementById("confirmpass").value;
            var errorMessage = document.getElementById("passError");

            if (password !== confirmPassword) {
                errorMessage.innerHTML = "Passwords are not matching";
                return false;
            } else
            {
                errorMessage.innerHTML = "";
                return true;
            }
        }

        function back() {
            window.location.href = '${pageContext.request.contextPath}/Student/stu_login.jsp';
        }
    </script>
</html>
