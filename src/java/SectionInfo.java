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

    

    

    private List<PropellantLayer> sectionLayers = new ArrayList<PropellantLayer>();
    private List<PropellantGeom> geom = new ArrayList<PropellantGeom>();
    private List<PropellantGeom> generatedGeom = new ArrayList<PropellantGeom>();
  
    private String sectionId;
    private String sectionName;
    private double sectionLength;
    private double sectionInnerDiameter;
    private double sectionOuterDiameter;
    private int sectionPortShapeId;
    

    public SectionInfo() {
    }


    public String getSectionId() {
        return sectionId;
    }

    public void setSection_id(String sectionId) {
        this.sectionId = sectionId;
    }

    public List<PropellantGeom> getGeom() {
        return geom;
    }

    public void setGeom(List<PropellantGeom> geom) {
        this.geom = geom;
    }

    public List<PropellantGeom> getGeneratedGeom() {
        return generatedGeom;
    }

    public void setGeneratedGeom(List<PropellantGeom> genGeom) {
        this.generatedGeom = genGeom;
    }

    public List<PropellantLayer> getSectionLayers() {
        return sectionLayers;
    }

    public void setSectionLayers(List<PropellantLayer> sectionLayers) {
        this.sectionLayers = sectionLayers;
    }

    public String getSectionName() {
        return sectionName;
    }

    public void setSectionName(String sectionName) {
        this.sectionName = sectionName;
    }

    public double getSectionLength() {
        return sectionLength;
    }

    public void setSectionLength(double sectionLength) {
        this.sectionLength = sectionLength;
    }

    public double getSectionInnerDiameter() {
        return sectionInnerDiameter;
    }

    public void setSectionInnerDiameter(double sectionInnerDiameter) {
        this.sectionInnerDiameter = sectionInnerDiameter;
    }

    public double getSectionOuterDiameter() {
        return sectionOuterDiameter;
    }

    public void setSectionOuterDiameter(double sectionOuterDiameter) {
        this.sectionOuterDiameter = sectionOuterDiameter;
    }

    public int getSectionPortShapeId() {
        return sectionPortShapeId;
    }

    public void setSectionPortShapeId(int sectionPortShapeId) {
        this.sectionPortShapeId = sectionPortShapeId;
    }
    
    
    
    
    

    
    
    

}
