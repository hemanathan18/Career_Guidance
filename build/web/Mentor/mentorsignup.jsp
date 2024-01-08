<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Mentor/mentorsignup_styles.css" />
        <title>Mentor Signup</title>
    </head>

    <body>
        <div class="container">
            <div class="title">
                <input type="button" name="mback" id="mback" value="Back" onclick="back()"/>
                <h3>Signup</h3>
            </div>
            <div class="signup-container">
                <form action="${pageContext.request.contextPath}/MSignupServleturl" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                    <label for="mname"><b>Full Name</b></label><br>
                    <input type="text" name="mname" id="mfullname" placeholder="Enter your Fullname" required /><br>
                    <label for="mEmail"><b>Email</b></label><br>
                    <input type="text" name="mEmail" id="mEmail" placeholder="Enter your Email" required /><br>
                    <label for="industry"><b>Industry</b></label><br>
                    <select name="industry" id="industry">
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
                    <label for="experience"><b>Years of Experience</b></label><br>
                    <input type="text" name="experience" id="exp" pattern="\d+" placeholder="Enter your Experience" required /><br>
                    <label for="edocument"><b>Experience Document</b></label><br>
                    <input type=file name="edocument" id="edoc" accept=".pdf, .doc, .docx" onchange="validateFileSize()" required /><br>
                    <small>*Only PDF, DOC, DOCX. Within 1MB</small><br>
                    <label for="password"><b>Password</b></label><br>
                    <input type="password" name="mpassword" id="mpass" placeholder="Enter your Password" required /><br>
                    <label for="confirmpass"><b>Confirm Password</b></label><br>
                    <input type="password" id="mconfirmpass" placeholder="Confirm your Password" required /><br>
                    <label for="gender"><b>Gender</b></label>
                    <div id="gender-container" class="gender-list">
                        <select name="mgender" id="mgender">
                            <option value="NULL">Select an option</option>
                            <option value="Female">Female</option>
                            <option value="Male">Male</option>
                            <option value="Others">Other</option>  
                        </select>    
                    </div>
                    <div class="button-container">
                        <input type="submit" value="Submit" id="msignup" />
                    </div>
                    <% if (request.getAttribute("signupError") != null) { %>
                    <p style="color: red;">Email already exists!</p>
                    <%}%>

                    <p id="passError" class="error-message"></p>

                    <% if (request.getAttribute("signupSuccess") != null) { %>
                    <pre style="color: #006400;">
Details are submitted. 
Wait for admin verification!
                    </pre>
                    <%}%>


                </form>
            </div>
        </div>
        <img id="logo" src="${pageContext.request.contextPath}/Mentor/img/logo.png" alt="logo">

    </body>
    <script>
        function validateForm() {
            var password = document.getElementById("mpass").value;
            var confirmPassword = document.getElementById("mconfirmpass").value;
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
            window.location.href = '${pageContext.request.contextPath}/Mentor/mentorlogin.jsp';
        }

        function validateFileSize() {
            var input = document.getElementById('edoc');
            var fileSize = input.files[0].size; // Size in bytes
            var maxSizeInBytes = 1024 * 1024; // 1 MB
            var allowedFormats = ['.pdf', '.doc', '.docx'];
            var fileName = input.value.toLowerCase();
            var fileExtension = fileName.substring(fileName.lastIndexOf('.'));
            var isValidFormat = allowedFormats.includes(fileExtension);



            if (fileSize > maxSizeInBytes || !isValidFormat) {
                if (fileSize > maxSizeInBytes) {
                    alert('Check the size or format of the file');
                } else if (!isValidFormat) {
                    alert('Invalid file format');
                }
                // Reset the file input if needed
                input.value = '';
            }
        }


    </script>
</html>