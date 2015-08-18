
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author wpawgasa
 */
public class testCalculation {
    public static ObjectMapper mapper = new ObjectMapper();;
    
    public static void main(String args[]) {
        ServerMessage msg = new ServerMessage();
         
        try {
            String motorStr = "{\"motorSections\":[{\"sectionId\":\"3a1e6f75-f243-8973-c410-c4b0d99011fc\",\"sectionName\":\"\",\"sectionLength\":80,\"sectionOuterDiameter\":40,\"sectionInnerDiameter\":20,\"sectionLayers\":[{\"layerId\":1,\"layerName\":\"Not Set\",\"layerMaterial\":\"Not Set\",\"layerBurningRate\":11,\"layerPressureExponent\":0.48,\"layerDensity\":1.795,\"layerAlpErosive\":60,\"layerGasTemp\":3500,\"layerGasConst\":308,\"layerHeatCapacity\":1.2,\"layerMaxBurningDistance\":10,\"layerStartBurningDistance\":0}],\"sectionPortShapeId\":0,\"generatedGeom\":[{\"distance\":0,\"port_area\":6140.93,\"perimeter\":566.4},{\"distance\":1,\"port_area\":6708,\"perimeter\":567.8},{\"distance\":2,\"port_area\":7276.7,\"perimeter\":569.5},{\"distance\":3,\"port_area\":7847.2,\"perimeter\":571.5},{\"distance\":4,\"port_area\":8419.7,\"perimeter\":573.6},{\"distance\":5,\"port_area\":8994.4,\"perimeter\":575.9},{\"distance\":6,\"port_area\":9571.6,\"perimeter\":578.5},{\"distance\":7,\"port_area\":10151.4,\"perimeter\":581.2},{\"distance\":8,\"port_area\":10774,\"perimeter\":584},{\"distance\":9,\"port_area\":11319.5,\"perimeter\":587},{\"distance\":10,\"port_area\":11908.1,\"perimeter\":590.2},{\"distance\":11,\"port_area\":12500,\"perimeter\":593.4},{\"distance\":12,\"port_area\":13095,\"perimeter\":596.8},{\"distance\":13,\"port_area\":13693,\"perimeter\":600.3},{\"distance\":14,\"port_area\":14296,\"perimeter\":604.9},{\"distance\":15,\"port_area\":14901.5,\"perimeter\":607.6},{\"distance\":16,\"port_area\":15504.4,\"perimeter\":618.6},{\"distance\":17,\"port_area\":16094.3,\"perimeter\":610.1},{\"distance\":18,\"port_area\":16670.7,\"perimeter\":596.4000000000001},{\"distance\":19,\"port_area\":17235.9,\"perimeter\":578.0999999999999},{\"distance\":20,\"port_area\":17795.1,\"perimeter\":565.6},{\"distance\":21,\"port_area\":18351.5,\"perimeter\":559},{\"distance\":22,\"port_area\":18907.2,\"perimeter\":555.8},{\"distance\":23,\"port_area\":19463.5,\"perimeter\":557},{\"distance\":24,\"port_area\":20021.5,\"perimeter\":559.1},{\"distance\":25,\"port_area\":20581.9,\"perimeter\":561.8},{\"distance\":26,\"port_area\":21145.2,\"perimeter\":565},{\"distance\":27,\"port_area\":21712,\"perimeter\":568.6},{\"distance\":28,\"port_area\":22282.5,\"perimeter\":572.5},{\"distance\":29,\"port_area\":22857.1,\"perimeter\":576.8},{\"distance\":30,\"port_area\":23436.1,\"perimeter\":581.2},{\"distance\":31,\"port_area\":24019.6,\"perimeter\":585.9},{\"distance\":32,\"port_area\":24607.9,\"perimeter\":590.7},{\"distance\":33,\"port_area\":25201.1,\"perimeter\":595.7},{\"distance\":34,\"port_area\":25799.3,\"perimeter\":600.8},{\"distance\":35,\"port_area\":26402.6,\"perimeter\":606},{\"distance\":36,\"port_area\":27011.2,\"perimeter\":611.3},{\"distance\":37,\"port_area\":27625.1,\"perimeter\":616.6},{\"distance\":38,\"port_area\":28869.3,\"perimeter\":627.6},{\"distance\":39,\"port_area\":29494.1,\"perimeter\":633.1},{\"distance\":40,\"port_area\":29449.7,\"perimeter\":633.2},{\"distance\":41,\"port_area\":30135.7,\"perimeter\":638.8},{\"distance\":42,\"port_area\":30777.4,\"perimeter\":644.5},{\"distance\":43,\"port_area\":31424.7,\"perimeter\":650.2},{\"distance\":44,\"port_area\":334468.0464,\"perimeter\":798.5000000000001},{\"distance\":45,\"port_area\":334817.9888,\"perimeter\":613.0999999999999},{\"distance\":46,\"port_area\":636126.32112,\"perimeter\":469.2},{\"distance\":47,\"port_area\":33531.33056,\"perimeter\":377.9},{\"distance\":48,\"port_area\":33547.39152,\"perimeter\":305.1},{\"distance\":49,\"port_area\":33558.21968,\"perimeter\":241.9},{\"distance\":50,\"port_area\":33564.08504,\"perimeter\":184.70000000000002},{\"distance\":51,\"port_area\":33565.35,\"perimeter\":131.6},{\"distance\":52,\"port_area\":33653.5,\"perimeter\":69.2},{\"distance\":53,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":54,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":55,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":56,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":57,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":58,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":59,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":60,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":61,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":62,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":63,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":64,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":65,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":66,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":67,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":68,\"port_area\":33653.5,\"perimeter\":0},{\"distance\":69,\"port_area\":33653.5,\"perimeter\":0}]}],\"motorDiameter\":50,\"motorLength\":100,\"throatDiameter\":50}";
            int numSegments = 50;
            double Pg = 1000 * 6895;                //Guess pressure (N/m^2)
            double Isp = 250;
            List<Double> pressure = new ArrayList<Double>();
            List<Double> thrust = new ArrayList<Double>();
            RocketMotor motor = mapper.readValue(motorStr, RocketMotor.class);
            CalFunctions cal = new CalFunctions(motorStr, numSegments, Pg, Isp);
            cal.run();
            
        } catch (Exception e) {
            StackTraceElement[] st = e.getStackTrace();
            String err = "";
            System.out.println(e.getMessage());
            for (StackTraceElement st1 : st) {
                System.out.println("Error on line " + st1.getLineNumber() + ": "
                        + st1.getMethodName() + ", " + st1.getClassName() + ", " + st1.getFileName());

            }
            //msg.setMsg_name("Simulation Error");
            //msg.setMsg_status(false);
            //msg.setMsg_content("Error: " + e.getMessage() + "\n" +err );
            //System.out.println(mapper.writeValueAsString(msg));
            //out.close();
        }
    }

    

    private static void Geom(SectionInfo section, int segmentIdx, int maxLayers, double[][] x, double[][] Peri, double[] Ap) {

        try {
            List<PropellantGeom> geoms = section.getGeneratedGeom();
            //System.out.println("Gen Geom: "+mapper.writeValueAsString(geoms));
            //testStr = "";
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
            String errStr = "";
            errStr = errStr + ex.getMessage();
            for (StackTraceElement st1 : st) {
                errStr = errStr + "Error on line " + st1.getLineNumber() + ": "
                        + st1.getMethodName() + ", " + st1.getClassName() + ", " + st1.getFileName();

            }
        }

    }

    private static double IgnitionMassFlow(double T) {

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
}
