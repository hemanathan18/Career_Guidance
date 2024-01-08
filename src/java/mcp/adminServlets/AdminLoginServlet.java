package mcp.adminServlets;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import mcp.databaseConnection.DBConnection;
import mcp.password.PasswordHasher;

public class AdminLoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String adminEmail = request.getParameter("adminemail");
            String adminPassword = request.getParameter("adminpassword");
            
            String adminToken = UUID.randomUUID().toString();
            HttpSession s = request.getSession();
            s.setAttribute("adminEmail", adminEmail);
            s.setAttribute("adminToken", adminToken);
            
            String hashedPassword = PasswordHasher.doHash(adminPassword);
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DBConnection.getConnection();
            
            String query = "select * from admin where email=? and password=?";
            
            PreparedStatement pstmnt = con.prepareStatement(query);
            pstmnt.setString(1, adminEmail);
            pstmnt.setString(2, hashedPassword);
            
            ResultSet rs = pstmnt.executeQuery();
            
            if (rs.next()) {
                  response.sendRedirect("Admin/index.jsp");
                
            } else {

                request.setAttribute("errorMessage", "Invalid Email or Password. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("Admin/adminlogin.jsp");
                rd.forward(request, response);

            }
          
          
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminLoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminLoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(AdminLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AdminLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
