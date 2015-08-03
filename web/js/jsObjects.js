/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var motorObj = function motorObj() {
    this.motorSections = new Array();
    this.motorDiameter = 50;
    this.motorLength = 100;
    this.throatDiameter = 50;
};

motorObj.prototype.getSections = function() {
    return this.motorSections;
}
motorObj.prototype.setSections = function(sections) {
    this.motorSections = sections;
}
motorObj.prototype.getSection = function(id) {
    var sections = this.getSections();
    
    for(var i=0;i < sections.length;i++) {
        var isection = sections[i];
        if(isection.getId===id) {
            return isection;
        }
    }
    return null;
}
motorObj.prototype.setSection = function(section,id) {
    var sections = this.getSections();
    
    for(var i=0;i < sections.length;i++) {
        var isection = sections[i];
        if(isection.getId()===id) {
            isection = section;
            return;
        }
    }
    return;
}

motorObj.prototype.addSection = function(section) {
    
    this.getSections().push(section);
    
    return;
}

motorObj.prototype.removeSection = function(section) {
    
    var sectionId = section.getId();
        var sections = this.getSections();
        
        for(var i=0;i < sections.length;i++) {
            var isection = sections[i];
            if(isection.getId()===sectionId) {
                sections.splice(i,1);
            }
        }
}



var sectionObj = function sectionObj(){
    this.sectionId = '';
    this.sectionName = '';
    this.sectionLength = 100;
    this.sectionOuterDiameter = 50;
    this.sectionInnerDiameter = 10;
    this.sectionLayers = new Array();
    this.sectionPortShapeId = 0; 
    //this.sectionGraphicObj = null;
    //this.innerPortGraphicObj = null;
    this.generatedGeom = null;
};

sectionObj.prototype.getId = function() {
    return this.sectionId;
}
sectionObj.prototype.setId = function(id) {
    this.sectionId = id;
    return;
}

sectionObj.prototype.getName = function() {
    return this.sectionName;
}
sectionObj.prototype.setName = function(name) {
    this.sectionName = name;
    return;
}

sectionObj.prototype.getLength = function() {
    return this.sectionLength;
}
sectionObj.prototype.setLength = function(name) {
    this.sectionLength = name;
    return;
}

sectionObj.prototype.getOuterDiameter = function() {
    return this.sectionLength;
}
sectionObj.prototype.setOuterDiameter = function(name) {
    this.sectionLength = name;
    return;
}

sectionObj.prototype.getInnerDiameter = function() {
    return this.sectionLength;
}
sectionObj.prototype.setInnerDiameter = function(name) {
    this.sectionLength = name;
    return;
}

sectionObj.prototype.getInnerDiameter = function() {
    return this.sectionLength;
}
sectionObj.prototype.setInnerDiameter = function(name) {
    this.sectionLength = name;
    return;
}

sectionObj.prototype.getLayers = function() {
    return this.sectionLayers;
}
sectionObj.prototype.setLayers = function(sections) {
    this.sectionLayers = sections;
}
sectionObj.prototype.getLayer = function(id) {
    //console.log(id);
    var layers = this.getLayers();
    //console.log(layers);
    for(var i=0;i < layers.length;i++) {
        var ilayer = layers[i];
        if(ilayer.layerId==id) {
            return ilayer;
        }
    }
    return null;
}
sectionObj.prototype.setLayer = function(layer) {
    var layers = this.getLayers();
    //console.log(layers);
    //console.log(layer);
    for(var i=0;i < layers.length;i++) {
        if(layers[i].layerId==layer.layerId) {
            layers[i] = layer;
            //console.log(layers[i]);
            return;
        }
    }
    return;
}

sectionObj.prototype.addLayer = function(layer) {
    console.log(layer);
    this.getLayers().push(layer);
    
    return;
}

sectionObj.prototype.removeLayer = function(layer) {
    
    var layerId = layer.getId();
        var layers = this.getLayers();
        
        for(var i=0;i < layers.length;i++) {
            var ilayer = layers[i];
            if(ilayer.getId()===layerId) {
                layers.splice(i,1);
            }
        }
}



var layerObj = function layerObj(){
    this.layerId = '';
    this.layerName = '';
    this.layerMaterial = '';
    this.layerBurningRate = 11.0;
    this.layerPressureExponent = 0.48;
    this.layerDensity = 1.795;
    this.layerAlpErosive = 60;
    this.layerGasTemp = 3500;
    this.layerGasConst = 308;
    this.layerHeatCapacity = 1.2;
    this.layerMaxBurningDistance = 5;
    this.layerStartBurningDistance = 0;
};

layerObj.prototype.getId = function() {
    return this.layerId;
}
layerObj.prototype.setId = function(id) {
    this.layerId = id;
    return;
}

layerObj.prototype.getName = function() {
    return this.layerName;
}
layerObj.prototype.setName = function(name) {
    this.layerName = name;
    return;
}

layerObj.prototype.getMaterial = function() {
    return this.layerMaterial;
}
layerObj.prototype.setMaterial = function(name) {
    this.layerMaterial = name;
    return;
}

var portShapeObj = {
    
};


