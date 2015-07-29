
import java.util.ArrayList;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author wpawgasa
 */
public class RocketMotor {
    
    private double motorDiameter;
    private double motorLength;
    private double throatDiameter;
    private List<SectionInfo> motorSections = new ArrayList<SectionInfo>();

    public RocketMotor() {
    }

    public double getMotorDiameter() {
        return motorDiameter;
    }

    public void setMotorDiameter(double motorDiameter) {
        this.motorDiameter = motorDiameter;
    }

    public double getMotorLength() {
        return motorLength;
    }

    public void setMotorLength(double motorLength) {
        this.motorLength = motorLength;
    }

    public double getThroatDiameter() {
        return throatDiameter;
    }

    public void setThroatDiameter(double throatDiameter) {
        this.throatDiameter = throatDiameter;
    }

    public List<SectionInfo> getMotorSections() {
        return motorSections;
    }

    public void setMotorSections(List<SectionInfo> motorSections) {
        this.motorSections = motorSections;
    }
    
    
    
}
