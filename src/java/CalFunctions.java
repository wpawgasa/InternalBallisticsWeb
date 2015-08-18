
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.AsyncContext;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author wpawgasa
 */
public class CalFunctions implements Runnable {

    public String errStr = "";
    private ObjectMapper mapper = new ObjectMapper();

    private AsyncContext aContext;

    private List<Double> pressure = new ArrayList<Double>();
    private List<Double> thrust = new ArrayList<Double>();
    private List<Double> time = new ArrayList<Double>();
    private RocketMotor motor;
    private String motorStr;
    private int numSegments;
    private double Pg;
    private double ISP;
    private double CF = 0;
    private double At = 0;

    public CalFunctions(AsyncContext aContext) {
        this.aContext = aContext;

    }

    public CalFunctions(String motorStr, int numSegments, double Pg, double ISP) {
        this.motorStr = motorStr;
        this.numSegments = numSegments;
        this.Pg = Pg;
        this.ISP = ISP;
    }

    public void IBCalculation(List<Double> pressure, List<Double> thrust, RocketMotor motor, int numSegments, double Pg, double ISP) {
        try {
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

            int N = numSegments;
            double Ln = Ls / N;                                           //Segment Length (m)

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
                for (int j = 0; j < maxLayers; j++) {
                    if (sections.get(i).getSectionLayers().get(j) != null) {
                        double RB = sections.get(i).getSectionLayers().get(j).getLayerBurningRate() / 1000;
                        double n = sections.get(i).getSectionLayers().get(j).getLayerPressureExponent();
                        a_i[i][j] = RB / Math.pow(P0, n);
                    } else {
                        a_i[i][j] = 0;
                    }
                }
            }
            double Lc = 0;                                              //keep track of length
            for (int i = 0; i <= N; i++) {
                Lc = i * Ln;
                int secIdx = 0;
                double secL = 0;
                for (int k = 0; k < sections.size(); k++) {
                    secL = secL + sections.get(k).getSectionLength() / 1000;
                    if (secL >= Lc) {
                        secIdx = k;
                        break;
                    }
                }
                for (int j = 0; j < maxLayers; j++) {
                    x[i][j] = 0;
                    rbA[i][j] = 0;
                    //Set burnt distance to 0
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
                int iterCnt = 0;
                do {
                    iterCnt++;
                    double[][] gas = new double[sections.size()][maxLayers];
                    double[][] gasfrac = new double[sections.size()][maxLayers];

                    Lc = 0;

                    for (int i = 0; i <= N; i++) {
                        Lc = i * Ln;
                        double secL = 0;
                        for (int k = 0; k < sections.size(); k++) {
                            secL = secL + sections.get(k).getSectionLength() / 1000;
                            if (secL >= Lc) {
                                //System.out.println("calculate geom for segment "+i+" in section "+k);
                                Geom(sections.get(k), i, maxLayers, x, Peri, Ap);

                                //System.out.println(errStr);
                                for (int j = 0; j < maxLayers; j++) {

                                    //CALC BASE MASS BURN RATE
                                    rb_m0[i][j] = a_i[k][j] * Math.pow(P, sections.get(k).getSectionLayers().get(j).getLayerPressureExponent());

                                    //FIND MIXTURE RATIO OF COMBUSTION GAS FROM THE PROPELLANTS
                                    gas[k][j] = gas[k][j] + rb[i][j] * Peri[i][j];

                                }
                                break;
                            }
                        }

                    }

                    //FIND MIXTURE RATIO OF COMBUSTION GAS FROM THE TWO PROPELLANTS
                    double sumGas = 0;
                    for (double[] g : gas) {
                        for (double gg : g) {
                            sumGas = sumGas + gg;
                        }

                    }
                    if (sumGas == 0) {
                        gasfrac[0][0] = 1;

                    } else {
                        for (int i = 0; i < sections.size(); i++) {
                            for (int j = 0; j < maxLayers; j++) {
                                gasfrac[i][j] = gas[i][j] / sumGas;
                            }
                        }

                    }
                    //System.out.println("Gas: at " + t + " s : " + Arrays.deepToString(gas));
                    //System.out.println("Gas Frac: at " + t + " s : " + Arrays.deepToString(gasfrac));
                    double Rmix = 0;
                    double Tmix = 0;
                    double Gammix = 0;
                    for (int i = 0; i < sections.size(); i++) {
                        for (int j = 0; j < maxLayers; j++) {
                            Rmix = Rmix + sections.get(i).getSectionLayers().get(j).getLayerGasConst() * gasfrac[i][j];
                            Tmix = Tmix + sections.get(i).getSectionLayers().get(j).getLayerGasTemp() * gasfrac[i][j];
                            Gammix = Gammix + sections.get(i).getSectionLayers().get(j).getLayerHeatCapacity() * gasfrac[i][j];
                        }
                    }
//                    System.out.println("Rmix: " + Rmix);
//                    System.out.println("Tmix: " + Tmix);
//                    System.out.println("Gammix: " + Gammix);
                    //calculate m0
                    mdot[0] = IgnitionMassFlow(t);
                    mach[0] = mdot[0] / P / Ap[0] * Math.sqrt(Rmix * Tmix / Gammix);
                    double G0 = 0.0;
                    double D0 = 0.0;
                    double B0 = 0.0;
                    if (mdot[0] == 0) {
                        for (int j = 0; j < maxLayers; j++) {
                            rb[0][j] = rb_m0[0][j];

                        }
                    } else {
                        double sumPeri = 0;
                        for (int j = 0; j < maxLayers; j++) {
                            sumPeri = sumPeri + Peri[0][j];

                        }
                        G0 = mdot[0] / Ap[0];
                        D0 = 4 * Ap[0] / sumPeri;
                        B0 = 53 * rb[0][0] * sections.get(0).getSectionLayers().get(0).getLayerDensity() * 1000 / G0;
                        for (int j = 0; j < maxLayers; j++) {
                            if (sections.get(0).getSectionLayers().get(j) != null) {
                                //double alpha = sections.get(0).getSectionLayers().get(j).getLayerAlpErosive();
                                //alpha = alpha*(Math.pow(10,-7));
                                double alpha0 = 0.000006;
                                rb[0][j] = rb_m0[0][j] + alpha0 * (Math.pow(G0, 0.8)) * (Math.pow(D0, -0.2)) * Math.exp(-1 * B0);
                            } else {
                                rb[0][j] = 0;
                            }

                        }
                    }
                    double GA = 0.0;
                    double DA = 0.0;
                    double[][] BA = new double[sections.size()][maxLayers];
                    double[][] B = new double[sections.size()][maxLayers];
                    double G = 0.0;
                    double D = 0.0;
                    Lc = 0;
                    for (int i = 1; i <= N; i++) {
                        double sumPeri = 0;
                        Lc = i * Ln;
                        for (int j = 0; j < maxLayers; j++) {
                            sumPeri = sumPeri + Peri[i][j];

                        }
                        double secL = 0;
                        int secIdx = 0;
                        //find current section
                        for (int k = 0; k < sections.size(); k++) {
                            secL = secL + sections.get(k).getSectionLength() / 1000;
                            if (secL >= Lc) {
                                secIdx = k;
                                break;
                            }
                        }
                        if (sumPeri > 0) {

                            // Calculate dummy mass flow rate
                            double gengas_term = 0;
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                //System.out.println("Distance: "+x[i][j]+", Area: "+Ap[i]);
                                //System.out.println("Rb i-1: "+rb[i - 1][j]);
                                //System.out.println("Peri i-1: "+Peri[i - 1][j]);
                                //System.out.println("Peri i: "+Peri[i][j]);
                                //System.out.println("Density: "+sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000);
                                //System.out.println("Ln: "+Ln);
                                gengas_term = gengas_term + rb[i - 1][j] * ((Peri[i - 1][j] + Peri[i][j]) / 2) * Ln * (sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000);
                            }
                            //System.out.println("Dummy Gen gas "+gengas_term);
                            mdotA[i] = mdot[i - 1] + gengas_term;
                            machA[i] = (mdotA[i] / P / Ap[0]) * Math.sqrt(Rmix * Tmix / Gammix);
                            GA = mdotA[i] / Ap[i];
                            DA = 4 * Ap[i] / (sumPeri);
                            if (GA == 0) {
                                for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                    BA[secIdx][j] = Math.pow(10, 11);
                                }

                            } else {
                                for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                    BA[secIdx][j] = 53 * rb[i][j] * sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000 / GA;
                                }

                            }
                            // BURNING RATE USING MASS FLOW RATE FROM LAST SEGMENT
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                double alphaA = sections.get(secIdx).getSectionLayers().get(j).getLayerAlpErosive() * (Math.pow(10, -7));

                                //alpha = alpha/(Math.pow(10,7));
                                //System.out.println("GA: "+GA);
                                //System.out.println("DA: "+DA);
                                //System.out.println("BA: "+BA[secIdx][j]);
                                //System.out.println("Rb_M0: "+(rb_m0[i][j]+2.2));
                                //System.out.println("Alpha: "+alphaA);
                                //alphaA*(Math.pow(10,-7)) * (Math.pow(GA, 0.8)) * (Math.pow(DA, -0.2)) * Math.exp(-1 * BA[secIdx][j])
                                //rbA[i][j] = 0;
                                rbA[i][j] = rb_m0[i][j] + alphaA * (Math.pow(10, -7)) * (Math.pow(GA, 0.8)) * (Math.pow(DA, -0.2)) * Math.exp(-1 * BA[secIdx][j]);
                            }
                            gengas_term = 0;
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                //System.out.println("Rb i-1: "+rb[i - 1][j]);
                                //System.out.println("RbA i: "+rbA[i][j]);
                                //System.out.println("Peri i-1: "+Peri[i - 1][j]);
                                //System.out.println("Peri i: "+Peri[i][j]);
                                //System.out.println("Density: "+sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000);
                                //System.out.println("Ln: "+Ln);
                                gengas_term = gengas_term + ((rb[i - 1][j] * Peri[i - 1][j] + rbA[i][j] * Peri[i][j]) / 2) * Ln * sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000;
                            }
                            //System.out.println("Gen gas "+gengas_term);
                            mdot[i] = mdot[i - 1] + gengas_term;
                            mach[i] = (mdot[i] / P / Ap[0]) * Math.sqrt(Rmix * Tmix / Gammix);

                            G = mdot[i] / Ap[i];
                            D = 4 * Ap[i] / (sumPeri);
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                B[secIdx][j] = 53 * rb[i][j] * sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000 / G;
                                // correct burning rate
                                //double alpha = sections.get(secIdx).getSectionLayers().get(j).getLayerAlpErosive();
                                double alpha = 0.000006;
                                //alpha = alpha*(Math.pow(10,-7));
                                //System.out.println("G: "+G);
                                //System.out.println("D: "+D);
                                //System.out.println("B: "+B[secIdx][j]);
                                //System.out.println("Rb_M0: "+rb_m0[i][j]);
                                //System.out.println("Alpha: "+alpha);
                                rb[i][j] = rb_m0[i][j] + alpha * (Math.pow(G, 0.8)) * (Math.pow(D, -0.2)) * Math.exp(-1 * B[secIdx][j]);
                            }

                        } else {
                            mdotA[i] = mdot[i - 1];
                            mdot[i] = mdot[i - 1];
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                rbA[i][j] = 0;
                                rb[i][j] = 0;
                            }

                        }
                        //System.out.println("***mdotI: " + mdot[i] + ",mdotA: " + mdotA[i] + ",GA: " + GA + ",DA: " + DA);
                    }
                    double sumPeri = 0;
                    for (int j = 0; j < maxLayers; j++) {
                        sumPeri = sumPeri + Peri[0][j];

                    }
                    if (sumPeri == 0) {
                        for (int j = 0; j < maxLayers; j++) {
                            rb[0][j] = 0;

                        }
                    }

                    if (mdot[N] == 0) {
                        break;
                    }
                    double k = 2 * Math.pow(Gammix, 2) / (Gammix - 1);
                    double k1 = Math.pow(2 / (Gammix + 1), (Gammix + 1) / (Gammix - 1));
                    double k2 = 1 - Math.pow(101356.5 / P, (Gammix - 1) / Gammix);
                    CF = Math.sqrt(k * k1 * k2);
                    //CF = 1.6;
                    double CStar = ISP * 9.80665 / CF;
                    //System.out.println("mdotN: " + mdot[N] + ", CF: " + CF + ", At: " + At);
                    P = mdot[N] * CStar / At;
                    if (Math.abs((Pg - P) / P) < climit) {
                        //System.out.println("Pressure converged to " + P);
                        //Pg = P;
                        isConverged = true;
                    } else {
                        //System.out.println("Pressure " + P + " is not converged to " + Pg);
                        if(iterCnt>100) {
                            P = 1000*6895;
                            iterCnt = 0;
                        }
                        Pg = P;
                    }
                    //isConverged = true;
                } while (!isConverged);
                Lc = 0;
                for (int i = 0; i <= N; i++) {
                    Lc = i * Ln;
                    double secL = 0;
                    for (int k = 0; k < sections.size(); k++) {
                        secL = secL + sections.get(k).getSectionLength();
                        if (secL >= Lc) {
                            for (int j = 0; j < maxLayers; j++) {
                                x[i][j] = x[i][j] + rb[i][j] * tdelta;
                            }

                        }
                    }

                }

                //System.out.println("Rb at " + t + " s : " + Arrays.deepToString(rb));
                //System.out.println("x: at " + t + " s : " + Arrays.deepToString(x));
                //System.out.println("Peri: at " + t + " s : " + Arrays.deepToString(Peri));
                //System.out.println("Port: at " + t + " s : " + Arrays.toString(Ap));
                t = t + tdelta;
                if (t >= ts && P <= 50 * 6895) {
                    isAborted = true;
                }
                pressure.add(P); //(N/m^2)
                double instThrust = (double) Math.round(P * At * CF / 9.8 * 2.204 * Math.pow(10, precision)) / Math.pow(10, precision);
                thrust.add(instThrust);
            }

            //msg.setMsg_name("Simulation Result");
            //msg.setMsg_status(true);
            //msg.setMsg_content("Test Rb: " + mapper.writeValueAsString(rb));
            //System.out.println(mapper.writeValueAsString(msg));
