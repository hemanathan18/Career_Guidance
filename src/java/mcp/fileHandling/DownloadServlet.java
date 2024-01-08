package mcp.fileHandling;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.OutputStream;

public class DownloadServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

//            HttpSession session = request.getSession();
//            String document = (String) session.getAttribute("document");
        String filename = request.getParameter("filename");
//            String filepath = "C:\\1Vicky\\Netbeans\\CDProject\\Uploads\\";

        if (filename.endsWith(".doc")) {
            response.setContentType("application/msword");
        } else if (filename.endsWith(".docx")) {
            response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        } else if (filename.endsWith(".pdf")) {
            response.setContentType("application/pdf");
        } else {
            // Set a generic binary content type if the file type is unknown
            response.setContentType("application/octet-stream");
        }
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

        try (OutputStream out2 = response.getOutputStream(); FileInputStream fileInputStream = new FileInputStream(filename)) {

            int bytesRead;
            byte[] buffer = new byte[4096];
            while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                out2.write(buffer, 0, bytesRead);
            }

            out2.flush();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
