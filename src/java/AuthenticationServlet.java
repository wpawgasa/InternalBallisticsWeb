/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author roongtawan
 */
public class AuthenticationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection connection = null;
        String user = request.getParameter("user");
        String pass = request.getParameter("pwd");
        String error = "";
        JSONResult result = new JSONResult();
        ObjectMapper mapper = new ObjectMapper();
        //JSONSerializer serializer = new JSONSerializer();
        //out.println(user);
        try {
            //out.println("1");
            String host = "jdbc:mysql://localhost:3306/InternalBallistics";
            String dbuser = "root";
            String dbpass = "";
            //String db = "InternalBallistics";
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            connection = DriverManager.getConnection(host, dbuser, dbpass);
            //out.println("Connected database successfully...");
            String sql = "SELECT * FROM Users where user_name = ? AND user_pwd = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user);
            stmt.setString(2,pass);
            //stmt.setInt(3, 1);
            ResultSet rs = stmt.executeQuery();
            if(rs.first()) {
            while(rs.next()){
         
         String username  = rs.getString("username");
       
         //Display values
         //out.println("ID: " + username);
        
      }
            } else {
                
            }
      rs.close();
            result.setResult(null);
            result.setSuccess(true);
            result.setErrMsg("");
            out.println(mapper.writeValueAsString(result));
        } catch (Exception e) {
            //out.println("Cannot connect the database!"+e.getMessage());
            error = e.getMessage();
            result.setResult(null);
            result.setSuccess(false);
            result.setErrMsg(error);
            out.println(mapper.writeValueAsString(result));
            
        } finally {
            System.out.println("Closing the connection.");
    if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            out.close();
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AuthenticationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AuthenticationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
