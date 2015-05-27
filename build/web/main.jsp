<%-- 
    Document   : main
    Created on : Feb 14, 2015, 2:36:42 PM
    Author     : roongtawan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Internal Ballistics</title>
        <link href="KendoUI/styles/kendo.common.min.css" rel="stylesheet"/>
        <link href="KendoUI/styles/kendo.bootstrap.min.css" rel="stylesheet"/>

        <link href="KendoUI/styles/kendo.dataviz.min.css" rel="stylesheet"/>
        <link href="KendoUI/styles/kendo.dataviz.default.min.css" rel="stylesheet"/>
        <link href="styles/default.css" rel="stylesheet"/>
        <script src="KendoUI/js/jquery.min.js"></script>
        <script src="js/svg.min.js"></script>
        <script src="KendoUI/js/kendo.all.min.js"></script>
        <script src="js/Utilities.js"></script>
        <script src="js/jsObjects.js"></script>
    </head>
    <body>
        <div id="example">
            <div id="megaStore">
                <ul id="menu">
                    <li>
                        File
                        <ul>
                            <li>Load Configuration</li>
                            <li>Save Configuration</li>
                            <li>Logout</li>
                        </ul>
                    </li>   
                </ul>
            </div>
            <div class="demo-section k-header">
                <div id="mainTab">
                    <ul>
                        <li class="k-state-active">
                            Geometric
                        </li>
                        <li>
                            Simulation
                        </li>

                    </ul>

                    <div class="weather">
                        <div  id="splitter">
                            <div class="pane-content">
                                <div class ="topPane">
                                    <div>
                                        <h4>Rocket Diameter <input id="rocketDiameter_Spinner" type="number" value="0" min="0" max="500" /> mm</h4>
                                        <input id="rocketDiameter_Slider" class="balSlider" />

                                    </div>
                                    <div>
                                        <h4>Rocket Length <input id="rocketLength_Spinner" type="number" value="0" min="0" max="500" /> mm</h4>
                                        <input id="rocketLength_Slider" class="balSlider" />

                                    </div>
                                    <div>
                                        <h4>Throat Diameter <input id="throatDiameter_Spinner" type="number" value="0" min="0" max="500" /> mm</h4>
                                        <input id="throatDiameter_Slider" class="balSlider" />

                                    </div>
                                    <div>
                                        <h4>Igniter Mass <input id="igniterMass_Spinner" type="number" value="0" min="0" max="500" /> kg</h4>
                                        <input id="igniterMass_Slider" class="balSlider" />

                                    </div>
                                    <div>
                                        <h4>Igniter Burn Time <input id="igniterBurnTime_Spinner" type="number" value="0" min="0" max="500" /> s</h4>
                                        <input id="igniterBurnTime_Slider" class="balSlider" />

                                    </div>

                                    <div class="vertical-main">
                                        <a id="addSectionButton" class="k-primary">Add Section</a> 
                                        <a id="removeSectionButton" class="k-primary">Remove Section</a> 
                                    </div>
                                </div>

                                <div> 

                                </div>
                            </div>
                            <div class="pane-content">
                                
                                <div id="graphicTab">
                                    <div><span id="elm_selected_indicator">No element is selected</span></div>
                                    <div id="svgDrawing">

                                    </div>
                                </div>
                            </div>
                            <div class="pane-content">
                                <div id="propellantTab">
                                    <ul>
                                        <li class="k-state-active">
                                            Propellant Properties
                                        </li>
                                        <li>
                                            Propellant Geometric
                                        </li>
                                        <li>
                                            Burning Distance
                                        </li>
                                    </ul>
                                    <div class="weather">
                                        <div id="propellantPropertiesGrid"></div>
                                        <div class="vertical-propellant-properties">
                                            <button type="button" id="addPropellantPropertiesButton">Add</button>
                                            <button type="button" id="removePropellantPropertiesButton">Remove</button>
                                        </div>
                                    </div>
                                    <div class="weather">
                                        <div class="vertical-propellant-properties">
                                            
                                                <h4>Outer Diameter <input id="outerDiameter_Spinner" type="number" value="0" min="0" max="500" style="width: 80px"/> mm</h4>
                                                <input id="outerDiameter_Slider" class="balShortSlider" />

                                                <h4>Inner Diameter<input id="innerDiameter_Spinner" type="number" value="0" min="0" max="500" style="width: 80px" /> mm</h4>
                                                <input id="innerDiameter_Slider" class="balShortSlider" />

                                                <h4>Length <input id="length_Spinner" type="number" value="0" min="0" max="500" style="width: 80px" /> mm</h4>
                                                <input id="length_Slider" class="balShortSlider" />

                                        </div>
                                    </div>
                                    <div class="weather">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="weather">
                        <h2>29<span>&ordm;C</span></h2>
                        <p>Sunny weather in New York.</p>
                    </div>


                </div>
                <div id="addSectionWindow">
                    <div class="pane-content">
                        <div>
                            <h4>Diameter <input id="sectionDiameter_Spinner" type="number" value="0" min="0" max="500"  /> mm</h4>
                            <input id="sectionDiameter_Slider" class="balSlider" />

                        </div>
                        <div>
                            <h4>Length <input id="sectionLength_Spinner" type="number" value="0" min="0" max="500" /> mm</h4>
                            <input id="sectionLength_Slider" class="balSlider" />

                        </div>
                        <div>
                            <h4>Inner Port Diameter <input id="innerPortDiameter_Spinner" type="number" value="0" min="0" max="500" /> mm</h4>
                            <input id="innerPortDiameter_Slider" class="balSlider" />

                        </div>
                    </div>
                    <div class="vertical-content">

                        <a id="okNewSectionButton" class="k-primary">OK</a> 


                        <a id="cancelNewSectionButton" class="k-primary">Cancel</a> 

                    </div>
                </div>
                <div id="loadConfigWindow">
                    <input name="files" id="files" type="file" itemtype=".txt" />
                </div>
            </div>
            <script>
                $(document).ready(function () {
                    var rocketDiameterValue = 50;
                    var rocketLengthValue = 100;
                    var throatDiameterValue = 50;
                    var igniterMassValue = 10;
                    var igniterBurnTimeValue = 10;
                    var rocketX = 30;
                    var rockety = 80;
                    var sectionDiameterValue = 0;
                    var sectionLengthValue = 0;
                    var innerPortDiameterValue = 0;
                    var outerDiameterValue = 0;
                    var lengthValue = 0;
                    var innerDiameterValue = 0;
                    var section;
                    var innerPort;
                    var motor = new motorObj();
                    var selectedSection = null;
                    var SVGdraw = SVG('svgDrawing').size(500, 800);
                    $("#menu").kendoMenu({
                        select: onSelectMenu
                    });
                    $("#mainTab").kendoTabStrip({
                        animation: {
                            open: {
                                effects: "fadeIn"
                            }
                        }
                    });
                    $("#propellantTab").kendoTabStrip({
                        animation: {
                            open: {
                                effects: "fadeIn"
                            }
                        }
                    });
                    var rocketDiameterSlider = $("#rocketDiameter_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 200,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: rocketDiameterValue
                    }).data("kendoSlider");
                    var rocketLengthSlider = $("#rocketLength_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 500,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: rocketLengthValue
                    }).data("kendoSlider");
                    var throatDiameterSlider = $("#throatDiameter_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 200,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: throatDiameterValue
                    }).data("kendoSlider");
                    var igniterMassSlider = $("#igniterMass_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 500,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: igniterMassValue
                    }).data("kendoSlider");
                    var igniterBurnTimeSlider = $("#igniterBurnTime_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 500,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: igniterBurnTimeValue
                    }).data("kendoSlider");
                    var sectionDiameterSlider = $("#sectionDiameter_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 500,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: sectionDiameterValue
                    }).data("kendoSlider");
                    var sectionLengthSlider = $("#sectionLength_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 500,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: sectionLengthValue
                    }).data("kendoSlider");
                    var innerPortDiameterSlider = $("#innerPortDiameter_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 500,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: innerPortDiameterValue
                    }).data("kendoSlider");
                    var outerDiameterSlider = $("#outerDiameter_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 500,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: outerDiameterValue
                    }).data("kendoSlider");
                    var lengthSlider = $("#length_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 500,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: lengthValue
                    }).data("kendoSlider");
                    var innerDiameterSlider = $("#innerDiameter_Slider").kendoSlider({
                        increaseButtonTitle: "Right",
                        decreaseButtonTitle: "Left",
                        min: 0,
                        max: 500,
                        smallStep: 2,
                        largeStep: 1,
                        change: onSliderChange,
                        value: innerDiameterValue
                    }).data("kendoSlider");
                    var addSectionWindow = $("#addSectionWindow");
                    var loadConfigWindow = $("#loadConfigWindow");
                    
                    $("#propellantPropertiesGrid").kendoGrid({
                        dataSource: {
                            data: [],
                            schema: {
                                model: {
                                    fields: {
                                        layerId: { type: "number" },
                                        layerName: { type: "string" },
                                        layerMaterial: { type: "string" }
                                    }
                                }
                            },
                            pageSize: 10
                        },
                        height: 280,
                        pageable: {
                            refresh: true,
                            pageSizes: true,
                            buttonCount: 5
                        },
                        columns: [{
                                field: "Layer",
                                title: "Layer",
                                width: 80
                            }, {
                                field: "Name",
                                title: "Name"
                            }, {
                                field: "Material",
                                title: "Material"
                            }],
                        editable: true
                    });
                    function onSpinnerChange(obj) {
                        var objId = obj.sender.element[0].id.split("_");
                        var firstPartId = objId[0];
                        var spinner = $("#" + firstPartId + "_Spinner").data("kendoNumericTextBox");
                        var slider = $("#" + firstPartId + "_Slider").data("kendoSlider");
                        //var rocketDiameterSpinner = $("#rocketDiameter_Spinner").data("kendoNumericTextBox");

                        slider.value(spinner.value());
                        if (firstPartId == "rocketDiameter") {
                            rocketDiameterValue = spinner.value();
                            rocketLengthValue = $("#rocketLength_Spinner").data("kendoNumericTextBox").value();
                            rocketMotor.animate().size(rocketLengthValue, rocketDiameterValue).move(rocketX, rockety);
                            igniter.animate().move(rocketX, rockety + (rocketDiameterValue / 2) - 10);
                            section.animate().move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - sectionDiameterValue));
                            innerPort.animate().move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - innerPortDiameterValue));
                        } else if (firstPartId == "rocketLength") {
                            rocketLengthValue = spinner.value();
                            rocketDiameterValue = $("#rocketDiameter_Spinner").data("kendoNumericTextBox").value();
                            rocketMotor.animate().size(rocketLengthValue, rocketDiameterValue).move(rocketX, rockety);
                        }
                    }
                    function onSpinnerSpin(obj) {
                        console.log(obj.sender.element[0].id);
                        var objId = obj.sender.element[0].id.split("_");
                        var firstPartId = objId[0];
                        var spinner = $("#" + firstPartId + "_Spinner").data("kendoNumericTextBox");
                        var slider = $("#" + firstPartId + "_Slider").data("kendoSlider");
                        slider.value(spinner.value());
                        if (firstPartId == "rocketDiameter") {
                            rocketDiameterValue = spinner.value();
                            rocketLengthValue = $("#rocketLength_Spinner").data("kendoNumericTextBox").value();
                            rocketMotor.animate().size(rocketLengthValue, rocketDiameterValue).move(rocketX, rockety);
                            igniter.animate().move(rocketX, rockety + (rocketDiameterValue / 2) - 10);
                            section.animate().move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - sectionDiameterValue));
                            innerPort.animate().move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - innerPortDiameterValue));
                        } else if (firstPartId == "rocketLength") {
                            rocketLengthValue = spinner.value();
                            rocketDiameterValue = $("#rocketDiameter_Spinner").data("kendoNumericTextBox").value();
                            rocketMotor.animate().size(rocketLengthValue, rocketDiameterValue).move(rocketX, rockety);
                        }
                    }


                    function onSliderChange(obj) {
                        var objId = obj.sender.element[0].id.split("_");
                        var firstPartId = objId[0];
                        var spinner = $("#" + firstPartId + "_Spinner").data("kendoNumericTextBox");
                        var slider = $("#" + firstPartId + "_Slider").data("kendoSlider");
                        spinner.value(slider.value());
                        if (firstPartId == "rocketDiameter") {
                            rocketDiameterValue = spinner.value();
                            rocketLengthValue = $("#rocketLength_Spinner").data("kendoNumericTextBox").value();
                            rocketMotor.animate().size(rocketLengthValue, rocketDiameterValue).move(rocketX, rockety);
                            igniter.animate().move(rocketX, rockety + (rocketDiameterValue / 2) - 10);
                            section.animate().move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - sectionDiameterValue));
                            innerPort.animate().move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - innerPortDiameterValue));

                        } else if (firstPartId == "rocketLength") {
                            rocketLengthValue = spinner.value();
                            rocketDiameterValue = $("#rocketDiameter_Spinner").data("kendoNumericTextBox").value();
                            rocketMotor.animate().size(rocketLengthValue, rocketDiameterValue).move(rocketX, rockety);
                        }
                    }

                    function onAddSectionClick(e) {
                        //kendoConsole.log("event :: click (" + $(e.event.target).closest(".k-button").attr("id") + ")" );
                        addSectionWindow.data("kendoWindow").open();
                        addSectionWindow.data("kendoWindow").center();
                    }

                    function onCloseNewSectionWindowClick(e) {
                        //kendoConsole.log("event :: click (" + $(e.event.target).closest(".k-button").attr("id") + ")" );
                        addSectionWindow.data("kendoWindow").close();
                    }
                    function onOKNewSectionWindowClick(e) {
                        sectionDiameterValue = $("#sectionDiameter_Spinner").data("kendoNumericTextBox").value();
                        sectionLengthValue = $("#sectionLength_Spinner").data("kendoNumericTextBox").value();
                        innerPortDiameterValue = $("#innerPortDiameter_Spinner").data("kendoNumericTextBox").value();
                        console.log(sectionDiameterValue);
                        section = SVGdraw.rect(sectionLengthValue, sectionDiameterValue).fill({color: getRandomColor(), opacity: 0.6}).stroke({width: 1.2}).move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - sectionDiameterValue)).click(onSectionClicked);
                        innerPort = SVGdraw.rect(sectionLengthValue, innerPortDiameterValue).fill({color: getRandomColor(), opacity: 0.6}).stroke({width: 1.2}).move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - innerPortDiameterValue));
                        var newSection = new sectionObj();
                        newSection.sectionId = guid();
                        selectedSection = newSection.sectionId;
                        //motor.addSection(newSection);
                        var sectionLayers = new Array();
                        var sectionLayer = new layerObj();
                        //sectionLayers.push({Layer:1,Name:'Not set',Material:'Not set'});
                        sectionLayer.setId(1);
                        sectionLayer.setName('Not Set');
                        sectionLayer.setMaterial('Not Set');
                        sectionLayers.push(sectionLayer);
                        
                        var sectionLayer = new layerObj();
                        //sectionLayers.push({Layer:1,Name:'Not set',Material:'Not set'});
                        sectionLayer.setId(2);
                        sectionLayer.setName('Not Set');
                        sectionLayer.setMaterial('Not Set');
                        sectionLayers.push(sectionLayer);
                        
                        newSection.setLayers(sectionLayers);
                        console.log(newSection);
                        console.log(Array.prototype.slice.call(sectionLayer));
                        var grid = $("#propellantPropertiesGrid").data("kendoGrid");
                        grid.setDataSource(new kendo.data.DataSource({
                            data: Array.prototype.slice.call(sectionLayer)
                        }));
                        motor.addSection(newSection);
                        console.log(motor);
                        addSectionWindow.data("kendoWindow").close();
                    }
                    
                    function onSectionClicked() {
                        $("#elm_selected_indicator").text('Section 1 selected');
                        alert('Section 1 clicked');
                    }

                    function onSelectMenu(e) {

                        var files = e.files;
                        if ($(e.item).children(".k-link").text() == "Load Configuration") {
                            loadConfigWindow.data("kendoWindow").open();
                            loadConfigWindow.data("kendoWindow").center();
                        }
                        $.each(files, function () {
                            if (files.extension != ".txt") {
                                alert("Only .txt files can be uploaded")
                                e.preventDefault();
                                return false;
                            }
                        });
                        files.length > 5


                    }
                    $("#splitter").kendoSplitter({
                        orientation: "horizontal",
                        panes: [{size: "23%", max: "280px", min: "100px", collapsible: true}, {size: "40%"}, {max: "280px", min: "100px", collapsible: true}]
                    });
                    $("#rocketDiameter_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: rocketDiameterValue
                    });
                    $("#rocketLength_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: rocketLengthValue
                    });
                    $("#throatDiameter_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: throatDiameterValue
                    });
                    $("#igniterMass_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: igniterMassValue
                    });
                    $("#igniterBurnTime_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: igniterBurnTimeValue
                    });
                    $("#sectionDiameter_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: sectionLengthValue
                    });
                    $("#sectionLength_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: sectionLengthValue
                    });
                    $("#innerPortDiameter_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: innerPortDiameterValue
                    });
                    $("#outerDiameter_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        width: 50,
                        value: outerDiameterValue
                    });
                    $("#innerDiameter_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: innerDiameterValue
                    });
                    $("#length_Spinner").kendoNumericTextBox({
                        change: onSpinnerChange,
                        spin: onSpinnerSpin,
                        value: lengthValue
                    });
                    $("#addSectionButton").kendoButton({
                        click: onAddSectionClick
                    });
                    $("#removeSectionButton").kendoButton();
                    $("#okNewSectionButton").kendoButton({
                        click: onOKNewSectionWindowClick
                    });
                    $("#cancelNewSectionButton").kendoButton({
                        click: onCloseNewSectionWindowClick
                    });
                    $("#addPropellantPropertiesButton").kendoButton({
                        click: onAddPropellantClick
                    });
                    $("#removePropellantPropertiesButton").kendoButton({
                    });

                    $("#uploadConfig").kendoUpload();

                    var rocketMotor = SVGdraw.rect(rocketLengthValue, rocketDiameterValue).fill('#6E6E6E').stroke({width: 1.2}).move(rocketX, rockety);
                    var igniter = SVGdraw.rect(30, 20).fill('red').stroke({width: 1.2}).move(rocketX, rockety + (rocketDiameterValue / 2) - 10);
                    var nozzle = SVGdraw.polygon('30,30').fill('none').stroke({width: 1.2});
                    nozzle.plot([[rocketX + rocketLengthValue, rockety], [rocketX + rocketLengthValue + 50, rockety - 30], [rocketX + rocketLengthValue + 50, rockety + 30 + rocketDiameterValue], [rocketX + rocketLengthValue, rockety + rocketDiameterValue]]);
                    addSectionWindow.kendoWindow({
                        width: "450px",
                        height: "400px",
                        title: "New Section",
                        actions: ["Pin", "Refresh", "Maximize", "Close"],
                        modal: true,
                        visible: false

                    });
                    loadConfigWindow.kendoWindow({
                        width: "450px",
                        height: "180px",
                        title: "Load Configuration",
                        actions: ["Pin", "Refresh", "Maximize", "Close"],
                        modal: true,
                        visible: false

                    });
                    
                    function onAddPropellantClick() {
                        if(selectedSection!=null) {
                        console.log('Add layer');
                            var grid = $("#propellantPropertiesGrid").data('kendoGrid');
                            var count = grid.dataSource.total();
                            grid.dataSource.add({Layer:count+1,Name:'Not Set',Material:'Not Set'});
                            
                        } else {
                            alert('No section is selected!');
                        }
                    }
                });
            </script>
        </div>


    </body>
</html>
