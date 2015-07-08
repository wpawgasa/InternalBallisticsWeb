/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */




import java.util.ArrayList;
import java.util.List;
import java.util.Vector;


/**
 *
 * @author amabird
 */
public class SectionInfo {

    

    

    private List<PropellantLayer> layers = new ArrayList<PropellantLayer>();
    private List<PropellantGeom> geom = new ArrayList<PropellantGeom>();
    private List<PropellantGeom> genGeom = new ArrayList<PropellantGeom>();
  
    private String section_id;

    public SectionInfo() {
    }

    public List<PropellantLayer> getLayers() {
        return layers;
    }

    public void setLayers(List<PropellantLayer> layers) {
        this.layers = layers;
    }

    public String getSection_id() {
        return section_id;
    }

    public void setSection_id(String section_id) {
        this.section_id = section_id;
    }

    public List<PropellantGeom> getGeom() {
        return geom;
    }

    public void setGeom(List<PropellantGeom> geom) {
        this.geom = geom;
    }

    public List<PropellantGeom> getGenGeom() {
        return genGeom;
    }

    public void setGenGeom(List<PropellantGeom> genGeom) {
        this.genGeom = genGeom;
    }
    
    
    
    
    

    
    
    

}
