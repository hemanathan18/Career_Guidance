package mcp.mentorServlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.Part;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import mcp.databaseConnection.DBConnection;
import mcp.fileHandling.FileUpload;
import mcp.fileHandling.FileUploadHelper;

import mcp.password.PasswordHasher;
import mcp.studentServlets.LoginServlet;

@MultipartConfig
public class MSignupServlet extends HttpServlet {

    Connection con;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String fullName = request.getParameter("mname");
            String email = request.getParameter("mEmail");
            String industry = request.getParameter("industry");
            String experience = request.getParameter("experience");
            Part eDocument = request.getPart("edocument");
            String password = request.getParameter("mpassword");
            String gender = request.getParameter("mgender");
            String initialStatus = "Pending";

            String hashedPassword = PasswordHasher.doHash(password);

            Class.forName("com.mysql.jdbc.Driver");
            con = DBConnection.getConnection();

            if (isEmailAlreadyExists(email)) {
                request.setAttribute("signupError", true);
                RequestDispatcher rd = request.getRequestDispatcher("Mentor/mentorsignup.jsp");
                rd.forward(request, response);
                return;
            }
            
//            Blob document= partToBlob(eDocument);

            //external class for file upload
            String filePath = FileUploadHelper.saveUploadedFile(eDocument, request);

            String query = "insert into mentorverification values(?,?,?,?,?,?,?,?);";
            PreparedStatement pStmnt = con.prepareStatement(query);

            pStmnt.setString(1, fullName);
            pStmnt.setString(2, email);
            pStmnt.setString(3, industry);
            pStmnt.setString(4, experience);
            pStmnt.setString(5, filePath);
            pStmnt.setString(6, gender);
            pStmnt.setString(7, hashedPassword);
            pStmnt.setString(8, initialStatus);
            pStmnt.executeUpdate();

            request.setAttribute("signupSuccess", true);
            RequestDispatcher rd = request.getRequestDispatcher("Mentor/mentorsignup.jsp");
            rd.forward(request, response);

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MSignupServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>records redirected</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (NoSuchAlgorithmException | ClassNotFoundException | SQLException ex) {
            Logger.getLogger(MSignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {

            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private boolean isEmailAlreadyExists(String email) throws SQLException {
        String query = "select count(*) from mentorverification where email=?";
        PreparedStatement pStmnt = con.prepareStatement(query);
        pStmnt.setString(1, email);
        ResultSet rs = pStmnt.executeQuery();
        if (rs.next()) {
            int count = rs.getInt(1);
            return count > 0;
        }

        return false;
    }

    private Blob partToBlob(Part part) throws IOException, SQLException {
          InputStream inputStream = part.getInputStream();
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            byte[] data = new byte[4096];
            int bytesRead;

            while ((bytesRead = inputStream.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, bytesRead);
            }

            // Assuming you have a Connection named "yourDatabaseConnection"
            Blob blob = con.createBlob();
            blob.setBytes(1, buffer.toByteArray());

            return blob;
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
