/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author wpawgasa
 */
public class CalculateThrust extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        //out = response.getWriter();
        ServerMessage msg = new ServerMessage();
        ObjectMapper mapper = new ObjectMapper();
        try {
            
            RocketMotor motor = mapper.readValue(request.getParameter("motor"), RocketMotor.class);
            double Dt = Double.parseDouble(throatDia.getText())/1000;   //Throat diameter (m)
            double At = (Math.PI)*Math.pow(Dt,2)/4;                     //Throat cross section area (m^2)
            double Lt = Double.parseDouble(throatLen.getText());        //Rocket Length (m)
            double Dp = Double.parseDouble(portDia.getText())/1000;     //Port Diameter (m)
            double D1A = Double.parseDouble(propGeoWin.innerGrainA.getText())/1000; //Inner grain of section A where 2nd propellant start to burnt
            double D1B = Double.parseDouble(propGeoWin.innerGrainB.getText())/1000; //Inner grain of section A where 2nd propellant start to burnt
            
            int N = Integer.parseInt(request.getParameter("numSegments"));
            double Pg = Double.parseDouble(request.getParameter("Pg"));
            double ISP = Double.parseDouble(request.getParameter("Isp"));
            List<SectionInfo> sections = motor.getMotorSections();
            
            msg.setMsg_name("Simulation Result");
            msg.setMsg_status(true);
            msg.setMsg_content("Sim Motor: "+mapper.writeValueAsString(motor));
            out.println(mapper.writeValueAsString(msg));
            out.close();
        } catch(Exception e) {
            msg.setMsg_name("Simulation Error");
            msg.setMsg_status(false);
            msg.setMsg_content("Error: "+e.getMessage());
            out.println(mapper.writeValueAsString(msg));
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
