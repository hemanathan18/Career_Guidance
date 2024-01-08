
package mcp.mentorServlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import mcp.databaseConnection.DBConnection;
import mcp.password.PasswordHasher;


public class MLoginServlet2 extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           
            String mentorEmail = request.getParameter("mentoremail");
            String password = request.getParameter("mpassword");
                   
            
            String token = UUID.randomUUID().toString();
            HttpSession s = request.getSession();
            s.setAttribute("email", mentorEmail);
            s.setAttribute("userToken", token);
            
            //hashing the entered password during login process
            String hashedPassword = PasswordHasher.doHash(password);

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DBConnection.getConnection();
            
            String query = "select * from mentor where email=? and password=?";

            PreparedStatement pstmnt = con.prepareStatement(query);
            pstmnt.setString(1, mentorEmail);
            pstmnt.setString(2, hashedPassword);

            ResultSet rs = pstmnt.executeQuery();
            
            if (rs.next()) {
//                response.sendRedirect("stu_dashboard.jsp");
                response.sendRedirect("Mentor/index.jsp");
                
            } else {

                request.setAttribute("errorMessage", "Invalid Email or Password. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("Mentor/mentorlogin.jsp");
                rd.forward(request, response);

            }
                     
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MLoginServlet2</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MLoginServlet2 at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (NoSuchAlgorithmException | ClassNotFoundException | SQLException ex) {
            Logger.getLogger(MLoginServlet2.class.getName()).log(Level.SEVERE, null, ex);
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
