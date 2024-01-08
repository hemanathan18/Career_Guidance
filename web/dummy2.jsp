<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                display: flex;
                height: 100vh;
                justify-content: center;
                align-items: center;
                padding: 10px;
                background-repeat: no-repeat;
                background-position:center;
                background-size:cover;
            }
            .uploadForm{
                max-width: 300px;
                width: 50%;
                padding: 30px;
                border-radius: 15px;
                border: 1px solid black;

            }



        </style>
    </head>
    <body>
        <form class="uploadForm" action="${pageContext.request.contextPath}/EbookUploadServleturl" method="post" enctype="multipart/form-data">
            <label for="filename"><b>File Name</b></label><br>
            <input type="text" id="filename" name="filename"/><br>
            <label for="stream"><b>Stream</b></label><br>
            <select name="stream" id="stream">
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

                <!--                <option value="NULL">Select an option</option>
                                <option value="Information Technology">Information Technology</option>
                                <option value="Mechanical">Mechanical</option>
                                <option value="Civil">Civil</option>
                                <option value="Automobile">Automobile</option>-->
            </select><br>
            <label for="ebook"><b>Ebook Filename</b></label><br>
            <input type=file name="ebook" id="ebook" accept=".pdf, .doc, .docx" onchange="validateFileSize()" required /><br>
            <small>*Only PDF, DOC, DOCX. Within 5MB</small><br>
            <input type="submit" value="upload"/>

        </form>
        <% String Message = (String) request.getAttribute("success"); %>
        <% if (Message != null) {%>
        <p style="color: green;"><%= Message%></p>
        <% }%>
    </body>
    <script>
        function validateFileSize() {
            var input = document.getElementById('edoc');
            var fileSize = input.files[0].size; // Size in bytes
            var maxSizeInBytes = 5 * 1024 * 1024; // 5 MB
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
