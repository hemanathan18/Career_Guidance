package mcp.studentServlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.NoSuchAlgorithmException;
import mcp.databaseConnection.DBConnection;
import mcp.password.PasswordHasher;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginServlet2 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String studentEmail = request.getParameter("email");
            String password = request.getParameter("password");

//            String token = UUID.randomUUID().toString();
//            HttpSession s = request.getSession();
//            s.setAttribute("studentEmail", studentEmail);
//            s.setAttribute("studentToken", token);

            //hashing the entered password during login process
            String hashedPassword = PasswordHasher.doHash(password);

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DBConnection.getConnection();

            String query = "select * from student where email=? and password=?";

            PreparedStatement pstmnt = con.prepareStatement(query);
            pstmnt.setString(1, studentEmail);
            pstmnt.setString(2, hashedPassword);

            ResultSet rs = pstmnt.executeQuery();

            if (rs.next()) {
                String token = UUID.randomUUID().toString();
                HttpSession s = request.getSession();
                s.setAttribute("studentEmail", studentEmail);
                s.setAttribute("studentToken", token);

                response.sendRedirect("Student/index.jsp");

            } else {

                request.setAttribute("errorMessage", "Invalid Email or Password. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("Student/stu_login.jsp");
                rd.forward(request, response);

            }

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet2</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet2 at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (NoSuchAlgorithmException | ClassNotFoundException | SQLException ex) {
            Logger.getLogger(LoginServlet2.class.getName()).log(Level.SEVERE, null, ex);
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
