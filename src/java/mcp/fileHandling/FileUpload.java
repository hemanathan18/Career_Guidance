package mcp.fileHandling;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

import java.io.IOException;
import java.io.InputStream;


public class FileUpload {

    // Specify the FTP server details
    private static final String FTP_SERVER = "127.0.0.1";
    private static final int FTP_PORT = 21;
    private static final String FTP_USERNAME = "user1";
    private static final String FTP_PASSWORD = "";
    private static final String FTP_UPLOAD_DIRECTORY = "/1Vicky/HTML/";

    public static String saveUploadedFile(Part part, HttpServletRequest request) throws IOException, ServletException {
        String fileName = extractFileName(part);

        // Connect to the FTP server
        FTPClient ftpClient = new FTPClient();
        ftpClient.connect(FTP_SERVER, FTP_PORT);
        ftpClient.login(FTP_USERNAME, FTP_PASSWORD);
        ftpClient.enterLocalPassiveMode();
        ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

        // Change working directory to the upload directory
        ftpClient.changeWorkingDirectory(FTP_UPLOAD_DIRECTORY);

        // Generate a unique file name to avoid overwriting existing files
        String uniqueFileName = getUniqueFileName(fileName);

        // Upload the file to the FTP server
        try (InputStream inputStream = part.getInputStream()) {
            ftpClient.storeFile(uniqueFileName, inputStream);
        }
        String fullURL = "ftp://" + FTP_USERNAME + "@" + FTP_SERVER + FTP_UPLOAD_DIRECTORY + uniqueFileName;
        return fullURL;

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
