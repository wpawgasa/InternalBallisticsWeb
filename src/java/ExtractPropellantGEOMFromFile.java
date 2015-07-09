/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author wpawgasa
 */
@WebServlet(urlPatterns = {"/ExtractPropellantGEOMFromFile"})
public class ExtractPropellantGEOMFromFile extends HttpServlet {

    //private String filePath = "/Users/wpawgasa/github/InternalBallisticsWeb/upload/";
    private String filePath = "/Users/roongtawan/NetbeansProjects/InternalBallisticsWeb/upload/";
    private File file;
    private PrintWriter out;
    private ServerMessage msg;
    private SectionInfo section;

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
        response.setContentType("text/plain;charset=UTF-8");
        out = response.getWriter();
        msg = new ServerMessage();
        ObjectMapper mapper = new ObjectMapper();
        HttpSession session = request.getSession(false);
        String targetFolder = "Default";
        if (session.getAttribute("user") != null) {
            targetFolder = (String) session.getAttribute("user");
        }
        try {
            File f = new File(filePath + targetFolder + "/" + request.getParameter("fileNames"));
            InputStream fis = null;
            String line;
            int lineCnt = 0;
            fis = new FileInputStream(f);
            BufferedReader br = new BufferedReader(new InputStreamReader(fis, Charset.forName("UTF-8")));
            //PropellantLayer layer1 = new PropellantLayer();
            //PropellantLayer layer2 = new PropellantLayer();
            section = new SectionInfo();
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",", 6);
                if (parts.length == 6) {
                    double x1d_A = Double.parseDouble(parts[0]);
                    double x2d_A = Double.parseDouble(parts[1]);
                    double portArea1_A = Double.parseDouble(parts[2]);
                    double portArea2_A = Double.parseDouble(parts[3]);
                    double periphery1_A = Double.parseDouble(parts[4]);
                    double periphery2_A = Double.parseDouble(parts[5]);

                    PropellantGeom pg1 = new PropellantGeom();
                    pg1.setDistance(x1d_A);
                    pg1.setPort_area(portArea1_A);
                    pg1.setPerimeter(periphery1_A);

                    PropellantGeom pg2 = new PropellantGeom();
                    pg2.setDistance(x2d_A);
                    pg2.setPort_area(portArea2_A);
                    pg2.setPerimeter(periphery2_A);

                    section.getGeom().add(pg1);
                    //layer2.getGeom().add(pg2);

                } else if (parts.length == 3) {
                    double x1d_A = Double.parseDouble(parts[0]);
                    double portArea1_A = Double.parseDouble(parts[1]);
                    double periphery1_A = Double.parseDouble(parts[2]);

                    PropellantGeom pg1 = new PropellantGeom();
                    pg1.setDistance(x1d_A);
                    pg1.setPort_area(portArea1_A);
                    pg1.setPerimeter(periphery1_A);
                    section.getGeom().add(pg1);
                }

                lineCnt++;

            }
            //section.getLayers().add(layer1);
            //section.getLayers().add(layer2);
            if (request.getParameter("computed") == "true") {
                double step = Double.parseDouble(request.getParameter("step"));
                generateBurningDistance(step);
            }

            msg.setMsg_name("File Extraction Result " + lineCnt);
            msg.setMsg_status(true);
            msg.setMsg_content(mapper.writeValueAsString(section));
            out.println(mapper.writeValueAsString(msg));

        } finally {
            out.close();
        }
    }

    private void generateBurningDistance(double step) {
        double cur_distance = 0;
        double cur_portArea = 0;
        double cur_perimeter = 0;
        //int index = 0;
        int end_index = section.getGeom().size()-1;
        double end_distance = section.getGeom().get(end_index).getDistance();
        while (cur_distance <= end_distance) {
            int index;
            PropellantGeom pgH;
            PropellantGeom pgT;
            for (index = 0; index < end_index; index++) {
                pgH = section.getGeom().get(index);
                pgT = section.getGeom().get(index + 1);
                if (cur_distance >= pgH.getDistance() && cur_distance <= pgT.getDistance()) {
                    cur_portArea = pgH.getPort_area()+Math.abs(pgT.getPort_area()-pgH.getPort_area())/(pgT.getDistance()-pgH.getDistance())*(cur_distance-pgH.getDistance());
                    cur_perimeter = pgH.getPerimeter()+Math.abs(pgT.getPerimeter()-pgH.getPerimeter())/(pgT.getDistance()-pgH.getDistance())*(cur_distance-pgH.getDistance());
                    
                    break;
                } 
            }
            if(index==end_index) {
                pgT = section.getGeom().get(index);
                cur_portArea = pgT.getPort_area();
                cur_perimeter = pgT.getPerimeter();
                    
            }
            
            PropellantGeom pg = new PropellantGeom();
            pg.setDistance(cur_distance);
            pg.setPort_area(cur_portArea);
            pg.setPerimeter(cur_perimeter);
            section.getGenGeom().add(pg);
            cur_distance = cur_distance + step;
            
            

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
