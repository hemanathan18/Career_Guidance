package mcp.studentServlets;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import mcp.databaseConnection.DBConnection;
import mcp.password.PasswordHasher;

public class SignupServlet extends HttpServlet {

    Connection con;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String fullName = request.getParameter("name");
            String email = request.getParameter("email");
            String education = request.getParameter("education");
            String stream = request.getParameter("interest");
            String password = request.getParameter("password");
            String gender = request.getParameter("gender");

            //hashing the entered password during login process
            String hashedPassword = PasswordHasher.doHash(password);

            Class.forName("com.mysql.jdbc.Driver");
            con = DBConnection.getConnection();

            if (isEmailAlreadyExists(email)) {
                request.setAttribute("signupError", true);
                RequestDispatcher rd = request.getRequestDispatcher("Student/stu_signup.jsp");
                rd.forward(request, response);
                return;
            }

            String query = "insert into student values(?,?,?,?,?,?);";
            PreparedStatement pStmnt = con.prepareStatement(query);

            pStmnt.setString(1, fullName);
            pStmnt.setString(2, email);
            pStmnt.setString(3, education);
            pStmnt.setString(4, stream);
            pStmnt.setString(5, gender);
            pStmnt.setString(6, hashedPassword);
            pStmnt.executeUpdate();

            request.setAttribute("signupSuccess", true);
            RequestDispatcher rd = request.getRequestDispatcher("Student/stu_signup.jsp");
            rd.forward(request, response);

//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet SignupServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Records are inserted</h1>");
//            out.println("</body>");
//            out.println("</html>");
        } catch (ClassNotFoundException | SQLException | NoSuchAlgorithmException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally {
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private boolean isEmailAlreadyExists(String email) throws SQLException {
        String query = "select count(*) from student where email=?";
        PreparedStatement pStmnt = con.prepareStatement(query);
        pStmnt.setString(1, email);
        ResultSet rs = pStmnt.executeQuery();
        if (rs.next()) {
            int count = rs.getInt(1);
            return count > 0;
        }

        return false;
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
