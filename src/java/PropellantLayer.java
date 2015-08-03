
import java.util.ArrayList;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author wichai.p
 */
public class PropellantLayer {

    private int layerId;
    private String layerName;
    private String layerMaterial;
    private double layerBurningRate;
    private double layerPressureExponent;
    private double layerDensity;
    private double layerAlpErosive;
    private double layerGasTemp;
    private double layerGasConst;
    private double layerHeatCapacity;
    private double layerMaxBurningDistance;
    private double layerStartBurningDistance;
    private double rb; //burnining rate at time t
    private double rb_m0; //burnining rate at time t
    private double x;  //burning distance at time t
    private double Ap; //burning port area at time t
    private double peri; //periphery at time t
    private double rbA; //Dummy burning rate at time t
    private double a_factor; //pre-exponent factor
    private double gas;
    private double gasFrac;
    
    public PropellantLayer() {
    }

    public PropellantLayer(PropellantLayer a) {
        this.layerId = a.layerId;
        this.layerName = a.layerName;
        this.layerMaterial = a.layerMaterial;
        this.layerBurningRate = a.layerBurningRate;
        this.layerPressureExponent = a.layerPressureExponent;
        this.layerDensity = a.layerDensity;
        this.layerAlpErosive = a.layerAlpErosive;
        this.layerGasTemp = a.layerGasTemp;
        this.layerGasConst = a.layerGasConst;
        this.layerHeatCapacity = a.layerHeatCapacity;
        this.layerMaxBurningDistance = a.layerMaxBurningDistance;
        this.layerStartBurningDistance = a.layerStartBurningDistance;
        this.rb = a.rb; //burnining rate at time t
        this.rb_m0 = a.rb_m0; //burnining rate at time t
        this.x = a.x;  //burning distance at time t
        this.Ap = a.Ap; //burning port area at time t
        this.peri = a.peri; //periphery at time t
        this.rbA = a.rbA; //Dummy burning rate at time t
        this.a_factor = a.a_factor; //pre-exponent factor
        this.gas = a.gas;
        this.gasFrac = a.gasFrac;
    }

    public int getLayerId() {
        return layerId;
    }

    public void setLayerId(int layerId) {
        this.layerId = layerId;
    }

    public String getLayerName() {
        return layerName;
    }

    public void setLayerName(String layerName) {
        this.layerName = layerName;
    }

    public String getLayerMaterial() {
        return layerMaterial;
    }

    public void setLayerMaterial(String layerMaterial) {
        this.layerMaterial = layerMaterial;
    }

    public double getLayerBurningRate() {
        return layerBurningRate;
    }

    public void setLayerBurningRate(double burningRate) {
        this.layerBurningRate = burningRate;
    }

    public double getLayerPressureExponent() {
        return layerPressureExponent;
    }

    public void setLayerPressureExponent(double layerPressureExponent) {
        this.layerPressureExponent = layerPressureExponent;
    }

    public double getLayerDensity() {
        return layerDensity;
    }

    public void setLayerDensity(double layerDensity) {
        this.layerDensity = layerDensity;
    }

    public double getLayerAlpErosive() {
        return layerAlpErosive;
    }

    public void setLayerAlpErosive(double layerAlpErosive) {
        this.layerAlpErosive = layerAlpErosive;
    }

    public double getLayerGasTemp() {
        return layerGasTemp;
    }

    public void setLayerGasTemp(double layerGasTemp) {
        this.layerGasTemp = layerGasTemp;
    }

    public double getLayerGasConst() {
        return layerGasConst;
    }

    public void setLayerGasConst(double layerGasConst) {
        this.layerGasConst = layerGasConst;
    }

    public double getLayerHeatCapacity() {
        return layerHeatCapacity;
    }

    public void setLayerHeatCapacity(double layerHeatCapacity) {
        this.layerHeatCapacity = layerHeatCapacity;
    }

    public double getLayerMaxBurningDistance() {
        return layerMaxBurningDistance;
    }

    public void setLayerMaxBurningDistance(double layerMaxBurningDistance) {
        this.layerMaxBurningDistance = layerMaxBurningDistance;
    }

    public double getLayerStartBurningDistance() {
        return layerStartBurningDistance;
    }

    public void setLayerStartBurningDistance(double layerStartBurningDistance) {
        this.layerStartBurningDistance = layerStartBurningDistance;
    }

    public double getRb() {
        return rb;
    }

    public void setRb(double rb) {
        this.rb = rb;
    }

    public double getRb_m0() {
        return rb_m0;
    }

    public void setRb_m0(double rb_m0) {
        this.rb_m0 = rb_m0;
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getPeri() {
        return peri;
    }

    public void setPeri(double peri) {
        this.peri = peri;
    }

    public double getRbA() {
        return rbA;
    }

    public void setRbA(double rbA) {
        this.rbA = rbA;
    }

    public double getA_factor() {
        return a_factor;
    }

    public void setA_factor(double a_factor) {
        this.a_factor = a_factor;
    }

    public double getAp() {
        return Ap;
    }

    public void setAp(double Ap) {
        this.Ap = Ap;
    }

    public double getGas() {
        return gas;
    }

    public void setGas(double gas) {
        this.gas = gas;
    }

    public double getGasFrac() {
        return gasFrac;
    }

    public void setGasFrac(double gasFrac) {
        this.gasFrac = gasFrac;
    }
    
    
    

}