//        System.out.println("Rb: " + Arrays.deepToString(rb));
//        System.out.println("x: " + Arrays.deepToString(x));
//        System.out.println("Peri: " + Arrays.deepToString(Peri));
//        System.out.println("Port: " + Arrays.toString(Ap));
            //out.close();
        } catch (Exception ex) {
            StackTraceElement[] st = ex.getStackTrace();
            //errStr = "";
            errStr = errStr + ex.getMessage();
            for (StackTraceElement st1 : st) {
                errStr = errStr + "Error on line " + st1.getLineNumber() + ": "
                        + st1.getMethodName() + ", " + st1.getClassName() + ", " + st1.getFileName();

            }
        }
    }

    private void Geom(SectionInfo section, int segmentIdx, int maxLayers, double[][] x, double[][] Peri, double[] Ap) {

        try {
            List<PropellantGeom> geoms = section.getGeneratedGeom();

            Ap[segmentIdx] = 0;
            for (int i = 0; i < geoms.size() - 1; i++) {
                double ap = 0;
                //double peri = 0;
                for (int j = 0; j < maxLayers; j++) {
                    //testStr = "x: "+x[segmentIdx][j]+"\n";
                    //testStr = "geom at "+i+": "+geoms.get(i).getDistance()+"\n";
                    if (x[segmentIdx][j] >= geoms.get(i).getDistance() / 1000 && x[segmentIdx][j] < geoms.get(i + 1).getDistance() / 1000) {
                        Ap[segmentIdx] = Ap[segmentIdx] + geoms.get(i).getPort_area() / (1000 * 1000) + (geoms.get(i + 1).getPort_area() / (1000 * 1000) - geoms.get(i).getPort_area() / (1000 * 1000)) / (geoms.get(i + 1).getDistance() / 1000 - geoms.get(i).getDistance() / 1000) * (x[segmentIdx][j] - geoms.get(i).getDistance() / 1000);

                        Peri[segmentIdx][j] = geoms.get(i).getPerimeter() / 1000 + (geoms.get(i + 1).getPerimeter() / 1000 - geoms.get(i).getPerimeter() / 1000) / (geoms.get(i + 1).getDistance() / 1000 - geoms.get(i).getDistance() / 1000) * (x[segmentIdx][j] - geoms.get(i).getDistance() / 1000);
                    }
                    if (x[segmentIdx][j] >= section.getSectionLayers().get(j).getLayerMaxBurningDistance()) {
                        Ap[segmentIdx] = (Math.PI) * Math.pow(section.getSectionOuterDiameter() / 1000, 2) / 4;
                        Peri[segmentIdx][j] = 0;
                    }
                }

                //Ap[segmentIdx] = ap;
            }
        } catch (Exception ex) {
            StackTraceElement[] st = ex.getStackTrace();
            //errStr = "";
            errStr = errStr + ex.getMessage();
            for (StackTraceElement st1 : st) {
                errStr = errStr + "Error on line " + st1.getLineNumber() + ": "
                        + st1.getMethodName() + ", " + st1.getClassName() + ", " + st1.getFileName();

            }
        }

    }

    private double IgnitionMassFlow(double T) {

        //double Tig = 0.03;        //igniter burn time (s)
        //double Mig = 0.01;          //igniter mass (kg)
        double Tig = 0.03;
        double Mig = 0.01;
        if (T <= Tig) {
            return Mig / Tig;
        } else {
            return 0;
        }
    }

    public String test() {
        return "Test function";
    }

    @Override
    public void run() {
        PrintWriter out = null;
        List<IBOutput> output = new ArrayList<IBOutput>();
        try {
            out = aContext.getResponse().getWriter();
            this.motor = mapper.readValue(this.aContext.getRequest().getParameter("motor"), RocketMotor.class);
            //this.motor = mapper.readValue(this.motorStr, RocketMotor.class);
            this.numSegments = Integer.parseInt(this.aContext.getRequest().getParameter("numSegments"));
            this.Pg = Double.parseDouble(this.aContext.getRequest().getParameter("Pg")) * 6895;
            this.ISP = Double.parseDouble(this.aContext.getRequest().getParameter("Isp"));

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

            int N = numSegments;
            double Ln = Ls / N;                                           //Segment Length (m)

            double P0 = 1000 * 6895;                                      //Reference pressure (N/m^2)
            double tdelta = 0.01;                                       //time step (s)
            double climit = 0.00001;                                    //convergence limit

            double[][] rb = new double[N + 1][maxLayers];                 //Burning rate array for each segment and layer
            double[][] x = new double[N + 1][maxLayers];                 //Burning distance array for each segment and layer

            
            double[][] rbA = new double[N + 1][maxLayers];                 //dummy burning rate for each segment and layer

            double[][] a_i = new double[sections.size()][maxLayers];     //pre-exponential factor of each layer

            int precision = 5;
            double ts = 10;              //simulation time limit
            

            //initialize
            double t = 0;                                               //start time (s)
            double tprint = 0;
            double P = Pg;                                              //Set pressure to guess pressure
            for (int i = 0; i < sections.size(); i++) {
                for (int j = 0; j < maxLayers; j++) {
                    if (sections.get(i).getSectionLayers().get(j) != null) {
                        double RB = sections.get(i).getSectionLayers().get(j).getLayerBurningRate() / 1000;
                        double n = sections.get(i).getSectionLayers().get(j).getLayerPressureExponent();
                        a_i[i][j] = RB / Math.pow(P0, n);
                    } else {
                        a_i[i][j] = 0;
                    }
                }
            }
            double Lc = 0;                                              //keep track of length
            for (int i = 0; i <= N; i++) {
                Lc = i * Ln;
                int secIdx = 0;
                double secL = 0;
                for (int k = 0; k < sections.size(); k++) {
                    secL = secL + sections.get(k).getSectionLength() / 1000;
                    if (secL >= Lc) {
                        secIdx = k;
                        break;
                    }
                }
                for (int j = 0; j < maxLayers; j++) {
                    x[i][j] = 0;
                    rbA[i][j] = 0;
                    //Set burnt distance to 0
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
                int iterCnt = 0;
                double Pn_0 = P;
                double Pn_minus1 = P;
                double Pn_plus1 = P;
                do {
                    iterCnt++;
                    
                    double[] Ap = new double[N + 1];                               //Port area  at time t of each segment

            double[][] Peri = new double[N + 1][maxLayers];                //Periphery for each segment and layer

            double[][] rb_m0 = new double[N + 1][maxLayers];               //Burning rate at zero mass flow for each segment and layer

            double[] mdot = new double[N + 1];                             //Mass flow rate at time t at each segment (kg/s)
            double[] mdotA = new double[N + 1];                            //Dummy Mass flow rate at time t at each segment (kg/s)

            double[] mach = new double[N + 1];                             //Mach at time t of each segment 
            double[] machA = new double[N + 1];                            //dummy mach

            //double CF = 0;
            double[][] gas = new double[sections.size()][maxLayers];
                    double[][] gasfrac = new double[sections.size()][maxLayers];

//            double Lc = 0;

                    for (int i = 0; i <= N; i++) {
                        Lc = i * Ln;
                        double secL = 0;
                        for (int k = 0; k < sections.size(); k++) {
                            secL = secL + sections.get(k).getSectionLength() / 1000;
                            if (secL >= Lc) {
                                //System.out.println("calculate geom for segment "+i+" in section "+k);
                                Geom(sections.get(k), i, maxLayers, x, Peri, Ap);

                                //System.out.println(errStr);
                                for (int j = 0; j < maxLayers; j++) {

                                    //CALC BASE MASS BURN RATE
                                    rb_m0[i][j] = a_i[k][j] * Math.pow(P, sections.get(k).getSectionLayers().get(j).getLayerPressureExponent());

                                    //FIND MIXTURE RATIO OF COMBUSTION GAS FROM THE PROPELLANTS
                                    gas[k][j] = gas[k][j] + rb[i][j] * Peri[i][j];

                                }
                                break;
                            }
                        }

                    }

                    //FIND MIXTURE RATIO OF COMBUSTION GAS FROM THE TWO PROPELLANTS
                    double sumGas = 0;
                    for (double[] g : gas) {
                        for (double gg : g) {
                            sumGas = sumGas + gg;
                        }

                    }
                    if (sumGas == 0) {
                        gasfrac[0][0] = 1;

                    } else {
                        for (int i = 0; i < sections.size(); i++) {
                            for (int j = 0; j < maxLayers; j++) {
                                gasfrac[i][j] = gas[i][j] / sumGas;
                            }
                        }

                    }
                    //System.out.println("Gas: at " + t + " s : " + Arrays.deepToString(gas));
                    //System.out.println("Gas Frac: at " + t + " s : " + Arrays.deepToString(gasfrac));
                    double Rmix = 0;
                    double Tmix = 0;
                    double Gammix = 0;
                    for (int i = 0; i < sections.size(); i++) {
                        for (int j = 0; j < maxLayers; j++) {
                            Rmix = Rmix + sections.get(i).getSectionLayers().get(j).getLayerGasConst() * gasfrac[i][j];
                            Tmix = Tmix + sections.get(i).getSectionLayers().get(j).getLayerGasTemp() * gasfrac[i][j];
                            Gammix = Gammix + sections.get(i).getSectionLayers().get(j).getLayerHeatCapacity() * gasfrac[i][j];
                        }
                    }
//                    System.out.println("Rmix: " + Rmix);
//                    System.out.println("Tmix: " + Tmix);
//                    System.out.println("Gammix: " + Gammix);
                    //calculate m0
                    mdot[0] = IgnitionMassFlow(t);
                    mach[0] = mdot[0] / P / Ap[0] * Math.sqrt(Rmix * Tmix / Gammix);
                    double G0 = 0.0;
                    double D0 = 0.0;
                    double B0 = 0.0;
                    if (mdot[0] == 0) {
                        for (int j = 0; j < maxLayers; j++) {
                            rb[0][j] = rb_m0[0][j];

                        }
                    } else {
                        double sumPeri = 0;
                        for (int j = 0; j < maxLayers; j++) {
                            sumPeri = sumPeri + Peri[0][j];

                        }
                        G0 = mdot[0] / Ap[0];
                        D0 = 4 * Ap[0] / sumPeri;
                        B0 = 53 * rb[0][0] * sections.get(0).getSectionLayers().get(0).getLayerDensity() * 1000 / G0;
                        for (int j = 0; j < maxLayers; j++) {
                            if (sections.get(0).getSectionLayers().get(j) != null) {
                                //double alpha = sections.get(0).getSectionLayers().get(j).getLayerAlpErosive();
                                //alpha = alpha*(Math.pow(10,-7));
                                double alpha0 = 0.000006;
                                rb[0][j] = rb_m0[0][j] + alpha0 * (Math.pow(G0, 0.8)) * (Math.pow(D0, -0.2)) * Math.exp(-1 * B0);
                            } else {
                                rb[0][j] = 0;
                            }

                        }
                    }
                    double GA = 0.0;
                    double DA = 0.0;
                    double[][] BA = new double[sections.size()][maxLayers];
                    double[][] B = new double[sections.size()][maxLayers];
                    double G = 0.0;
                    double D = 0.0;
                    Lc = 0;
                    for (int i = 1; i <= N; i++) {
                        double sumPeri = 0;
                        Lc = i * Ln;
                        for (int j = 0; j < maxLayers; j++) {
                            sumPeri = sumPeri + Peri[i][j];

                        }
                        double secL = 0;
                        int secIdx = 0;
                        //find current section
                        for (int k = 0; k < sections.size(); k++) {
                            secL = secL + sections.get(k).getSectionLength() / 1000;
                            if (secL >= Lc) {
                                secIdx = k;
                                break;
                            }
                        }
                        if (sumPeri > 0) {

                            // Calculate dummy mass flow rate
                            double gengas_term = 0;
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                //System.out.println("Distance: "+x[i][j]+", Area: "+Ap[i]);
                                //System.out.println("Rb i-1: "+rb[i - 1][j]);
                                //System.out.println("Peri i-1: "+Peri[i - 1][j]);
                                //System.out.println("Peri i: "+Peri[i][j]);
                                //System.out.println("Density: "+sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000);
                                //System.out.println("Ln: "+Ln);
                                gengas_term = gengas_term + rb[i - 1][j] * ((Peri[i - 1][j] + Peri[i][j]) / 2) * Ln * (sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000);
                            }
                            //System.out.println("Dummy Gen gas "+gengas_term);
                            mdotA[i] = mdot[i - 1] + gengas_term;
                            machA[i] = (mdotA[i] / P / Ap[0]) * Math.sqrt(Rmix * Tmix / Gammix);
                            GA = mdotA[i] / Ap[i];
                            DA = 4 * Ap[i] / (sumPeri);
                            if (GA == 0) {
                                for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                    BA[secIdx][j] = Math.pow(10, 11);
                                }

                            } else {
                                for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                    BA[secIdx][j] = 53 * rb[i][j] * sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000 / GA;
                                }

                            }
                            // BURNING RATE USING MASS FLOW RATE FROM LAST SEGMENT
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                double alphaA = sections.get(secIdx).getSectionLayers().get(j).getLayerAlpErosive() * (Math.pow(10, -7));

                                //alpha = alpha/(Math.pow(10,7));
                                //System.out.println("GA: "+GA);
                                //System.out.println("DA: "+DA);
                                //System.out.println("BA: "+BA[secIdx][j]);
                                //System.out.println("Rb_M0: "+(rb_m0[i][j]+2.2));
                                //System.out.println("Alpha: "+alphaA);
                                //alphaA*(Math.pow(10,-7)) * (Math.pow(GA, 0.8)) * (Math.pow(DA, -0.2)) * Math.exp(-1 * BA[secIdx][j])
                                //rbA[i][j] = 0;
                                rbA[i][j] = rb_m0[i][j] + alphaA * (Math.pow(10, -7)) * (Math.pow(GA, 0.8)) * (Math.pow(DA, -0.2)) * Math.exp(-1 * BA[secIdx][j]);
                            }
                            gengas_term = 0;
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                //System.out.println("Rb i-1: "+rb[i - 1][j]);
                                //System.out.println("RbA i: "+rbA[i][j]);
                                //System.out.println("Peri i-1: "+Peri[i - 1][j]);
                                //System.out.println("Peri i: "+Peri[i][j]);
                                //System.out.println("Density: "+sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000);
                                //System.out.println("Ln: "+Ln);
                                gengas_term = gengas_term + ((rb[i - 1][j] * Peri[i - 1][j] + rbA[i][j] * Peri[i][j]) / 2) * Ln * sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000;
                            }
                            //System.out.println("Gen gas "+gengas_term);
                            mdot[i] = mdot[i - 1] + gengas_term;
                            mach[i] = (mdot[i] / P / Ap[0]) * Math.sqrt(Rmix * Tmix / Gammix);

                            G = mdot[i] / Ap[i];
                            D = 4 * Ap[i] / (sumPeri);
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                B[secIdx][j] = 53 * rb[i][j] * sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000 / G;
                                // correct burning rate
                                //double alpha = sections.get(secIdx).getSectionLayers().get(j).getLayerAlpErosive();
                                double alpha = 0.000006;
                                //alpha = alpha*(Math.pow(10,-7));
                                //System.out.println("G: "+G);
                                //System.out.println("D: "+D);
                                //System.out.println("B: "+B[secIdx][j]);
                                //System.out.println("Rb_M0: "+rb_m0[i][j]);
                                //System.out.println("Alpha: "+alpha);
                                rb[i][j] = rb_m0[i][j] + alpha * (Math.pow(G, 0.8)) * (Math.pow(D, -0.2)) * Math.exp(-1 * B[secIdx][j]);
                            }

                        } else {
                            mdotA[i] = mdot[i - 1];
                            mdot[i] = mdot[i - 1];
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                rbA[i][j] = 0;
                                rb[i][j] = 0;
                            }

                        }
                        //System.out.println("***mdotI: " + mdot[i] + ",mdotA: " + mdotA[i] + ",GA: " + GA + ",DA: " + DA);
                    }
                    double sumPeri = 0;
                    for (int j = 0; j < maxLayers; j++) {
                        sumPeri = sumPeri + Peri[0][j];

                    }
                    if (sumPeri == 0) {
                        for (int j = 0; j < maxLayers; j++) {
                            rb[0][j] = 0;

                        }
                    }

                    if (mdot[N] == 0) {
                        //P = 50*6895;
                        //return P;
                        break;
                    }
                    double k = 2 * Math.pow(Gammix, 2) / (Gammix - 1);
                    double k1 = Math.pow(2 / (Gammix + 1), (Gammix + 1) / (Gammix - 1));
                    double k2 = 1 - Math.pow(101356.5 / P, (Gammix - 1) / Gammix);
                    CF = Math.sqrt(k * k1 * k2);
                    //CF = 1.6;
                    double CStar = ISP * 9.80665 / CF;
                    //System.out.println("mdotN: " + mdot[N] + ", CF: " + CF + ", At: " + At);
                    Pn_0 = mdot[N] * CStar / At;
                    //Pn_0 = calPressure(sections, maxLayers, N, Ln, x, a_i, rb, rbA, t, Pn_minus1);
                    //Pn_plus1 = calPressure(sections, maxLayers, N, Ln, x, a_i, rb, rbA, t, Pn_0);
                    double e_n_plus_1 = Math.abs(Pn_plus1-Pn_0);
                    double e_n = Math.abs(Pn_0-Pn_minus1);
                    //if (Math.abs((Pg - P) / P) < climit) {
                    //if ((e_n_plus_1 / e_n) <= climit) {   
                    if (Math.abs((Pn_minus1 - Pn_0) / Pn_0) < climit) {
                        P = Pn_0;
                        Pn_minus1 = P;
                        Pn_plus1 = P;
                        System.out.println("Pressure converged to " + P + " after "+iterCnt+" iterations");
                        isConverged = true;
                    } else {
                        Pn_minus1 = Pn_0;
                        P = Pn_0;
                        System.out.println("Pressure " + P + " is not converged after "+iterCnt+" iterations");
                        if(iterCnt>100) {
                            //P = 1000*6895;
                            iterCnt = 0;
                            isConverged = true;
                        }
                        //Pg = P;
                    }
                    //isConverged = true;
                } while (!isConverged);
                Lc = 0;
                for (int i = 0; i <= N; i++) {
                    Lc = i * Ln;
                    double secL = 0;
                    for (int k = 0; k < sections.size(); k++) {
                        secL = secL + sections.get(k).getSectionLength();
                        if (secL >= Lc) {
                            for (int j = 0; j < maxLayers; j++) {
                                x[i][j] = x[i][j] + rb[i][j] * tdelta;
                            }

                        }
                    }

                }

                //System.out.println("Rb at " + t + " s : " + Arrays.deepToString(rb));
                //System.out.println("x: at " + t + " s : " + Arrays.deepToString(x));
                //System.out.println("Peri: at " + t + " s : " + Arrays.deepToString(Peri));
                //System.out.println("Port: at " + t + " s : " + Arrays.toString(Ap));
                //out.println("t = "+t+" s");
                IBOutput ib_out = new IBOutput();
                ib_out.setTime(t);
                time.add(t);
                t = t + tdelta;
                if (t >= ts && P <= 50 * 6895 || Double.isNaN(P)) {
                    isAborted = true;
                }
                pressure.add(P); //(N/m^2)
                ib_out.setPressure(P);
                double instThrust = (double) Math.round(P * At * CF / 9.8 * 2.204 * Math.pow(10, precision)) / Math.pow(10, precision);
                thrust.add(instThrust);
                ib_out.setThrust(instThrust);
                
                output.add(ib_out);
                System.out.println("Pressure: "+P);
                System.out.println("Thrust: "+instThrust);
            }
            
            //output.setPressure(pressure);
            //output.setThrust(thrust);
            //output.setTime(time);
            out.println(mapper.writeValueAsString(output));
            aContext.complete();
        } catch (IOException ex) {
            out.println(ex.getMessage());
        }

    }
    
    public double calPressure(List<SectionInfo> sections,int maxLayers,int N
            , double Ln, double[][] x, double[][] a_i, double[][] rb, double[][] rbA
            , double t
            , double P) {
        try {
            double[] Ap = new double[N + 1];                               //Port area  at time t of each segment

            double[][] Peri = new double[N + 1][maxLayers];                //Periphery for each segment and layer

            double[][] rb_m0 = new double[N + 1][maxLayers];               //Burning rate at zero mass flow for each segment and layer

            double[] mdot = new double[N + 1];                             //Mass flow rate at time t at each segment (kg/s)
            double[] mdotA = new double[N + 1];                            //Dummy Mass flow rate at time t at each segment (kg/s)

            double[] mach = new double[N + 1];                             //Mach at time t of each segment 
            double[] machA = new double[N + 1];                            //dummy mach

            //double CF = 0;
            double[][] gas = new double[sections.size()][maxLayers];
                    double[][] gasfrac = new double[sections.size()][maxLayers];

            double Lc = 0;

                    for (int i = 0; i <= N; i++) {
                        Lc = i * Ln;
                        double secL = 0;
                        for (int k = 0; k < sections.size(); k++) {
                            secL = secL + sections.get(k).getSectionLength() / 1000;
                            if (secL >= Lc) {
                                //System.out.println("calculate geom for segment "+i+" in section "+k);
                                Geom(sections.get(k), i, maxLayers, x, Peri, Ap);

                                //System.out.println(errStr);
                                for (int j = 0; j < maxLayers; j++) {

                                    //CALC BASE MASS BURN RATE
                                    rb_m0[i][j] = a_i[k][j] * Math.pow(P, sections.get(k).getSectionLayers().get(j).getLayerPressureExponent());

                                    //FIND MIXTURE RATIO OF COMBUSTION GAS FROM THE PROPELLANTS
                                    gas[k][j] = gas[k][j] + rb[i][j] * Peri[i][j];

                                }
                                break;
                            }
                        }

                    }

                    //FIND MIXTURE RATIO OF COMBUSTION GAS FROM THE TWO PROPELLANTS
                    double sumGas = 0;
                    for (double[] g : gas) {
                        for (double gg : g) {
                            sumGas = sumGas + gg;
                        }

                    }
                    if (sumGas == 0) {
                        gasfrac[0][0] = 1;

                    } else {
                        for (int i = 0; i < sections.size(); i++) {
                            for (int j = 0; j < maxLayers; j++) {
                                gasfrac[i][j] = gas[i][j] / sumGas;
                            }
                        }

                    }
                    //System.out.println("Gas: at " + t + " s : " + Arrays.deepToString(gas));
                    //System.out.println("Gas Frac: at " + t + " s : " + Arrays.deepToString(gasfrac));
                    double Rmix = 0;
                    double Tmix = 0;
                    double Gammix = 0;
                    for (int i = 0; i < sections.size(); i++) {
                        for (int j = 0; j < maxLayers; j++) {
                            Rmix = Rmix + sections.get(i).getSectionLayers().get(j).getLayerGasConst() * gasfrac[i][j];
                            Tmix = Tmix + sections.get(i).getSectionLayers().get(j).getLayerGasTemp() * gasfrac[i][j];
                            Gammix = Gammix + sections.get(i).getSectionLayers().get(j).getLayerHeatCapacity() * gasfrac[i][j];
                        }
                    }
//                    System.out.println("Rmix: " + Rmix);
//                    System.out.println("Tmix: " + Tmix);
//                    System.out.println("Gammix: " + Gammix);
                    //calculate m0
                    mdot[0] = IgnitionMassFlow(t);
                    mach[0] = mdot[0] / P / Ap[0] * Math.sqrt(Rmix * Tmix / Gammix);
                    double G0 = 0.0;
                    double D0 = 0.0;
                    double B0 = 0.0;
                    if (mdot[0] == 0) {
                        for (int j = 0; j < maxLayers; j++) {
                            rb[0][j] = rb_m0[0][j];

                        }
                    } else {
                        double sumPeri = 0;
                        for (int j = 0; j < maxLayers; j++) {
                            sumPeri = sumPeri + Peri[0][j];

                        }
                        G0 = mdot[0] / Ap[0];
                        D0 = 4 * Ap[0] / sumPeri;
                        B0 = 53 * rb[0][0] * sections.get(0).getSectionLayers().get(0).getLayerDensity() * 1000 / G0;
                        for (int j = 0; j < maxLayers; j++) {
                            if (sections.get(0).getSectionLayers().get(j) != null) {
                                //double alpha = sections.get(0).getSectionLayers().get(j).getLayerAlpErosive();
                                //alpha = alpha*(Math.pow(10,-7));
                                double alpha0 = 0.000006;
                                rb[0][j] = rb_m0[0][j] + alpha0 * (Math.pow(G0, 0.8)) * (Math.pow(D0, -0.2)) * Math.exp(-1 * B0);
                            } else {
                                rb[0][j] = 0;
                            }

                        }
                    }
                    double GA = 0.0;
                    double DA = 0.0;
                    double[][] BA = new double[sections.size()][maxLayers];
                    double[][] B = new double[sections.size()][maxLayers];
                    double G = 0.0;
                    double D = 0.0;
                    Lc = 0;
                    for (int i = 1; i <= N; i++) {
                        double sumPeri = 0;
                        Lc = i * Ln;
                        for (int j = 0; j < maxLayers; j++) {
                            sumPeri = sumPeri + Peri[i][j];

                        }
                        double secL = 0;
                        int secIdx = 0;
                        //find current section
                        for (int k = 0; k < sections.size(); k++) {
                            secL = secL + sections.get(k).getSectionLength() / 1000;
                            if (secL >= Lc) {
                                secIdx = k;
                                break;
                            }
                        }
                        if (sumPeri > 0) {

                            // Calculate dummy mass flow rate
                            double gengas_term = 0;
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                //System.out.println("Distance: "+x[i][j]+", Area: "+Ap[i]);
                                //System.out.println("Rb i-1: "+rb[i - 1][j]);
                                //System.out.println("Peri i-1: "+Peri[i - 1][j]);
                                //System.out.println("Peri i: "+Peri[i][j]);
                                //System.out.println("Density: "+sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000);
                                //System.out.println("Ln: "+Ln);
                                gengas_term = gengas_term + rb[i - 1][j] * ((Peri[i - 1][j] + Peri[i][j]) / 2) * Ln * (sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000);
                            }
                            //System.out.println("Dummy Gen gas "+gengas_term);
                            mdotA[i] = mdot[i - 1] + gengas_term;
                            machA[i] = (mdotA[i] / P / Ap[0]) * Math.sqrt(Rmix * Tmix / Gammix);
                            GA = mdotA[i] / Ap[i];
                            DA = 4 * Ap[i] / (sumPeri);
                            if (GA == 0) {
                                for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                    BA[secIdx][j] = Math.pow(10, 11);
                                }

                            } else {
                                for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                    BA[secIdx][j] = 53 * rb[i][j] * sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000 / GA;
                                }

                            }
                            // BURNING RATE USING MASS FLOW RATE FROM LAST SEGMENT
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                double alphaA = sections.get(secIdx).getSectionLayers().get(j).getLayerAlpErosive() * (Math.pow(10, -7));

                                //alpha = alpha/(Math.pow(10,7));
                                //System.out.println("GA: "+GA);
                                //System.out.println("DA: "+DA);
                                //System.out.println("BA: "+BA[secIdx][j]);
                                //System.out.println("Rb_M0: "+(rb_m0[i][j]+2.2));
                                //System.out.println("Alpha: "+alphaA);
                                //alphaA*(Math.pow(10,-7)) * (Math.pow(GA, 0.8)) * (Math.pow(DA, -0.2)) * Math.exp(-1 * BA[secIdx][j])
                                //rbA[i][j] = 0;
                                rbA[i][j] = rb_m0[i][j] + alphaA * (Math.pow(10, -7)) * (Math.pow(GA, 0.8)) * (Math.pow(DA, -0.2)) * Math.exp(-1 * BA[secIdx][j]);
                            }
                            gengas_term = 0;
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                //System.out.println("Rb i-1: "+rb[i - 1][j]);
                                //System.out.println("RbA i: "+rbA[i][j]);
                                //System.out.println("Peri i-1: "+Peri[i - 1][j]);
                                //System.out.println("Peri i: "+Peri[i][j]);
                                //System.out.println("Density: "+sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000);
                                //System.out.println("Ln: "+Ln);
                                gengas_term = gengas_term + ((rb[i - 1][j] * Peri[i - 1][j] + rbA[i][j] * Peri[i][j]) / 2) * Ln * sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000;
                            }
                            //System.out.println("Gen gas "+gengas_term);
                            mdot[i] = mdot[i - 1] + gengas_term;
                            mach[i] = (mdot[i] / P / Ap[0]) * Math.sqrt(Rmix * Tmix / Gammix);

                            G = mdot[i] / Ap[i];
                            D = 4 * Ap[i] / (sumPeri);
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                B[secIdx][j] = 53 * rb[i][j] * sections.get(secIdx).getSectionLayers().get(j).getLayerDensity() * 1000 / G;
                                // correct burning rate
                                //double alpha = sections.get(secIdx).getSectionLayers().get(j).getLayerAlpErosive();
                                double alpha = 0.000006;
                                //alpha = alpha*(Math.pow(10,-7));
                                //System.out.println("G: "+G);
                                //System.out.println("D: "+D);
                                //System.out.println("B: "+B[secIdx][j]);
                                //System.out.println("Rb_M0: "+rb_m0[i][j]);
                                //System.out.println("Alpha: "+alpha);
                                rb[i][j] = rb_m0[i][j] + alpha * (Math.pow(G, 0.8)) * (Math.pow(D, -0.2)) * Math.exp(-1 * B[secIdx][j]);
                            }

                        } else {
                            mdotA[i] = mdot[i - 1];
                            mdot[i] = mdot[i - 1];
                            for (int j = 0; j < sections.get(secIdx).getSectionLayers().size(); j++) {
                                rbA[i][j] = 0;
                                rb[i][j] = 0;
                            }

                        }
                        //System.out.println("***mdotI: " + mdot[i] + ",mdotA: " + mdotA[i] + ",GA: " + GA + ",DA: " + DA);
                    }
                    double sumPeri = 0;
                    for (int j = 0; j < maxLayers; j++) {
                        sumPeri = sumPeri + Peri[0][j];

                    }
                    if (sumPeri == 0) {
                        for (int j = 0; j < maxLayers; j++) {
                            rb[0][j] = 0;

                        }
                    }

                    if (mdot[N] == 0) {
                        P = 50*6895;
                        return P;
                    }
                    double k = 2 * Math.pow(Gammix, 2) / (Gammix - 1);
                    double k1 = Math.pow(2 / (Gammix + 1), (Gammix + 1) / (Gammix - 1));
                    double k2 = 1 - Math.pow(101356.5 / P, (Gammix - 1) / Gammix);
                    CF = Math.sqrt(k * k1 * k2);
                    //CF = 1.6;
                    double CStar = ISP * 9.80665 / CF;
                    //System.out.println("mdotN: " + mdot[N] + ", CF: " + CF + ", At: " + At);
                    P = mdot[N] * CStar / At;
                    return P;
        } catch(Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

}
