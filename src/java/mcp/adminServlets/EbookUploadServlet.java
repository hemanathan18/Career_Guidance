package mcp.adminServlets;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import mcp.databaseConnection.DBConnection;
import mcp.fileHandling.FileUploadHelper;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig 
public class EbookUploadServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String fileName = request.getParameter("filename");
            String stream = request.getParameter("stream");
            Part ebook = request.getPart("ebook");
            
            String filePath = FileUploadHelper.saveUploadedFile(ebook, request);

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DBConnection.getConnection();
            String query = "insert into ebooks (filename, stream, filepath) values (?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, fileName);
            ps.setString(2, stream);
            ps.setString(3, filePath);
            ps.executeUpdate();

            request.setAttribute("success", "Upload Sucess! ");
            RequestDispatcher rd = request.getRequestDispatcher("Admin/aosadd.jsp");
            rd.forward(request, response);

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EbookUploadServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EbookUploadServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(EbookUploadServlet.class.getName()).log(Level.SEVERE, null, ex);
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
