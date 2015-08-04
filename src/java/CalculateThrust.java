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
import javax.swing.table.DefaultTableModel;

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
        String testStr = "";
        try {

            RocketMotor motor = mapper.readValue(request.getParameter("motor"), RocketMotor.class);
            double Dt = motor.getThroatDiameter() / 1000;   //Throat diameter (m)
            double At = (Math.PI) * Math.pow(Dt, 2) / 4;                     //Throat cross section area (m^2)
            double Lt = motor.getMotorLength() / 1000;        //Rocket Length (m)
            double Dp = motor.getMotorDiameter() / 1000;     //Port Diameter (m)
            double Ls = 0;                                 //Total motor sections length (m) 
            int maxLayers = 1;
            List<SectionInfo> sections = motor.getMotorSections();

            for (int i = 0; i < sections.size(); i++) {
                Ls = Ls + sections.get(i).getSectionLength() / 1000;
                if (sections.get(i).getSectionLayers().size() > maxLayers) {
                    maxLayers = sections.get(i).getSectionLayers().size();
                }
            }

            int N = Integer.parseInt(request.getParameter("numSegments"));
            double Ln = Ls / N;                                           //Segment Length (m)

            double Pg = Double.parseDouble(request.getParameter("Pg")) * 6895; //Guess pressure (N/m^2)
            double ISP = Double.parseDouble(request.getParameter("Isp"));
            double P0 = 1000 * 6895;                                      //Reference pressure (N/m^2)
            double tdelta = 0.01;                                       //time step (s)
            double climit = 0.00001;                                    //convergence limit

            double[][] rb = new double[N + 1][maxLayers];                 //Burning rate array for each segment and layer
            double[][] x = new double[N + 1][maxLayers];                 //Burning distance array for each segment and layer

            double[] Ap = new double[N + 1];                               //Port area  at time t of each segment

            double[][] Peri = new double[N + 1][maxLayers];                //Periphery for each segment and layer

            double[][] rb_m0 = new double[N + 1][maxLayers];               //Burning rate at zero mass flow for each segment and layer

            double[] mdot = new double[N + 1];                             //Mass flow rate at time t at each segment (kg/s)
            double[] mdotA = new double[N + 1];                            //Dummy Mass flow rate at time t at each segment (kg/s)

            double[] mach = new double[N + 1];                             //Mach at time t of each segment 
            double[] machA = new double[N + 1];                            //dummy mach

            double[][] rbA = new double[N + 1][maxLayers];                 //dummy burning rate for each segment and layer

            double[][] a_i = new double[sections.size()][maxLayers];     //pre-exponential factor of each layer

            int precision = 5;
            double ts = 10;              //simulation time limit
            double CF = 0;

            //initialize
            double t = 0;                                               //start time (s)
            double tprint = 0;
            double P = Pg;                                              //Set pressure to guess pressure
            for (int i = 0; i < sections.size(); i++) {
                for (int j = 0; j < sections.get(i).getSectionLayers().size(); j++) {
                    double RB = sections.get(i).getSectionLayers().get(j).getLayerBurningRate();
                    double n = sections.get(i).getSectionLayers().get(j).getLayerPressureExponent();
                    a_i[i][j] = RB / Math.pow(P0, n);
                }
            }
            double Lc = 0;                                              //keep track of length
            for (int i = 0; i <= N; i++) {
                Lc = i * Ln;
                int secIdx = 0;
                double secL = 0;
                for (int k = 0; k < sections.size(); k++) {
                    secL = secL + sections.get(k).getSectionLength();
                    if (secL >= Lc) {
                        secIdx = k;
                    }
                }
                for (int j = 0; j < maxLayers; j++) {
                    x[i][j] = 0;                                              //Set burnt distance to 0
                    if (sections.get(secIdx).getSectionLayers().get(j) != null) {
                        rb[i][j] = a_i[secIdx][j] * Math.pow(Pg, sections.get(secIdx).getSectionLayers().get(j).getLayerPressureExponent());
                    } else {
                        rb[i][j] = 0;
                    }

                }
            }
            boolean isAborted = false;
            while (!isAborted) {
                boolean isConverged = false;
                do {
                    double[] gas = new double[maxLayers];
                    double[] gasfrac = new double[maxLayers];
                    Lc = 0;

                    for (int i = 0; i <= N; i++) {
                        Lc = i * Ln;
                        double secL = 0;
                        for (int k = 0; k < sections.size(); k++) {
                            secL = secL + sections.get(k).getSectionLength();
                            if (secL >= Lc) {
                                Geom(sections.get(k), i, maxLayers, x, Peri, Ap);

                            }
                        }

                    }

                    isConverged = true;
                } while (!isConverged);
                for (int i = 0; i <= N; i++) {
                    for (int j = 0; j < maxLayers; j++) {
                        x[i][j] = x[i][j] + 0.5;

                    }
                
                }
                t = t + tdelta;
                if(t>=ts) {
                    isAborted = true;
                }
            }

            //msg.setMsg_name("Simulation Result");
            //msg.setMsg_status(true);
            //msg.setMsg_content("Test Rb: " + mapper.writeValueAsString(rb));
            //out.println(mapper.writeValueAsString(msg));
            out.println("Rb: " + rb.toString());
            out.println("x: " + x.toString());
            out.println("Peri: " + Peri.toString());
            out.close();
        } catch (Exception e) {
            StackTraceElement[] st = e.getStackTrace();
            String err = "";
            out.println(e.getMessage());
            for (StackTraceElement st1 : st) {
                out.println("Error on line " + st1.getLineNumber() + ": "
                        + st1.getMethodName() + ", " + st1.getClassName() + ", " + st1.getFileName());

            }
            //msg.setMsg_name("Simulation Error");
            //msg.setMsg_status(false);
            //msg.setMsg_content("Error: " + e.getMessage() + "\n" +err );
            //out.println(mapper.writeValueAsString(msg));
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

    private void Geom(SectionInfo section, int segmentIdx, int maxLayers, double[][] x, double[][] Peri, double[] Ap) {

        List<PropellantGeom> geoms = section.getGeneratedGeom();

        for (int i = 0; i < geoms.size() - 1; i++) {
            double ap = 0;
            //double peri = 0;
            for (int j = 0; j < maxLayers; i++) {
                if (x[segmentIdx][j] >= geoms.get(i).getDistance() && x[segmentIdx][j] < geoms.get(i).getDistance()) {
                    ap = ap + geoms.get(i).getPort_area() + (geoms.get(i + 1).getPort_area() - geoms.get(i).getPort_area()) / (geoms.get(i + 1).getDistance() - geoms.get(i).getDistance()) * (x[segmentIdx][j] - geoms.get(i).getDistance());

                    Peri[segmentIdx][j] = geoms.get(i).getPerimeter() + (geoms.get(i + 1).getPerimeter() - geoms.get(i).getPerimeter()) / (geoms.get(i + 1).getDistance() - geoms.get(i).getDistance()) * (x[segmentIdx][j] - geoms.get(i).getDistance());
                }
                if (x[segmentIdx][j] >= section.getSectionLayers().get(j).getLayerMaxBurningDistance()) {
                    ap = (Math.PI) * Math.pow(section.getSectionOuterDiameter(), 2) / 4;
                    Peri[segmentIdx][j] = 0;
                }
            }

            Ap[segmentIdx] = ap;
        }

    }
}
