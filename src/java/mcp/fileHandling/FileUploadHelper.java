package mcp.fileHandling;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

public class FileUploadHelper {

    // Specify the directory where you want to save uploaded files
    private static final String UPLOAD_DIRECTORY = "c://1Vicky/Netbeans/CDProject/Uploads/";

    public static String saveUploadedFile(Part part, HttpServletRequest request) throws IOException, ServletException {
        String fileName = extractFileName(part);

        // Create the upload directory if it doesn't exist
        File uploadDir = new File(UPLOAD_DIRECTORY);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Generate a unique file name to avoid overwriting existing files
        String uniqueFileName = getUniqueFileName(fileName);

        // Construct the full file path
        String filePath = UPLOAD_DIRECTORY + File.separator + uniqueFileName;
        filePath = filePath.replace("\\", "/");


        // Save the file to the server
        Files.copy(part.getInputStream(), new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);

         return filePath;

    }

    private static String extractFileName(Part part) {
        // Extracts file name from HTTP header content-disposition
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");

        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }

    private static String getUniqueFileName(String fileName) {
        // You can implement a more sophisticated file naming strategy if needed
        return System.currentTimeMillis() + "_" + fileName;
    }
}
