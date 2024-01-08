/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package mcp.mentorServlets;

import jakarta.servlet.RequestDispatcher;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mcp.databaseConnection.DBConnection;

public class MentorVerification extends HttpServlet {

    Connection con;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            Class.forName("com.mysql.jdbc.Driver");
            con = DBConnection.getConnection();

            String selectQuery = "SELECT fullname,email,industry,experience,documentpath,gender,status FROM mentorverification WHERE status='pending'";
            PreparedStatement selectStatement = con.prepareStatement(selectQuery);
            ResultSet resultSet = selectStatement.executeQuery();

            if (resultSet.next()) {
                
                
                String dbName = resultSet.getString(1);
                String dbEmail = resultSet.getString(2);
                String dbIndustry = resultSet.getString(3);
                String dbExperience = resultSet.getString(4);
                String document = resultSet.getString(5);
                String dbGender = resultSet.getString(6);
                String dbStatus = resultSet.getString(7);

                out.println(dbName);
                out.println(dbEmail);
                out.println(dbIndustry);
                out.println(dbExperience);
                out.println(document);
                out.println(dbGender);
                out.println(dbStatus);

                HttpSession s = request.getSession();

                s.setAttribute("dbName", dbName);
                s.setAttribute("dbEmail", dbEmail);
                s.setAttribute("dbIndustry", dbIndustry);
                s.setAttribute("dbExperience", dbExperience);
                s.setAttribute("document", document);
                s.setAttribute("dbGender", dbGender);
                s.setAttribute("dbStatus", dbStatus);

                RequestDispatcher rd2 = request.getRequestDispatcher("dummy.jsp");
                rd2.forward(request, response);
                

            }

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MentorVerification</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>values</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MentorVerification.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MentorVerification.class.getName()).log(Level.SEVERE, null, ex);
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
