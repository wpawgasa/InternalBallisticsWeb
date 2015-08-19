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

        <link href="styles/default.css" rel="stylesheet"/>
        <script src="KendoUI/js/jquery.min.js"></script>
        <script src="js/svg.min.js"></script>
        <script src="KendoUI/js/kendo.all.min.js"></script>
        <script src="js/Snap.svg-0.4.1/dist/snap.svg-min.js"></script>
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
                        <div  id="splitter" style="height: 100%; width: 100%;">
                            <div class="pane-content">
                                <div  id="splitter-horizontal" style="height: 100%; width: 100%;">
                                    <div id="top-pane">
                                        <div class="pane-content">
                                            <div>
                                                <h4>Rocket Diameter <input id="rocketDiameter_Spinner" type="number" value="0" min="0" max="500" /> mm</h4>
                                                <input id="rocketDiameter_Slider" class="balSlider" />

                                            </div>
                                            <div>
                                                <h4>Rocket Length <input id="rocketLength_Spinner" type="number" value="0" min="0" max="5000" /> mm</h4>
                                                <input id="rocketLength_Slider" class="balSlider" />

                                            </div>
                                            <div>
                                                <h4>Throat Diameter <input id="throatDiameter_Spinner" type="number" value="0" min="0" max="500" /> mm</h4>
                                                <input id="throatDiameter_Slider" class="balSlider" />

                                            </div>
                                        </div>
                                    </div>

                                    <div id="bottom-pane" style="overflow: hidden;">
                                        <div class="pane-content">
                                            <div id="graphicTab">
                                                <div id="sectionTB" width="100%"></div>
                                                <div><span id="elm_selected_indicator">No element is selected</span></div>
                                                <div style="overflow:auto;">
                                                    <svg id="svgDrawing" width="1000" height="800"></svg>
                                                </div>
                                            </div>
                                        </div>

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
                                    <div>
                                        <div id="propellantPropertiesGrid"></div>
                                        <div class="vertical-propellant-properties">
                                            <button type="button" id="addPropellantPropertiesButton">Add</button>
                                            <button type="button" id="editPropellantPropertiesButton">Edit</button>
                                            <button type="button" id="removePropellantPropertiesButton">Remove</button>

                                        </div>
                                    </div>
                                    <div>
                                        <div id="geometryTab">
                                            <ul>
                                                <li class="k-state-active">
                                                    Design Propellant
                                                </li>
                                                <li>
                                                    Load from files
                                                </li>
                                            </ul>
                                            <div>
                                                <div id="designTB"></div>
                                                <!--
                                            <div class="vertical-propellant-properties">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <h4>Outer Diameter <input id="outerDiameter_Spinner" type="number" value="0" min="0" max="500" style="width: 80px" /> mm</h4>
                                                            <input id="outerDiameter_Slider" class="balShortSlider" />
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <h4>Inner Diameter<input id="innerDiameter_Spinner" type="number" value="0" min="0" max="500" style="width: 80px" /> mm</h4>
                                                            <input id="innerDiameter_Slider" class="balShortSlider" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <h4>Length <input id="length_Spinner" type="number" value="0" min="0" max="500" style="width: 80px" /> mm</h4>
                                                            <input id="length_Slider" class="balShortSlider" />
                                                        </td>
        
                                                    </tr>
                                                </table>
                                            </div>
                                                -->
                                                <div class="vertical-propellant-properties">
                                                    <button type="button" id="circleToggleButton"></button>
                                                    <button type="button" id="eightStarToggleButton"></button>
                                                    <button type="button" id="hexagonToggleButton"></button>
                                                    <button type="button" id="pentagonToggleButton"></button>
                                                    <button type="button" id="starToggleButton"></button>
                                                    <button type="button" id="wheelToggleButton"></button>
                                                </div>
                                                <svg id="shapeDrawing" width="500" height="400" viewBox="0 0 500 400"></svg>
                                            </div>
                                            <div>
                                                <div id="loadGeom">
                                                    <input type="file" name="propellantGEOMFiles" id="propellantGEOMFiles" />
                                                </div>
                                                <a id="viewPropellantGEOMFileContent">View Burning Geometric Data</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <ul class="ul-form">
                                            <li>
                                                <input type="radio" name="geom_src" value="1" /><span>Calculate from design</span>
                                            </li>
                                            <li>
                                                <input type="radio" name="geom_src" value="2" checked="true" /><span>Calculate from selected file</span>
                                            </li>
                                            <li>

                                                <h4>Define burning distance step<input id="definedDistanceStep" type="number" value="1" min="0" max="5" step="0.1" /> mm</h4>


                                            </li>
                                            <li>
                                                <a id="generateBurningDistance">Generate Burning Distances</a>
                                            </li>
                                        </ul>
                                        <div id="generatedBurningDistanceGrid"></div>
                                    </div>

                                </div>
                            </div>
                        </div>




                    </div>
                    <div>
                        <div>
                            <h4>Simulation Parameters</h4>
                        </div>
                        <div >
                            <div style="width: 30%; height: 150px; float: left;display: block;">
                                <h4>Number of Segments: <input id="simNumSegments" type="number" value="50" min="1" max="1000" step="1" /></h4>
                                <h4>Guess Pressure: <input id="simGuessPressure" type="number" value="1000" min="50" max="10000" step="1" /> PSI </h4>
                                <h4>Specific Impulse: <input id="simISP" type="number" value="250" min="100" max="500" step="1" /></h4>
                            </div>
                            <div style="width: 60%; display: block;">
                                <h4>Igniter Mass <input id="igniterMass_Spinner" type="number" value="0" min="0" max="500" /> kg</h4>
                                <input id="igniterMass_Slider" class="balSlider" />
                                <h4>Igniter Burn Time <input id="igniterBurnTime_Spinner" type="number" value="0" min="0" max="500" /> s</h4>
                                <input id="igniterBurnTime_Slider" class="balSlider" />

                            </div>
                        </div>


                        <div style="text-align: left;">
                            <a id="simulateInCurrentTabButton">Run Simulation in Current Tab</a>
                            <a id="simulateInNewTabButton">Run Simulation in New Tab</a>
                        </div>
                        <div id="simResultTabs">
                            <ul>
                                <li class="k-state-active">Result</li>
                            </ul>
                            <div>
                                <div id="resultGraph_00000000"></div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
            <div id="addSectionWindow">

            </div>
            <div id="loadConfigWindow">
                <input name="files" id="files" type="file" itemtype=".txt" />
            </div>
            <div id="addNewSectionWindow">
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

            <div id="editSectionWindow">
                <div class="pane-content">
                    <div>
                        <h4>Diameter <input id="sectionDiameter_Spinner_edit" type="number" value="0" min="0" max="500"  /> mm</h4>
                        <input id="sectionDiameter_Slider_edit" class="balSlider" />

                    </div>
                    <div>
                        <h4>Length <input id="sectionLength_Spinner_edit" type="number" value="0" min="0" max="5000" /> mm</h4>
                        <input id="sectionLength_Slider_edit" class="balSlider" />

                    </div>
                    <div>
                        <h4>Inner Port Diameter <input id="innerPortDiameter_Spinner_edit" type="number" value="0" min="0" max="500" /> mm</h4>
                        <input id="innerPortDiameter_Slider_edit" class="balSlider" />

                    </div>
                </div>
                <div class="vertical-content">

                    <a id="okEditSectionButton" class="k-primary">OK</a> 


                    <a id="cancelEditSectionButton" class="k-primary">Cancel</a> 

                </div>
            </div>
            <div id="propellantPropertiesWindow">
                <div class="pane-content" style="width: 250px;">
                    <div>
                        <h4>Burning Rate <input id="propBurnRate" type="number" value="11" min="0" max="100" style="width: 70px;"  /> mm/s</h4>

                    </div>
                    <div>
                        <h4>Pressure Exponent <input id="propPE" type="number" value="0.48" min="0" max="5" style="width: 70px;" /> </h4>

                    </div>
                    <div>
                        <h4>Density <input id="propDensity" type="number" value="1.795" min="0" max="500" style="width: 70px;" /> *1000 kg/m^3</h4>

                    </div>
                    <div>
                        <h4>Alpha Erosive Burning Const. <input id="propAlpha" type="number" value="60" min="0" max="100" /> /10^7</h4>

                    </div>
                    <div>
                        <h4>Gas Temp. <input id="gasTemp" type="number" value="3500" min="0" max="10000" style="width: 70px;" /> K</h4>

                    </div>
                    <div>
                        <h4>Gas Const. <input id="gasConst" type="number" value="308" min="0" max="1000" style="width: 70px;" /> J/(kg*K)</h4>

                    </div>
                    <div>
                        <h4>Heat Capacity Ratio <input id="heatCap" type="number" value="1.2" min="0" max="5" style="width: 70px;" /> </h4>

                    </div>
                </div>
                <div class="vertical-content">

                    <a id="okEditLayerButton" class="k-primary">OK</a> 




                </div>
            </div>
            <div id="viewPropellantGeomWindow">
                <div class="pane-content">
                    <div id="propellantGEOMGrid">

                    </div>

                </div>

            </div>
            <span class="k-pr"></span>
            <script id="fileTemplate" type="text/x-kendo-template">



                <span class='k-progress'></span>
                <span class="file-icon k-tool-icon k-insertFile" title="icon"></span>
                <span class="k-filename" title="#=name#">#=name#</span>
                <span class="k-filename" title="#=files[0].extension#">#=files[0].extension#</span>
                <span class="k-filename" title="#=size#">#=size# bytes</span>
                <strong class="k-upload-status">
                <span class="k-upload-pct"></span>
                <button type='button' class='k-upload-action'></button>
                </strong>



            </script>
            <script>
function log(t) {
    console.log(t);
}
function adjustScreen() {
    //alert(window.innerHeight);
    $(".weather").css("height", window.innerHeight - 100 + 'px');
    $(".weather").css("width", window.innerWidth - 35 + 'px');
    $("#splitter").css("height", window.innerHeight - 110 + 'px');
    $("#splitter").css("width", window.innerWidth - 45 + 'px');

}
var waitForFinalEvent = (function () {
    var timers = {};
    return function (callback, ms, uniqueId) {
        if (!uniqueId) {
            uniqueId = "Don't call this twice without a uniqueId";
        }
        if (timers[uniqueId]) {
            clearTimeout(timers[uniqueId]);
        }
        timers[uniqueId] = setTimeout(callback, ms);
    };
})();
$(document).ready(function () {
    adjustScreen();
    $(window).on('resize', adjustScreen);
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
    //var section;
    //var innerPort;
    var motor = new motorObj();
    var selectedSection = null;
    var SVGdraw = Snap("#svgDrawing");
    //var shapeDraw = SVG('shapeDrawing').size(500, 400);
    var shapeDraw = Snap("#shapeDrawing");
    var curMouseEvent;
    var view = shapeDraw.attr("viewBox");

    var upButton = shapeDraw.circle(view.x + 50, view.y + 25, 17);
    upButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });

    var leftButton = shapeDraw.circle(view.x + 20, view.y + 60, 17);
    leftButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });

    var rightButton = shapeDraw.circle(view.x + 81, view.y + 60, 17);
    rightButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });

    var downButton = shapeDraw.circle(view.x + 50, view.y + 95, 17);
    downButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });

    var triangleUp = shapeDraw.polygon(view.x + 50, view.y + 8, view.x + 64.722, view.y + 33.5, view.x + 35.278, view.y + 33.5).attr({fill: "black"});
    var triangleLeft = triangleUp.clone();
    triangleLeft.transform("t-30 35 R270 20 60");
    var triangleRight = triangleLeft.clone();
    triangleRight.transform("t31 35 R90 81 60");
    var triangleDown = triangleLeft.clone();
    triangleDown.transform("t0 70 R180 50 95");

    var zoominButton = shapeDraw.circle(480, 25, 17);
    zoominButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });

    var zoomoutButton = shapeDraw.circle(480, 70, 17);
    zoomoutButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });
    //    var zoominText = shapeDraw.text(467, 37, "+");
    //    zoominText.attr({
    //        "font-size": "45px"
    //    });

    //    var zoomoutText = shapeDraw.text(471, 86, "-");
    //    zoomoutText.attr({
    //        "font-size": "56px"
    //    });

    var pointerButton = shapeDraw.circle(480, 115, 17);
    pointerButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });

    var lineButton = shapeDraw.circle(480, 160, 17);
    lineButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });


    var shapeButton = shapeDraw.circle(480, 205, 17);
    shapeButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });

    var delButton = shapeDraw.circle(480, 250, 17);
    delButton.attr({
        fill: "#FFFFFF",
        stroke: "#000",
        strokeWidth: 2
    });



    var selectIcon = shapeDraw.image("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABmElEQVRYR9WX8TFEMRCHv6uAEqjAqQAd0AEdnApQASpABajA6YAOqIAOmN/MhsyT9152MzfP7T83l8lmv7fZ/DaZEbMXYAksYu6/XrPgAl/AM7Af9P9xW1uAT9uCw6kyMAcE8TYVgIrvA7hbJcAmcAPoV6bKPwWU9nsb27UslOZVsQ0V4ZYF3bCV3gGNnQNnNnZkcwSX5r0C2qIqi5yCHODCgKqClSatPcCj1cRkGWhWw9YtkA5shz8faAVQ7MgaTb0gPwX/AkCSLLFSe34AVJjVEh1JXzcDpRIQgGAk1RKpXlsVQB5QAAfWvP6AjAGo6ejycZ151mSgG0g95MqrhMfWjOSXS24EoFeyhzKQdz1BnAC3nWZUKwEhAC2uCk9dTv9TdasreiwMEEl3CSwMoPOtr86z4PnyNDcMoAV0Ei4jUTOfVD/uY5gcpHJ7DRC6uhUFaUwHUsyWrRhs2bUAAtE9T5nw1oNUUH5F8wAkCM9jRAUs7eg1L4C2YsdRC7pJD3ZGL4Aeo08OgNFbsxeg+1YYY+ltQsnxGzNKUyGmWbACAAAAAElFTkSuQmCC", 466, 101, 28, 28);
    var pathIcon = shapeDraw.image("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABrElEQVRYR+2W21ECQRBFLxlgBGoEagRqBhCBZIBGgGYAEagRaAZCBEoEaASagdaxuqlma8diH87+bFfxszPTfeb27SkG6jgGHddXD9ArUFeBWcK8d1VNXQfgQtKLpLWkLys4lHQi6VLSsgoEABNJUzt4s8dhB4jFyr79lepe0qmkBQCfdpvzPYrHLWUAVVKsUA2AN5OPw4sgqyfjdhHuQ9JhQW5XwNf8LEWKLaFdKE6sAeDDtW2Mm/mO2Vgj8a3tOTIPAB49gKSo8i4JIPYDOpeEOX0vhVnnN0+ZkGQYjXUSkcQDsOeE1qNCIeA5T5vHpvbO0TIAL86tMSg3bRLkewht28lXBIjFkSjK1gQC1Wive2cLEQHY5LK3WTy2Dohv88rv5SIAfcadZy3InlILhV9t2vDHFgBnbyTxEEXDNZE9dRZTMl3HTIwrgElwMG3476AGo8okTfwdYEyYVehyhKtwAAA3f3JJclSX5C0fA4D8uJ6POYM2LAFgNBgJlMgZeGAIAO5/zNh/vyQ+uAKAhyGnASPADAAeBOSgJzkDz43q/CVrFbIH6BXoXIEfpmFdXon0m0UAAAAASUVORK5CYII=", 466, 146, 27, 27);
    var trashIcon = shapeDraw.image("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABp0lEQVRYR+2X2zEFQRRF140AESACRIAMZIAIEAEiQASEQASIABEgAkRALdVHtb4zd8xoP2rOT1dNP2af3eexe8IwWwJOgI20/QY4AJ76HjfpuwFYBe7Svoc0rqRxDbjvc+YQAHo5D2wBeq7JxHViYLkWAGleLA7z2wVwCZwWc0cJyE7DVTy3XU8TA3p2nrzs40zX2ldgN4H/WlsCCCrf0sLeQdWCQuZ0bA7YzK6OEoB3ug54j7V+HpgE8QjcZtkzBUCajOJIry5a+87roBmzEBtLBvx5LBBMTTNzXroYMIINQIEY6TXNGLCGGIhm0qc1ZYHptVfzz9lZZ8B+fnZbIYpgNGJrmEXqW/DNYsC5ADCkUjYBfh8B/AsGzGOr5FV2ybkeiM/RJfM6UiUG7HaHQN7z83YsgNAKx4Drw6oCyJtJCSCa2QhgZGBkYGTgTxiwxKpkrHYhWEM1OacpPFVTKqtcUfWuhKGKaqjjUMNTaqhNkvk9tKFAfHT+xmRtu9SCXYrI+VDIjkMVsh3UK/MR6zhlsySXm2XABlO+EX/KiG9CG5ZCtNGJD1I5pyH7tEx4AAAAAElFTkSuQmCC", 468, 237, 25, 25);
    var shapeIcon = shapeDraw.image("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABEklEQVRYR+2X4REBMRCFv6uADihBB3RAKTpAB0pQAh3QgRKUcCpg3k3WxEk4kcGP7M/LJvv2vc3cSwVsgSnhWAHLyFrXz9q/iCRvK+ACnIFjK2kMHIBJ10qRvD1gZ/kpI6BnAEKFBCwnANXyowH2CsCHzd9tTwIQkuZdUA3VQBKAr0kQ6yongGAN0bIBhm5V0+rTrkH59BrOgZk73+RQY4q6rUuuyY8xalfyVrcAKAwUBgoDhYHCQGHgLxiQIRm4H7gseO1Z9B2wftcEtvJlSOzdIUPSB+QLFCdzxT+1ZDEXlMsdPbgg122nd4EvR6oSRnuSLU8tGtqXBCCnLX8KIES1bkROADb5xk4jjVD98nl+uAJQNILTD7VUmAAAAABJRU5ErkJggg==", 470, 194, 21, 21);
    //var zoominIcon = shapeDraw.image("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACfUlEQVRYR72X4VGUQQyGXyoAKxAqQCsQKkAqACoQKwArUCoAKhAqUCoAKlAqACvQeZgNE3PJ7t6PIzM3d3y7X/bZvEl2WVPfNiR9kPRR0qaknTb9tyQ+d5Iu2/fAVT681nnrRNKxJCBGBsyRpJ+jiXE8A3gn6VwS38vahaTPkp5mX4wALPqj2PVDC7v5Zu56shCy7M5CeIBqcTT+VuhMbiATeeINiPczUfAAtyHsf1rS4Wxkh002P++swXXfNYBTSSSdGYuT9VFLInHQdEZvbxnEVpBtAcYAHoPuhC/unBIkPzDA3iRbixtBPsBKAwAdv7sZ1UsegOlZBVGygL91/nql/uyEUBJWs2z3jM0AMA+ZPjl/+5KuqhAAQPOwLKbU0N6MRf+2P6gSnPsx+03OmGQR9IskpEkNgF9u0RvXbmNkelIy5ndq0DwfAvjJHoD26rUcAfiFvM/rlmdlBAjddhv1AGQvoZuBuG/Zji8kJKpmwwj4HOAlyivr5bNJGKuKs8Hnzn+RIAdi7VZZOwsQc4dzoTwlASC7acNmVR+fAYjhj1W1kAfWJKIMWdi888pxPE+6+kNjAHF3jHHBiP0efYkYz6kSb9whfNutzpOFHLAHWd2TPOyid8EgMrTy7AKTbaIEYMCXpE1kceBop3YpYTFKl8h1D5tWAUha9gE/wGHCYnujrrPkeHlVq06qWJpLrpdOT69qvaMSbQEh8bK7n62CLOwQqb4OSElc+szLXaN7Vjtnlv08QiYW40P5+otLdiuKTLwHxHNzmgVYRoIZiJcyXwUAzqchVgUwC3G3SoAZiIdVA4wgzl4DoILgErPzWgAGQV+hjGnr/Ev39A8ZXZPQQkKeAgAAAABJRU5ErkJggg==",470,11,23,23);
    var zoominIcon = shapeDraw.image("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACYklEQVRYR72WizEEQRCG/8uACBABIkAEiICLABEgAjJwIkAETgSIABFwEVCf6lZdU/PaU3ddtbXszUx//Z6R2rIl6UgSb2RF0pc995KeJL23j8mvGFU2ovRC0nrH4VNJ43lAcgBY+BgsRv+rJKzF8hdJu+aJA0lrAfBa0lkH8N+SFAA3oxwI5Na8UHMxMHhqx/YAijeAbUoEiMpnZiXW9goQ57Z4YhDNvRHg2dz+Ye8uCxINx5Ju7BuhICRVcQCnn8fyVAHWk8AYsNEKhQN8WtwvLZ4larL923IDRTkhfwgdydk6TwCQyXd20mqDGOVI6+BTSVd2FmcWBQB32YPB1Nb3AuAFvIpsm0ey5wLgydeyigN6AVhLuCjN6rkA+KF7timSksWb4QM1j9AXYm+gX6Q5QT/Y/y+AW9EopqyVXlndHji0dhuVUddxFnijYQAB58Lf8X++d3ugK1amaUgOeG7Rlksl+1uGxPnExqrHuOTyXgC89maH0IyKsyTtA9XFA6rAjaKtV8e5d0II6VxkM3EvCYnlJZbG3PfQA7Ced9X9bHCAOERy5diqgvg745xQMlewvjrU4jT0ZGQDEENGsQPQfmnD3ivogt0AuAwIGg+bGKfF7E1cwl6Up+HDCIwpQqQ3IlxG/Xr3A4hGUos33Y6k81tUGq4qROlOSLJRmi5YAISHBWXcoGLZEnN+96tZBClC1G7FKAAEC2uCYjzAA6hP1y5P1ABiWXFnIDz+YJF7JReebogegCElGNd2QSwSAJgmxKIBmhDLAKhBTJcFUIKYLRMgBzFeNgAQ9BbKmr4x+QF2badAWiGzGQAAAABJRU5ErkJggg==", 470, 11, 23, 23);
    var zoomoutIcon = shapeDraw.image("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACWUlEQVRYR72WQS5tQRCGfztgYiTxxAKwAqzgsQKsAAsQJGKKseS9a2yAWABWwAIkWAFWQD6pkk7r013nJm4lNyehuuurv7qrekxtm5f0V9JS5vom6VLSnaTn9jZlj7HKwjVJe5L+BDa/lbQxDEgJYFzSjSQydyNLgpD1g6mB34qk6cTvWNJ2APjbJQcgKMHZHDsxFQjcZZQGpRbNgbKgRm1NESAN/m5Zkm3UgNg154FBNNemCtyb7C/2DWWQRViX9N/+RikoSdUcwOmHyTwPQPYcYBKYaZXCAV6t7vtWzxZ47f+cH0rH4WzuB0Aq20SLOEi2JenI9mLPTgPAJbuyaxWMUXVDBVTFFkyR4gIA/PA15epJRt/galb3BeDDNl611prGOZc0FQj8T9Jp5kc/oIWHAZat26X7PEqaDQAcSNrJ/PxmhQFKChxKmgwAXEviDKUWViBUqwBE7uJni7bMQe88hH4LGDj5yB0i7tcSJuiTLaYZdY5rDiET7SLi3IPG609br45z74QQ0rnOrDH1iPXDlR5A9nyr8rPSAdJuWLoNfYAY55SSuUL21aGWTkM/jCwAos8odkDaL20YQ1W6YBgAyYCYs0WM087Tm0nCWoKjZGokQTKdEPmLCMm4v0BgANFI+JaMwHQ75r6/onK/KkTXm5BTvJnshJxApNeJOqfXlpoTzJ9mISVqr2I2p55kWDMCowA/pPa+ElKiBuAb+OuX8vgPJVyVUnnCEBGAPlcw9Q1B/CYAME2I3wZoQowCoAZxOyqALoiXUQKUIDZGDQAETY4ewwEdfAK525EwRwmr7wAAAABJRU5ErkJggg==", 470, 56, 23, 23);

    var moveUpBtn = shapeDraw.group(upButton, triangleUp);
    var moveDownBtn = shapeDraw.group(downButton, triangleDown);
    var moveLeftBtn = shapeDraw.group(leftButton, triangleLeft);
    var moveRightBtn = shapeDraw.group(rightButton, triangleRight);
    var moveZoominBtn = shapeDraw.group(zoominButton, zoominIcon);
    var moveZoomoutBtn = shapeDraw.group(zoomoutButton, zoomoutIcon);
    var movePointerBtn = shapeDraw.group(pointerButton, selectIcon);
    var moveLineBtn = shapeDraw.group(lineButton, pathIcon);
    var moveShapeBtn = shapeDraw.group(shapeButton, shapeIcon);
    var moveDelBtn = shapeDraw.group(delButton, trashIcon);

    moveUpBtn.attr({opacity: 0});
    moveDownBtn.attr({opacity: 0});
    moveLeftBtn.attr({opacity: 0});
    moveRightBtn.attr({opacity: 0});
    moveZoominBtn.attr({opacity: 0});
    moveZoomoutBtn.attr({opacity: 0});
    movePointerBtn.attr({opacity: 0});
    moveLineBtn.attr({opacity: 0});
    moveShapeBtn.attr({opacity: 0});
    moveDelBtn.attr({opacity: 0});

    var verticalPanStep = 0;
    var horizontalPanStep = 0;
    var viewScale = 1;


    moveUpBtn.mouseover(function () {

        triangleUp.attr({fill: "#2E9AFE"});
        upButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'pointer'});
    });
    moveUpBtn.mouseout(function () {

        triangleUp.attr({fill: "#000"});
        upButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });
    moveUpBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);
        shapeDraw.attr({
            viewBox: vb.x + ' ' + (vb.y - 1) + ' ' + vb.w + ' ' + vb.h
        });
        //console.log(moveUpBtn);
        verticalPanStep = verticalPanStep - 1;
        var matrix = new Snap.Matrix();
        matrix.translate(horizontalPanStep, verticalPanStep);
        matrix.scale(viewScale);
        //console.log(matrix.toTransformString());
        moveUpBtn.attr({transform: matrix});
        moveDownBtn.attr({transform: matrix});
        moveLeftBtn.attr({transform: matrix});
        moveRightBtn.attr({transform: matrix});
        moveZoominBtn.attr({transform: matrix});
        moveZoomoutBtn.attr({transform: matrix});
        outRText.attr({transform: matrix});
        inRText.attr({transform: matrix});
    });

    moveDownBtn.mouseover(function () {

        triangleDown.attr({fill: "#2E9AFE"});
        downButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'pointer'});
    });
    moveDownBtn.mouseout(function () {

        triangleDown.attr({fill: "#000"});
        downButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });
    moveDownBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);
        shapeDraw.attr({
            viewBox: vb.x + ' ' + (vb.y + 1) + ' ' + vb.w + ' ' + vb.h
        });
        //console.log(moveUpBtn);
        verticalPanStep = verticalPanStep + 1;
        var matrix = new Snap.Matrix();
        matrix.translate(horizontalPanStep, verticalPanStep);
        matrix.scale(viewScale);
        //console.log(matrix.toTransformString());
        moveUpBtn.attr({transform: matrix});
        moveDownBtn.attr({transform: matrix});
        moveLeftBtn.attr({transform: matrix});
        moveRightBtn.attr({transform: matrix});
        moveZoominBtn.attr({transform: matrix});
        moveZoomoutBtn.attr({transform: matrix});
        outRText.attr({transform: matrix});
        inRText.attr({transform: matrix});
    });

    moveLeftBtn.mouseover(function () {

        triangleLeft.attr({fill: "#2E9AFE"});
        leftButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'pointer'});
    });
    moveLeftBtn.mouseout(function () {

        triangleLeft.attr({fill: "#000"});
        leftButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });
    moveLeftBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);
        shapeDraw.attr({
            viewBox: (vb.x - 1) + ' ' + vb.y + ' ' + vb.w + ' ' + vb.h
        });
        //console.log(moveUpBtn);
        horizontalPanStep = horizontalPanStep - 1;
        var matrix = new Snap.Matrix();
        matrix.translate(horizontalPanStep, verticalPanStep);
        matrix.scale(viewScale);
        //console.log(matrix.toTransformString());
        moveUpBtn.attr({transform: matrix});
        moveDownBtn.attr({transform: matrix});
        moveLeftBtn.attr({transform: matrix});
        moveRightBtn.attr({transform: matrix});
        moveZoominBtn.attr({transform: matrix});
        moveZoomoutBtn.attr({transform: matrix});
        outRText.attr({transform: matrix});
        inRText.attr({transform: matrix});
    });

    moveRightBtn.mouseover(function () {

        triangleRight.attr({fill: "#2E9AFE"});
        rightButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'pointer'});
    });
    moveRightBtn.mouseout(function () {

        triangleRight.attr({fill: "#000"});
        rightButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });

    moveRightBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);
        shapeDraw.attr({
            viewBox: (vb.x + 1) + ' ' + vb.y + ' ' + vb.w + ' ' + vb.h
        });
        //console.log(moveUpBtn);
        horizontalPanStep = horizontalPanStep + 1;
        var matrix = new Snap.Matrix();
        matrix.translate(horizontalPanStep, verticalPanStep);
        matrix.scale(viewScale);
        //console.log(matrix.toTransformString());
        moveUpBtn.attr({transform: matrix});
        moveDownBtn.attr({transform: matrix});
        moveLeftBtn.attr({transform: matrix});
        moveRightBtn.attr({transform: matrix});
        moveZoominBtn.attr({transform: matrix});
        moveZoomoutBtn.attr({transform: matrix});
        outRText.attr({transform: matrix});
        inRText.attr({transform: matrix});
    });

    moveZoominBtn.mouseover(function () {

        zoominIcon.attr({fill: "#2E9AFE"});
        zoominButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'zoom-in'});
    });
    moveZoominBtn.mouseout(function () {

        zoominIcon.attr({fill: "#000"});
        zoominButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });
    moveZoominBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);
        shapeDraw.attr({
            viewBox: vb.x + ' ' + vb.y + ' ' + vb.w * 0.99 + ' ' + vb.h * 0.99
        });
        viewScale = viewScale * 0.99;
        var matrix = new Snap.Matrix();
        matrix.translate(horizontalPanStep, verticalPanStep);
        matrix.scale(viewScale);
        //console.log(matrix.toTransformString());
        moveUpBtn.attr({transform: matrix});
        moveDownBtn.attr({transform: matrix});
        moveLeftBtn.attr({transform: matrix});
        moveRightBtn.attr({transform: matrix});
        moveZoominBtn.attr({transform: matrix});
        moveZoomoutBtn.attr({transform: matrix});
        outRText.attr({transform: matrix});
        inRText.attr({transform: matrix});

    });

    moveZoomoutBtn.mouseover(function () {

        zoomoutIcon.attr({fill: "#2E9AFE"});
        zoomoutButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'zoom-out'});
    });
    moveZoomoutBtn.mouseout(function () {

        zoomoutIcon.attr({fill: "#000"});
        zoomoutButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });
    moveZoomoutBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);
        shapeDraw.attr({
            viewBox: vb.x + ' ' + vb.y + ' ' + vb.w * 1.01 + ' ' + vb.h * 1.01
        });
        viewScale = viewScale * 1.01;
        var matrix = new Snap.Matrix();
        matrix.translate(horizontalPanStep, verticalPanStep);
        matrix.scale(viewScale);
        //console.log(matrix.toTransformString());
        moveUpBtn.attr({transform: matrix});
        moveDownBtn.attr({transform: matrix});
        moveLeftBtn.attr({transform: matrix});
        moveRightBtn.attr({transform: matrix});
        moveZoominBtn.attr({transform: matrix});
        moveZoomoutBtn.attr({transform: matrix});
        outRText.attr({transform: matrix});
        inRText.attr({transform: matrix});

    });

    movePointerBtn.mouseover(function () {

        selectIcon.attr({fill: "#2E9AFE"});
        pointerButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'zoom-out'});
    });
    movePointerBtn.mouseout(function () {

        selectIcon.attr({fill: "#000"});
        pointerButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });
    movePointerBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);


    });

    moveLineBtn.mouseover(function () {

        pathIcon.attr({fill: "#2E9AFE"});
        lineButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'zoom-out'});
    });
    moveLineBtn.mouseout(function () {

        pathIcon.attr({fill: "#000"});
        lineButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });
    moveLineBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);


    });

    moveShapeBtn.mouseover(function () {

        shapeIcon.attr({fill: "#2E9AFE"});
        shapeButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'zoom-out'});
    });
    moveShapeBtn.mouseout(function () {

        shapeIcon.attr({fill: "#000"});
        shapeButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });
    moveShapeBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);


    });

    moveDelBtn.mouseover(function () {

        trashIcon.attr({fill: "#2E9AFE"});
        delButton.attr({stroke: "#2E9AFE"});
        $("#shapeDrawing").css({'cursor': 'zoom-out'});
    });
    moveDelBtn.mouseout(function () {

        trashIcon.attr({fill: "#000"});
        delButton.attr({stroke: "#000"});
        $("#shapeDrawing").css({'cursor': 'auto'});
    });
    moveDelBtn.click(function () {
        var w = shapeDraw.attr("width");
        var h = shapeDraw.attr("height");
        var vb = shapeDraw.attr("viewBox");
        //console.log(w+","+h);
        //console.log(vb);


    });

    $("#shapeDrawing").mouseover(function () {
        //console.log("abc");
        moveUpBtn.animate({opacity: 1}, 500);
        moveDownBtn.animate({opacity: 1}, 500);
        moveLeftBtn.animate({opacity: 1}, 500);
        moveRightBtn.animate({opacity: 1}, 500);
        moveZoominBtn.animate({opacity: 1}, 500);
        moveZoomoutBtn.animate({opacity: 1}, 500);
        movePointerBtn.animate({opacity: 1}, 500);
        moveLineBtn.animate({opacity: 1}, 500);
        moveShapeBtn.animate({opacity: 1}, 500);
        moveDelBtn.animate({opacity: 1}, 500);
    });
    $("#shapeDrawing").mouseout(function () {
        //console.log("abc");
        moveUpBtn.animate({opacity: 0}, 500);
        moveDownBtn.animate({opacity: 0}, 500);
        moveLeftBtn.animate({opacity: 0}, 500);
        moveRightBtn.animate({opacity: 0}, 500);
        moveZoominBtn.animate({opacity: 0}, 500);
        moveZoomoutBtn.animate({opacity: 0}, 500);
        movePointerBtn.animate({opacity: 0}, 500);
        moveLineBtn.animate({opacity: 0}, 500);
        moveShapeBtn.animate({opacity: 0}, 500);
        moveDelBtn.animate({opacity: 0}, 500);
    });
    var outRText = shapeDraw.text(10, 350, "");
    var inRText = shapeDraw.text(10, 380, "");


    $("#menu").kendoMenu({
        select: onSelectMenu
    });
    //shapeDraw.add(tr)
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
    $("#geometryTab").kendoTabStrip({
        animation: {
            open: {
                effects: "fadeIn"
            }
        }
    });
    $("#simResultTabs").kendoTabStrip({
        animation: {
            open: {
                effects: "fadeIn"
            }
        }
    });
    $("#sectionTB").kendoToolBar({
        width: "100%",
        items: [
            {type: "button", text: "Add Section", click: onAddSectionClick},
            {type: "button", text: "Edit Section", click: onEditSectionClick},
            {type: "button", text: "Remove Section"},
            {type: "separator"}
        ]
    });
    $("#designTB").kendoToolBar({
        items: [
            {type: "button", text: "Zoom In"},
            {type: "button", text: "Zoom Out"},
            {type: "button", text: "View All"},
            {type: "separator"}
        ]
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
        max: 5000,
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
    var sectionDiameterSliderEdit = $("#sectionDiameter_Slider_edit").kendoSlider({
        increaseButtonTitle: "Right",
        decreaseButtonTitle: "Left",
        min: 0,
        max: 500,
        smallStep: 2,
        largeStep: 1,
        change: onSliderChange,
        value: sectionDiameterValue
    }).data("kendoSlider");
    var sectionLengthSliderEdit = $("#sectionLength_Slider_edit").kendoSlider({
        increaseButtonTitle: "Right",
        decreaseButtonTitle: "Left",
        min: 0,
        max: 500,
        smallStep: 2,
        largeStep: 1,
        change: onSliderChange,
        value: sectionLengthValue
    }).data("kendoSlider");
    var innerPortDiameterSliderEdit = $("#innerPortDiameter_Slider_edit").kendoSlider({
        increaseButtonTitle: "Right",
        decreaseButtonTitle: "Left",
        min: 0,
        max: 500,
        smallStep: 2,
        largeStep: 1,
        change: onSliderChange,
        value: innerPortDiameterValue
    }).data("kendoSlider");
    var addSectionWindow = $("#addNewSectionWindow");
    var editSectionWindow = $("#editSectionWindow");
    var loadConfigWindow = $("#loadConfigWindow");
    var propPropertiesWindow = $("#propellantPropertiesWindow");
    var propGeomWindow = $("#viewPropellantGeomWindow");

    addSectionWindow.kendoWindow({
        width: "450px",
        height: "400px",
        title: "New Section",
        actions: ["Pin", "Maximize", "Close"],
        modal: true,
        visible: false

    });

    editSectionWindow.kendoWindow({
        width: "450px",
        height: "400px",
        title: "Edit Section",
        actions: ["Pin", "Maximize", "Close"],
        modal: true,
        visible: false

    });

    loadConfigWindow.kendoWindow({
        width: "450px",
        height: "180px",
        title: "Load Configuration",
        actions: ["Pin", "Maximize", "Close"],
        modal: true,
        visible: false

    });

    propGeomWindow.kendoWindow({
        width: "450px",
        height: "180px",
        title: "Propellant Geometry",
        actions: ["Pin", "Maximize", "Close"],
        modal: true,
        visible: false

    });

    propPropertiesWindow.kendoWindow({
        width: "450px",
        height: "400px",
        title: "Edit Propellant Properties",
        actions: ["Pin", "Maximize", "Close"],
        modal: true,
        visible: false

    });

    $("#propellantPropertiesGrid").kendoGrid({
        dataSource: {
            data: [],
            schema: {
                model: {
                    fields: {
                        layerId: {type: "number"},
                        layerName: {type: "string"},
                        layerMaterial: {type: "string"}
                    }
                }
            },
            pageSize: 10
        },
        selectable: "row",
        height: 280,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [{
                field: "layerId",
                title: "Layer",
                width: 80
            }, {
                field: "layerName",
                title: "Name"
            }, {
                field: "layerMaterial",
                title: "Material"
            }],
        editable: true
    });
    $("#propellantGEOMGrid").kendoGrid({
        dataSource: {
            data: [],
            schema: {
                model: {
                    fields: {
                        distance: {type: "number"},
                        port_area: {type: "string"},
                        perimeter: {type: "string"}
                    }
                }
            },
            pageSize: 10
        },
        height: 280,
        pageable: {
            refresh: false,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [{
                field: "distance",
                title: "Burn Distance",
                width: 100
            }, {
                field: "port_area",
                title: "Port Area"
            }, {
                field: "perimeter",
                title: "Perimeter"
            }],
        editable: false
    });
    $("#generatedBurningDistanceGrid").kendoGrid({
        dataSource: {
            data: [],
            schema: {
                model: {
                    fields: {
                        distance: {type: "number"},
                        port_area: {type: "string"},
                        perimeter: {type: "string"}
                    }
                }
            },
            pageSize: 10
        },
        height: 280,
        pageable: {
            refresh: false,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [{
                field: "distance",
                title: "Burn Distance",
                width: 100
            }, {
                field: "port_area",
                title: "Port Area"
            }, {
                field: "perimeter",
                title: "Perimeter"
            }],
        editable: true
    });

    $("#propellantGEOMFiles").kendoUpload({
        async: {
            saveUrl: "FileUploadHandler?action=save",
            removeUrl: "FileUploadHandler?action=remove"
        },
        success: onUploadSuccess,
        error: onUploadError,
        progress: onUploadProgress,
        select: onUploadSelect,
        template: kendo.template($('#fileTemplate').html())
    });
    //                        var uploadGEOMFile = $("#propellantGEOMFiles").data("kendoUpload");
    //                        uploadGEOMFile._onFileProgress = function(t,n) {
    //                            console.log(n);
    //                        }
    function onUploadSelect(e) {
        $.each(e.files, function (index, value) {
            if (value.extension != '.csv' &&
                    value.extension != '.xls' &&
                    value.extension != '.dat' &&
                    value.extension != '.xlsx' &&
                    value.extension != '.txt' &&
                    value.extension != '.pdf') {
                alert("File " + value.name + " is not a valid file type.");
                e.preventDefault();
            }
        });
    }
    function onUploadProgress(e) {
        var files = e.files;
        for (var i = 0; i < files.length; i++) {
            $("li[data-uid='" + files[0].uid + "'] span.k-upload-pct").text(e.percentComplete + '%');
        }
    }
    function onUploadSuccess(e) {
        // Array with information about the uploaded files
        var files = e.files;

        if (e.operation == "upload") {
            if (e.response.msg_status == true) {
                for (var i = 0; i < files.length; i++) {
                    //console.log(files[i]);
                    //$("#loadGEOM").prepend('<input type="radio" name="engine" id="engine4" class="k-radio">');
                    var target = $("li[data-uid='" + files[0].uid + "']");
                    var radioBtn = $('<input type="radio" name="selectedGeomFile" value="' + files[0].name + '" />');
                    radioBtn.prependTo(target);
                    $("li[data-uid='" + files[0].uid + "'] span.k-progress").css('visibility', 'hidden');
                    $("li[data-uid='" + files[0].uid + "'] span.k-upload-pct").html('<span class="k-icon k-i-tick"></span>');
                    $("li[data-uid='" + files[0].uid + "'] span.k-filename").css('color', '#000000');
                    //.prepend('<input type="radio" name="engine" id="engine3" class="k-radio">');
                }
                //alert("Successfully uploaded " + files.length + " files");
            } else {
                alert("Failed to upload: " + e.response.msg_content);
                // $("#propellantGEOMFiles").data("kendoUpload").trigger("error");
            }
        } else {
            if (e.response.msg_status == true) {
                //alert("Successfully removed " + files.length + " files");
            } else {
                alert("Failed to remove: " + e.response.msg_content);
            }
        }
    }
    function onUploadError(e) {
        // Array with information about the uploaded files
        var files = e.files;
        console.log(e);
        if (e.operation == "upload") {
            if (e.XMLHttpRequest.response != null) {
                var obj = JSON.parse(e.XMLHttpRequest.response);
                alert("Failed to upload " + files.length + " files. " + obj.msg_content);
            } else {
                alert("Failed to upload " + files.length + " files ");

            }
        }
    }
    function onSpinnerChange(obj) {

        var objId = obj.sender.element[0].id.split("_");
        var firstPartId = objId[0];
        //console.log(firstPartId);
        var spinner = $("#" + firstPartId + "_Spinner").data("kendoNumericTextBox");
        var slider = $("#" + firstPartId + "_Slider").data("kendoSlider");
        slider.value(spinner.value());
        if (firstPartId == "rocketDiameter") {
            var oldRocketDiameter = rocketDiameterValue;
            rocketDiameterValue = spinner.value();
            motor.motorDiameter = rocketDiameterValue;
            rocketLengthValue = $("#rocketLength_Spinner").data("kendoNumericTextBox").value();

            rocketMotor.animate({"height": rocketDiameterValue}, 200);
            igniter.animate({"y": rockety + (rocketDiameterValue / 2) - 10}, 200);
            //console.log(nozzle.attr("points"));
            var nozzlePoints = nozzle.attr("points");
            //console.log(nozzlePoints);
            for (var i = 0; i < nozzlePoints.length; i++) {
                nozzlePoints[i] = parseInt(nozzlePoints[i]);
                nozzlePoints[i + 1] = parseInt(nozzlePoints[i + 1]) + (rocketDiameterValue - oldRocketDiameter) / 2;
                i++;
            }
            //console.log(nozzlePoints);

            nozzle.attr({"points": nozzlePoints});
            var motorSections = motor.getSections();
            for (var i = 0; i < motorSections.length; i++) {
                var sectionId = motorSections[i].sectionId;
                var section = SVGdraw.select('rect[id=section_' + sectionId + ']');
                var innerPort = SVGdraw.select('rect[id=section_inner_' + sectionId + ']');
                section.animate({"y": rockety + 0.5 * Math.abs(rocketDiameterValue - sectionDiameterValue)}, 200);
                innerPort.animate({"y": rockety + 0.5 * Math.abs(rocketDiameterValue - innerPortDiameterValue)}, 200);
            }

        }
        if (firstPartId == "rocketLength") {
            var oldRocketLength = rocketLengthValue;
            rocketLengthValue = spinner.value();
            motor.motorLength = rocketLengthValue;

            rocketMotor.animate({"width": rocketLengthValue}, 200);
            var nozzlePoints = nozzle.attr("points");
            //console.log(nozzlePoints);
            for (var i = 0; i < nozzlePoints.length; i++) {
                nozzlePoints[i + 1] = parseInt(nozzlePoints[i + 1]);
                nozzlePoints[i] = parseInt(nozzlePoints[i]) + (rocketLengthValue - oldRocketLength);
                i++;
            }
            nozzle.attr({"points": nozzlePoints});
        }
        if (firstPartId == "throatDiameter") {
            throatDiameterValue = spinner.value();
            motor.throatDiameter = throatDiameterValue;

            //rocketMotor.animate({"width":rocketLengthValue},200);
            var nozzlePoints = nozzle.attr("points");
            var oldThroatDiameter = parseInt(nozzlePoints[7]) - parseInt(nozzlePoints[1]);
            //console.log(nozzlePoints);

            nozzlePoints[1] = parseInt(nozzlePoints[1]) - (throatDiameterValue - oldThroatDiameter) / 2;
            nozzlePoints[7] = parseInt(nozzlePoints[7]) + (throatDiameterValue - oldThroatDiameter) / 2;

            nozzle.attr({"points": nozzlePoints});
        }
    }
    function onSpinnerSpin(obj) {
        var objId = obj.sender.element[0].id.split("_");
        var firstPartId = objId[0];
        var spinner = $("#" + firstPartId + "_Spinner").data("kendoNumericTextBox");
        var slider = $("#" + firstPartId + "_Slider").data("kendoSlider");
        slider.value(spinner.value());

    }


    function onSliderChange(obj) {
        var objId = obj.sender.element[0].id.split("_");
        var firstPartId = objId[0];
        var spinner = $("#" + firstPartId + "_Spinner").data("kendoNumericTextBox");
        var slider = $("#" + firstPartId + "_Slider").data("kendoSlider");
        spinner.value(slider.value());
        if (firstPartId == "rocketDiameter") {
            var oldRocketDiameter = rocketDiameterValue
            rocketDiameterValue = spinner.value();
            rocketLengthValue = $("#rocketLength_Spinner").data("kendoNumericTextBox").value();
            //var oldRocketDiameter = rocketMotor.attr("height");
            rocketMotor.animate({"height": rocketDiameterValue}, 200);
            igniter.animate({"y": rockety + (rocketDiameterValue / 2) - 10}, 200);
            //console.log(nozzle.attr("points"));
            var nozzlePoints = nozzle.attr("points");
            //console.log(nozzlePoints);
            for (var i = 0; i < nozzlePoints.length; i++) {
                nozzlePoints[i] = parseInt(nozzlePoints[i]);
                nozzlePoints[i + 1] = parseInt(nozzlePoints[i + 1]) + (rocketDiameterValue - oldRocketDiameter) / 2;
                i++;
            }
            //console.log(nozzlePoints);

            nozzle.attr({"points": nozzlePoints});
            var motorSections = motor.getSections();
            for (var i = 0; i < motorSections.length; i++) {
                var sectionId = motorSections[i].sectionId;
                var section = SVGdraw.select('rect[id=section_' + sectionId + ']');
                var innerPort = SVGdraw.select('rect[id=section_inner_' + sectionId + ']');
                section.animate({"y": rockety + 0.5 * Math.abs(rocketDiameterValue - sectionDiameterValue)}, 200);
                innerPort.animate({"y": rockety + 0.5 * Math.abs(rocketDiameterValue - innerPortDiameterValue)}, 200);
            }

        }
        if (firstPartId == "rocketLength") {
            var oldRocketLength = rocketLengthValue
            rocketLengthValue = spinner.value();
            rocketDiameterValue = $("#rocketDiameter_Spinner").data("kendoNumericTextBox").value();
            var oldRocketLength = rocketMotor.attr("width");
            rocketMotor.animate({"width": rocketLengthValue}, 200);
            var nozzlePoints = nozzle.attr("points");
            //console.log(nozzlePoints);
            for (var i = 0; i < nozzlePoints.length; i++) {
                nozzlePoints[i + 1] = parseInt(nozzlePoints[i + 1]);
                nozzlePoints[i] = parseInt(nozzlePoints[i]) + (rocketLengthValue - oldRocketLength);
                i++;
            }
            nozzle.attr({"points": nozzlePoints});
        }
        if (firstPartId == "throatDiameter") {
            throatDiameterValue = spinner.value();
            motor.throatDiameter = throatDiameterValue;

            //rocketMotor.animate({"width":rocketLengthValue},200);
            var nozzlePoints = nozzle.attr("points");
            var oldThroatDiameter = parseInt(nozzlePoints[7]) - parseInt(nozzlePoints[1]);
            //console.log(nozzlePoints);

            nozzlePoints[1] = parseInt(nozzlePoints[1]) - (throatDiameterValue - oldThroatDiameter) / 2;
            nozzlePoints[7] = parseInt(nozzlePoints[7]) + (throatDiameterValue - oldThroatDiameter) / 2;

            nozzle.attr({"points": nozzlePoints});
        }
    }

    function onCircleButtonClick(e) {
        //var circlePropellant = shapeDraw.circle(30).fill('none').stroke({width: 1.2}).move(50, 50);



        Snap.load("svg_templates/DTICircle.svg", function (f) {
            // Note that we traversre and change attr before SVG
            // is even added to the page
            //f.select("g[id='ID_0']");
            var s = shapeDraw.select("g[id='draft']");
            if (s != null) {
                s.remove();
            }
            var g = f.select("g[id='draft']");


            var outer_circle = g.select("circle[id='ID_8E0']");
            var inner_circle = g.select("circle[id='ID_Inner']");
            var posX = outer_circle.attr("cx");
            var posY = outer_circle.attr("cy");
            var r = outer_circle.attr("r");
            var r_inner = inner_circle.attr("r");

            var translateX = posX * 143.95 / r - 250;
            var translateY = 200 - (-1) * posY * 143.95 / r;
            g.transform("matrix(" + (1) * 143.95 / r + " 0 0 " + (-1) * 143.95 / r + " " + (-1) * translateX + " " + translateY + ")");
            g.attr("strokeWidth", 2);
            outer_circle.attr("stroke", "#000");
            //outer_circle.attr("fill","#fff");
            shapeDraw.append(g);
            outRText.attr({text: "Outer Radius: " + r});
            inRText.attr({text: "Inner Radius: " + r_inner});
            var mouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newr = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                outer_circle.attr({r: newr});
                outRText.attr({text: 'Outer Radius: ' + newr});
            }
            var dragStart = function (x, y) {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";

            }
            var dragStop = function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            outer_circle.drag(mouseMove, dragStart, dragStop);
            outer_circle.mousedown(function () {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            outer_circle.mouseup(function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            outer_circle.mouseover(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3});
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            outer_circle.mouseout(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });



            var innerMouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newr = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                inner_circle.attr({r: newr});
                inRText.attr({text: 'Inner Radius: ' + newr});
            }
            var innerDragStart = function (x, y) {
                inner_circle.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";
            }
            var innerDragStop = function () {
                inner_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            inner_circle.drag(innerMouseMove, innerDragStart, innerDragStop);
            inner_circle.mousedown(function () {
                inner_circle.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });

            inner_circle.mouseover(function () {
                if (curMouseEvent != "drag") {
                    inner_circle.attr({stroke: "#00FF80", strokeWidth: 3});
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            inner_circle.mouseout(function () {
                if (curMouseEvent != "drag" && curMouseEvent != "dblclick") {
                    inner_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });




            // Making croc draggable. Go ahead drag it around!
            //g.drag();
            // Obviously drag could take event handlers too
            // Looks like our croc is made from more than one polygon...\

        });



    }

    function onEightStarButtonClick(e) {
        //var circlePropellant = shapeDraw.circle(30).fill('none').stroke({width: 1.2}).move(50, 50);



        Snap.load("svg_templates/DTIEightStar.svg", function (f) {
            // Note that we traversre and change attr before SVG
            // is even added to the page
            //f.select("g[id='ID_0']");
            var s = shapeDraw.select("g[id='draft']");
            if (s != null) {
                s.remove();
            }
            var g = f.select("g[id='draft']");

            var outer_circle = g.select("circle[id='ID_8E0']");
            var paths = g.selectAll("path");
            var inner_g = g.g();
            inner_g.attr({fill: 'none'});
            //console.log(paths);
            for (var i = 0; i < paths.length; i++) {
                var tmp_path = paths[i].clone();
                inner_g.add(tmp_path);
                paths[i].remove();
            }
            //console.log(inner_g);
            var posX = outer_circle.attr("cx");
            var posY = outer_circle.attr("cy");
            var r = outer_circle.attr("r");
            var translateX = posX * 143.95 / r - 250;
            var translateY = 200 - (-1) * posY * 143.95 / r;
            g.transform("matrix(" + (1) * 143.95 / r + " 0 0 " + (-1) * 143.95 / r + " " + (-1) * translateX + " " + translateY + ")");
            g.attr("strokeWidth", 2);
            outer_circle.attr("stroke", "#000");
            shapeDraw.append(g);

            outRText.attr({text: "Outer Radius: " + r});

            var mouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newr = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                outer_circle.attr({r: newr * r / 143.95});
                outRText.attr({text: 'Outer Radius: ' + newr});
            }
            var dragStart = function (x, y) {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";

            }
            var dragStop = function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            outer_circle.drag(mouseMove, dragStart, dragStop);
            outer_circle.mousedown(function () {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            outer_circle.mouseup(function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            outer_circle.mouseover(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3});
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            outer_circle.mouseout(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });

            var dragStartRadius = 0;
            var innerMouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                var scaleRatio = newRadius / dragStartRadius;
                inner_g.transform('S' + scaleRatio + ',' + scaleRatio + ',' + posX + ',' + posY);
                inRText.attr({text: 'Inner Radius: ' + newr});
            }
            var innerDragStart = function (x, y) {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});
                dragStartRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";
            }
            var innerDragStop = function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            inner_g.drag(innerMouseMove, innerDragStart, innerDragStop);
            inner_g.mousedown(function () {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                }
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            inner_g.mouseup(function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#000", strokeWidth: 2});
                }
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            inner_g.mouseover(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#00FF80", strokeWidth: 3});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                    }
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            inner_g.mouseout(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#000", strokeWidth: 2});
                    }
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });
            // Making croc draggable. Go ahead drag it around!
            //g.drag();
            // Obviously drag could take event handlers too
            // Looks like our croc is made from more than one polygon...
        });

    }

    function onHexagonButtonClick(e) {
        //var circlePropellant = shapeDraw.circle(30).fill('none').stroke({width: 1.2}).move(50, 50);



        Snap.load("svg_templates/DTIHexagon.svg", function (f) {
            // Note that we traversre and change attr before SVG
            // is even added to the page
            //f.select("g[id='ID_0']");
            var s = shapeDraw.select("g[id='draft']");
            if (s != null) {
                s.remove();
            }
            var g = f.select("g[id='draft']");

            //var outer_circle = g.select("circle[id='ID_8E0']");
            var outer_circle = g.select("circle[id='ID_8E0']");
            var paths = g.selectAll("path");
            var inner_g = g.g();
            inner_g.attr({fill: 'none'});
            //console.log(paths);
            for (var i = 0; i < paths.length; i++) {
                var tmp_path = paths[i].clone();
                inner_g.add(tmp_path);
                paths[i].remove();
            }
            //console.log(inner_g);
            var posX = outer_circle.attr("cx");
            var posY = outer_circle.attr("cy");
            var r = outer_circle.attr("r");
            var translateX = posX * 143.95 / r - 250;
            var translateY = 200 - (-1) * posY * 143.95 / r;
            g.transform("matrix(" + (1) * 143.95 / r + " 0 0 " + (-1) * 143.95 / r + " " + (-1) * translateX + " " + translateY + ")");
            g.attr("strokeWidth", 2);
            outer_circle.attr("stroke", "#000");
            shapeDraw.append(g);

            outRText.attr({text: "Outer Radius: " + r});

            var mouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newr = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                outer_circle.attr({r: newr * r / 143.95});
                outRText.attr({text: 'Outer Radius: ' + newr});
            }
            var dragStart = function (x, y) {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";

            }
            var dragStop = function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            outer_circle.drag(mouseMove, dragStart, dragStop);
            outer_circle.mousedown(function () {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            outer_circle.mouseup(function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            outer_circle.mouseover(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3});
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            outer_circle.mouseout(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });

            var dragStartRadius = 0;
            var innerMouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                var scaleRatio = newRadius / dragStartRadius;
                inner_g.transform('S' + scaleRatio + ',' + scaleRatio + ',' + posX + ',' + posY);
                inRText.attr({text: 'Inner Radius: ' + newr});
            }
            var innerDragStart = function (x, y) {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});
                dragStartRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";
            }
            var innerDragStop = function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            inner_g.drag(innerMouseMove, innerDragStart, innerDragStop);
            inner_g.mousedown(function () {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                }
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            inner_g.mouseup(function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#000", strokeWidth: 2});
                }
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            inner_g.mouseover(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#00FF80", strokeWidth: 3});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                    }
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            inner_g.mouseout(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#000", strokeWidth: 2});
                    }
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });
            // Making croc draggable. Go ahead drag it around!
            //g.drag();
            // Obviously drag could take event handlers too
            // Looks like our croc is made from more than one polygon...
        });

    }

    function onPentagonButtonClick(e) {
        //var circlePropellant = shapeDraw.circle(30).fill('none').stroke({width: 1.2}).move(50, 50);



        Snap.load("svg_templates/DTIPentagon.svg", function (f) {
            // Note that we traversre and change attr before SVG
            // is even added to the page
            //f.select("g[id='ID_0']");
            var s = shapeDraw.select("g[id='draft']");
            if (s != null) {
                s.remove();
            }
            var g = f.select("g[id='draft']");

            var outer_circle = g.select("circle[id='ID_8E0']");
            var paths = g.selectAll("path");
            var inner_g = g.g();
            inner_g.attr({fill: 'none'});
            //console.log(paths);
            for (var i = 0; i < paths.length; i++) {
                var tmp_path = paths[i].clone();
                inner_g.add(tmp_path);
                paths[i].remove();
            }
            //console.log(inner_g);
            var posX = outer_circle.attr("cx");
            var posY = outer_circle.attr("cy");
            var r = outer_circle.attr("r");
            var translateX = posX * 143.95 / r - 250;
            var translateY = 200 - (-1) * posY * 143.95 / r;
            g.transform("matrix(" + (1) * 143.95 / r + " 0 0 " + (-1) * 143.95 / r + " " + (-1) * translateX + " " + translateY + ")");
            g.attr("strokeWidth", 2);
            outer_circle.attr("stroke", "#000");
            shapeDraw.append(g);

            outRText.attr({text: "Outer Radius: " + r});

            var mouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newr = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                outer_circle.attr({r: newr * r / 143.95});
                outRText.attr({text: 'Outer Radius: ' + newr});
            }
            var dragStart = function (x, y) {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";

            }
            var dragStop = function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            outer_circle.drag(mouseMove, dragStart, dragStop);
            outer_circle.mousedown(function () {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            outer_circle.mouseup(function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            outer_circle.mouseover(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3});
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            outer_circle.mouseout(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });

            var dragStartRadius = 0;
            var innerMouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                var scaleRatio = newRadius / dragStartRadius;
                inner_g.transform('S' + scaleRatio + ',' + scaleRatio + ',' + posX + ',' + posY);
                inRText.attr({text: 'Inner Radius: ' + newr});
            }
            var innerDragStart = function (x, y) {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});
                dragStartRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";
            }
            var innerDragStop = function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            inner_g.drag(innerMouseMove, innerDragStart, innerDragStop);
            inner_g.mousedown(function () {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                }
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            inner_g.mouseup(function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#000", strokeWidth: 2});
                }
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            inner_g.mouseover(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#00FF80", strokeWidth: 3});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                    }
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            inner_g.mouseout(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#000", strokeWidth: 2});
                    }
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });
            // Making croc draggable. Go ahead drag it around!
            //g.drag();
            // Obviously drag could take event handlers too
            // Looks like our croc is made from more than one polygon...
        });

    }

    function onStarButtonClick(e) {
        //var circlePropellant = shapeDraw.circle(30).fill('none').stroke({width: 1.2}).move(50, 50);



        Snap.load("svg_templates/DTIStar.svg", function (f) {
            // Note that we traversre and change attr before SVG
            // is even added to the page
            //f.select("g[id='ID_0']");
            var s = shapeDraw.select("g[id='draft']");
            if (s != null) {
                s.remove();
            }
            var g = f.select("g[id='draft']");

            var outer_circle = g.select("circle[id='ID_8E0']");
            var paths = g.selectAll("path");
            var inner_g = g.g();
            inner_g.attr({fill: 'none'});
            //console.log(paths);
            for (var i = 0; i < paths.length; i++) {
                var tmp_path = paths[i].clone();
                inner_g.add(tmp_path);
                paths[i].remove();
            }
            //console.log(inner_g);
            var posX = outer_circle.attr("cx");
            var posY = outer_circle.attr("cy");
            var r = outer_circle.attr("r");
            var translateX = posX * 143.95 / r - 250;
            var translateY = 200 - (-1) * posY * 143.95 / r;
            g.transform("matrix(" + (1) * 143.95 / r + " 0 0 " + (-1) * 143.95 / r + " " + (-1) * translateX + " " + translateY + ")");
            g.attr("strokeWidth", 2);
            outer_circle.attr("stroke", "#000");
            shapeDraw.append(g);

            outRText.attr({text: "Outer Radius: " + r});

            var mouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newr = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                outer_circle.attr({r: newr * r / 143.95});
                outRText.attr({text: 'Outer Radius: ' + newr});
            }
            var dragStart = function (x, y) {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";

            }
            var dragStop = function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            outer_circle.drag(mouseMove, dragStart, dragStop);
            outer_circle.mousedown(function () {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            outer_circle.mouseup(function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            outer_circle.mouseover(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3});
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            outer_circle.mouseout(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });

            var dragStartRadius = 0;
            var innerMouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                var scaleRatio = newRadius / dragStartRadius;
                inner_g.transform('S' + scaleRatio + ',' + scaleRatio + ',' + posX + ',' + posY);
                inRText.attr({text: 'Inner Radius: ' + newr});
            }
            var innerDragStart = function (x, y) {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});
                dragStartRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";
            }
            var innerDragStop = function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            inner_g.drag(innerMouseMove, innerDragStart, innerDragStop);
            inner_g.mousedown(function () {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                }
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            inner_g.mouseup(function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#000", strokeWidth: 2});
                }
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            inner_g.mouseover(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#00FF80", strokeWidth: 3});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                    }
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            inner_g.mouseout(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#000", strokeWidth: 2});
                    }
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });
            // Making croc draggable. Go ahead drag it around!
            //g.drag();
            // Obviously drag could take event handlers too
            // Looks like our croc is made from more than one polygon...
        });

    }

    function onWheelButtonClick(e) {
        //var circlePropellant = shapeDraw.circle(30).fill('none').stroke({width: 1.2}).move(50, 50);



        Snap.load("svg_templates/DTIWheel.svg", function (f) {
            // Note that we traversre and change attr before SVG
            // is even added to the page
            //f.select("g[id='ID_0']");
            var s = shapeDraw.select("g[id='draft']");
            if (s != null) {
                s.remove();
            }
            var g = f.select("g[id='draft']");

            var outer_circle = g.select("circle[id='ID_8E0']");
            var paths = g.selectAll("path");
            var inner_g = g.g();
            inner_g.attr({fill: 'none'});
            //console.log(paths);
            for (var i = 0; i < paths.length; i++) {
                var tmp_path = paths[i].clone();
                inner_g.add(tmp_path);
                paths[i].remove();
            }
            //console.log(inner_g);
            var posX = outer_circle.attr("cx");
            var posY = outer_circle.attr("cy");
            var r = outer_circle.attr("r");
            var translateX = posX * 143.95 / r - 250;
            var translateY = 200 - (-1) * posY * 143.95 / r;
            g.transform("matrix(" + (1) * 143.95 / r + " 0 0 " + (-1) * 143.95 / r + " " + (-1) * translateX + " " + translateY + ")");
            g.attr("strokeWidth", 2);
            outer_circle.attr("stroke", "#000");
            shapeDraw.append(g);

            outRText.attr({text: "Outer Radius: " + r});

            var mouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newr = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                outer_circle.attr({r: newr * r / 143.95});
                outRText.attr({text: 'Outer Radius: ' + newr});
            }
            var dragStart = function (x, y) {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";

            }
            var dragStop = function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            outer_circle.drag(mouseMove, dragStart, dragStop);
            outer_circle.mousedown(function () {
                outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3, strokeDasharray: "5 5"});
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#2E9AFE", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            outer_circle.mouseup(function () {
                outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            outer_circle.mouseover(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#2E9AFE", strokeWidth: 3});
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            outer_circle.mouseout(function () {
                if (curMouseEvent != "drag") {
                    outer_circle.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });

            var dragStartRadius = 0;
            var innerMouseMove = function (dx, dy, x, y) {
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());

                var newRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                //console.log(cx-(tPT.x)+", "+cy-(tPT.y));
                var scaleRatio = newRadius / dragStartRadius;
                inner_g.transform('S' + scaleRatio + ',' + scaleRatio + ',' + posX + ',' + posY);
                inRText.attr({text: 'Inner Radius: ' + newr});
            }
            var innerDragStart = function (x, y) {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var cx = posX * (1) * (143.95 / r) + (-1) * translateX;
                var cy = posY * (-1) * (143.95 / r) + (1) * translateY;
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});
                dragStartRadius = Math.sqrt(Math.pow(cx - (tPT.x), 2) + Math.pow(cy - (tPT.y), 2));
                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
                curMouseEvent = "drag";
            }
            var innerDragStop = function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
                curMouseEvent = "";
            }
            inner_g.drag(innerMouseMove, innerDragStart, innerDragStop);
            inner_g.mousedown(function () {
                inner_g.attr({stroke: "#00FF80", strokeWidth: 3, strokeDasharray: "5 5"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                }
                var pt = shapeDraw.paper.node.createSVGPoint();
                pt.x = x;
                pt.y = y;
                //console.log(pt);
                var tPT = pt.matrixTransform(shapeDraw.paper.node.getScreenCTM().inverse());
                //console.log(tPT);
                var line = shapeDraw.line(posX * (1) * (143.95 / r) + (-1) * translateX, posY * (-1) * (143.95 / r) + (1) * translateY, tPT.x, tPT.y).attr({id: "radiusLine", stroke: "#00FF80", strokeWidth: 2, strokeDasharray: "5 5", opacity: 1});

                $("#shapeDrawing").css({'cursor': 'nwse-resize'});
            });
            inner_g.mouseup(function () {
                inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                var paths = inner_g.selectAll("path");

                for (var i = 0; i < paths.length; i++) {
                    paths[i].attr({stroke: "#000", strokeWidth: 2});
                }
                $("#shapeDrawing").css({'cursor': 'auto'});
                var line = shapeDraw.select("line[id='radiusLine']");
                if (line != null) {
                    line.remove();
                }
            });
            inner_g.mouseover(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#00FF80", strokeWidth: 3});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#00FF80", strokeWidth: 3});
                    }
                    $("#shapeDrawing").css({'cursor': 'pointer'});
                    //curMouseEvent = "over";
                }

            });
            inner_g.mouseout(function () {
                if (curMouseEvent != "drag") {
                    inner_g.attr({stroke: "#000", strokeWidth: 2, strokeDasharray: "0 0"});
                    var paths = inner_g.selectAll("path");

                    for (var i = 0; i < paths.length; i++) {
                        paths[i].attr({stroke: "#000", strokeWidth: 2});
                    }
                    $("#shapeDrawing").css({'cursor': 'auto'});
                    var line = shapeDraw.select("line[id='radiusLine']");
                    if (line != null) {
                        line.remove();
                    }
                }
                //curMouseEvent = "over";
                //console.log("over");
            });
            // Making croc draggable. Go ahead drag it around!
            //g.drag();
            // Obviously drag could take event handlers too
            // Looks like our croc is made from more than one polygon...
        });

    }

    function onCloseNewSectionWindowClick(e) {
        //kendoConsole.log("event :: click (" + $(e.event.target).closest(".k-button").attr("id") + ")" );
        addSectionWindow.data("kendoWindow").close();
    }
    function onCloseEditSectionWindowClick(e) {
        //kendoConsole.log("event :: click (" + $(e.event.target).closest(".k-button").attr("id") + ")" );
        editSectionWindow.data("kendoWindow").close();
    }
    //                        function onOKNewSectionWindowClick(e) {
    //                            sectionDiameterValue = $("#sectionDiameter_Spinner").data("kendoNumericTextBox").value();
    //                            sectionLengthValue = $("#sectionLength_Spinner").data("kendoNumericTextBox").value();
    //                            innerPortDiameterValue = $("#innerPortDiameter_Spinner").data("kendoNumericTextBox").value();
    //                            console.log(sectionDiameterValue);
    //                            section = SVGdraw.rect(sectionLengthValue, sectionDiameterValue).fill({color: getRandomColor(), opacity: 0.6}).stroke({width: 1.2}).move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - sectionDiameterValue)).click(onSectionClicked);
    //                            innerPort = SVGdraw.rect(sectionLengthValue, innerPortDiameterValue).fill({color: getRandomColor(), opacity: 0.6}).stroke({width: 1.2}).move(rocketX, rockety + 0.5 * Math.abs(rocketDiameterValue - innerPortDiameterValue));
    //                            var newSection = new sectionObj();
    //                            newSection.sectionId = guid();
    //                            selectedSection = newSection.sectionId;
    //                            //motor.addSection(newSection);
    //                            var sectionLayers = new Array();
    //                            var sectionLayer = new layerObj();
    //                            //sectionLayers.push({Layer:1,Name:'Not set',Material:'Not set'});
    //                            sectionLayer.setId(1);
    //                            sectionLayer.setName('Not Set');
    //                            sectionLayer.setMaterial('Not Set');
    //                            sectionLayers.push(sectionLayer);
    //
    //                            var sectionLayer = new layerObj();
    //                            //sectionLayers.push({Layer:1,Name:'Not set',Material:'Not set'});
    //                            sectionLayer.setId(2);
    //                            sectionLayer.setName('Not Set');
    //                            sectionLayer.setMaterial('Not Set');
    //                            sectionLayers.push(sectionLayer);
    //
    //                            newSection.setLayers(sectionLayers);
    //                            console.log(newSection);
    //                            console.log(Array.prototype.slice.call(sectionLayer));
    //                            var grid = $("#propellantPropertiesGrid").data("kendoGrid");
    //                            grid.setDataSource(new kendo.data.DataSource({
    //                                data: Array.prototype.slice.call(sectionLayer)
    //                            }));
    //                            motor.addSection(newSection);
    //                            console.log(motor);
    //                            addSectionWindow.data("kendoWindow").close();
    //                        }


    //                        function onSectionClicked() {
    //                            $("#elm_selected_indicator").text('Section 1 selected');
    //                            alert('Section 1 clicked');
    //
    //                    }


    function onAddSectionClick(e) {
        //kendoConsole.log("event :: click (" + $(e.event.target).closest(".k-button").attr("id") + ")" );

        addSectionWindow.data("kendoWindow").open();
        addSectionWindow.data("kendoWindow").center();
    }

    function onEditSectionClick(e) {
        //kendoConsole.log("event :: click (" + $(e.event.target).closest(".k-button").attr("id") + ")" );
        if (selectedSection != null) {
            var sectionDiameterSpinnerEdit = $("#sectionDiameter_Spinner_edit").data("kendoNumericTextBox");
            //var sectionDiameterSpinnerEditValue = sectionDiameterSpinnerEdit.value();
            sectionDiameterSpinnerEdit.value(selectedSection.sectionOuterDiameter);
            
            var sectionDiameterSliderEdit = $("#sectionDiameter_Slider_edit").data("kendoSlider");
            //var sectionDiameterSliderEditValue = sectionDiameterSliderEdit.value();
            sectionDiameterSliderEdit.value(selectedSection.sectionOuterDiameter);
            
            var sectionLengthSpinnerEdit = $("#sectionLength_Spinner_edit").data("kendoNumericTextBox");
            sectionLengthSpinnerEdit.value(selectedSection.sectionLength);
            
            var sectionLengthSliderEdit = $("#sectionLength_Slider_edit").data("kendoSlider");
            sectionLengthSliderEdit.value(selectedSection.sectionLength);
            
            var innerPortDiameterSpinnerEdit = $("#innerPortDiameter_Spinner_edit").data("kendoNumericTextBox");
            innerPortDiameterSpinnerEdit.value(selectedSection.sectionInnerDiameter);
            
            var innerPortDiameterSliderEdit = $("#innerPortDiameter_Slider_edit").data("kendoSlider");
            innerPortDiameterSliderEdit.value(selectedSection.sectionInnerDiameter);

            editSectionWindow.data("kendoWindow").open();
            editSectionWindow.data("kendoWindow").center();


        } else {
            alert("No section is selected");
        }
    }

    //                    function onCloseNewSectionWindowClick(e) {
    //                        //kendoConsole.log("event :: click (" + $(e.event.target).closest(".k-button").attr("id") + ")" );
    //                        addSectionWindow.data("kendoWindow").close();
    //                    }
    function onOKNewSectionWindowClick(e) {
        sectionDiameterValue = $("#sectionDiameter_Spinner").data("kendoNumericTextBox").value();
        sectionLengthValue = $("#sectionLength_Spinner").data("kendoNumericTextBox").value();
        innerPortDiameterValue = $("#innerPortDiameter_Spinner").data("kendoNumericTextBox").value();

        if (sectionDiameterValue != 0 && sectionLengthValue != 0 && innerPortDiameterValue != 0 && innerPortDiameterValue < sectionDiameterValue) {
            var circleBtn = $("#circleToggleButton").data("kendoButton");
            circleBtn.enable(true);
            var eightStarBtn = $("#eightStarToggleButton").data("kendoButton");
            eightStarBtn.enable(true);
            var hexagonBtn = $("#hexagonToggleButton").data("kendoButton");
            hexagonBtn.enable(true);
            var pentagonBtn = $("#pentagonToggleButton").data("kendoButton");
            pentagonBtn.enable(true);
            var starBtn = $("#starToggleButton").data("kendoButton");
            starBtn.enable(true);
            var wheelBtn = $("#wheelToggleButton").data("kendoButton");
            wheelBtn.enable(true);

            var motorSections = motor.getSections();
            var totalLen = 0;
            for (var i = 0; i < motorSections.length; i++) {

                totalLen = totalLen + motorSections[i].sectionLength;
            }
            //console.log(sectionDiameterValue+","+sectionLengthValue);
            var newSection = new sectionObj();
            newSection.sectionId = guid();
            newSection.sectionLength = sectionLengthValue;
            newSection.sectionOuterDiameter = sectionDiameterValue;
            newSection.sectionInnerDiameter = innerPortDiameterValue;

            var section = SVGdraw.rect(rocketX + totalLen, rockety + 0.5 * Math.abs(rocketDiameterValue - sectionDiameterValue), sectionLengthValue, sectionDiameterValue).attr({id: 'section_' + newSection.sectionId, fill: getRandomColor(), opacity: 0.6, stroke: '#000', strokeWidth: 1});
            var innerPort = SVGdraw.rect(rocketX + totalLen, rockety + 0.5 * Math.abs(rocketDiameterValue - innerPortDiameterValue), sectionLengthValue, innerPortDiameterValue).attr({id: 'section_inner_' + newSection.sectionId, fill: getRandomColor(), opacity: 0.6, stroke: 'none', strokeWidth: 1});
            var sectionG = SVGdraw.group(section, innerPort);
            sectionG.attr({id: 'G_' + newSection.sectionId});
            jQuery.data(sectionG, "id", newSection.sectionId);
            jQuery.data(sectionG, "massColor", section.attr("fill"));
            jQuery.data(sectionG, "innerColor", innerPort.attr("fill"));
            jQuery.data(sectionG, "selected", false);
            //newSection.sectionGraphicObj = section;
            //newSection.innerPortGraphicObj = innerPort;
            //motor.addSection(newSection);
            var sectionLayers = new Array();
            var sectionLayer = new layerObj();
            //sectionLayers.push({Layer:1,Name:'Not set',Material:'Not set'});
            sectionLayer.setId(1);
            sectionLayer.setName('Not Set');
            sectionLayer.setMaterial('Not Set');
            sectionLayer.layerMaxBurningDistance = (sectionDiameterValue - innerPortDiameterValue) / 2;
            sectionLayers.push(sectionLayer);

            newSection.setLayers(sectionLayers);
            //console.log(newSection);

            //            selectedSection = newSection;
            //            var grid = $("#propellantPropertiesGrid").data("kendoGrid");
            //            grid.setDataSource(new kendo.data.DataSource({
            //                data: Array.prototype.slice.call(sectionLayer)
            //            }));
            motor.addSection(newSection);
            console.log(motor);
            jQuery.data(sectionG, "prop", newSection);
            console.log(section);
            addSectionWindow.data("kendoWindow").close();
            $('#' + sectionG.attr("id")).click({section: sectionG}, onSectionClicked);
            //$('#section_'+newSection.sectionId).trigger('click');

        }




    }

    function onOKEditSectionWindowClick(e) {
        var sectionDiameterValue = $("#sectionDiameter_Spinner_edit").data("kendoNumericTextBox").value();
        var sectionLengthValue = $("#sectionLength_Spinner_edit").data("kendoNumericTextBox").value();
        var innerPortDiameterValue = $("#innerPortDiameter_Spinner_edit").data("kendoNumericTextBox").value();
        selectedSection.sectionOuterDiameter = sectionDiameterValue;
        selectedSection.sectionInnerDiameter = innerPortDiameterValue;
        selectedSection.sectionLength = sectionLengthValue;

        if (sectionDiameterValue != 0 && sectionLengthValue != 0 && innerPortDiameterValue != 0 && innerPortDiameterValue < sectionDiameterValue) {

            var motorSections = motor.getSections();
            
            for (var i = 0; i < motorSections.length; i++) {
                var section = motorSections[i];
                if(section.sectionId==selectedSection.sectionId) {
                    motor.setSection(selectedSection,selectedSection.sectionId);
                }
            }
            editSectionWindow.data("kendoWindow").close();
        } else {
            alert("Invalid parameters");
        }




    }

    function onSectionClicked(e) {
        //console.log(e.data.section);

        //alert('Section ' + section.sectionId + ' clicked');
        var svgSection = e.data.section;
        jQuery.data(svgSection, "selected", true);
        $("#elm_selected_indicator").text('Section ' + jQuery.data(svgSection, "id") + ' selected');
        var pt = SVGdraw.circle(1.5, 1.5, 1).attr({
            fill: jQuery.data(svgSection, "massColor"),
            stroke: "none"
        });
        pt = pt.pattern(0, 0, 3, 3);

        var pt2 = SVGdraw.path(0, 0, 3, 3).attr({
            fill: "none",
            stroke: jQuery.data(svgSection, "innerColor")
        });
        pt2 = pt2.pattern(0, 0, 3, 3);
        console.log(motor);
        var motorSections = motor.getSections();
        for (var i = 0; i < motorSections.length; i++) {
            var section = motorSections[i];
            if (section.sectionId != jQuery.data(svgSection, "id")) {
                var sectionG = SVGdraw.select('g[id=G_' + section.sectionId + ']');
                sectionG.select('rect[id=section_' + jQuery.data(sectionG, "id") + ']').attr({fill: jQuery.data(sectionG, "massColor"), stroke: "#000"});
                sectionG.select('rect[id=section_inner_' + jQuery.data(sectionG, "id") + ']').attr({fill: jQuery.data(sectionG, "innerColor"), stroke: "none"});
                jQuery.data(sectionG, "selected", false);
            } else {
                selectedSection = section;
            }
        }

        svgSection.select('rect[id=section_' + jQuery.data(svgSection, "id") + ']').attr({fill: pt, stroke: jQuery.data(svgSection, "massColor")});
        svgSection.select('rect[id=section_inner_' + jQuery.data(svgSection, "id") + ']').attr({fill: jQuery.data(svgSection, "innerColor"), stroke: jQuery.data(svgSection, "innerColor")});

        var grid = $("#propellantPropertiesGrid").data('kendoGrid');
        var array = selectedSection.getLayers();
        //var arrString = JSON.stringify(array);
        //console.log(array);
        //console.log(Array.prototype.slice.call(array));
        var dataSource = new kendo.data.DataSource({
            data: array,
            change: function (e) {
                //console.log(e);
                //console.log(e.items[0].layerId);
                //console.log(this.data());

                var layer = e.items[0];
                //console.log(layer);
                //console.log(layer.layerId);
                if (e.action == 'add') {
                    selectedSection.addLayer(layer);
                }
                if (e.action == 'itemchange') {
                    selectedSection.setLayer(layer);
                }
                motor.setSection(selectedSection, selectedSection.sectionId);
                console.log(selectedSection);
                console.log(motor);
                //selectedSection.setLayers(layers);
            }
        });
        grid.setDataSource(dataSource);


        //var layerGrid = $("#propellantPropertiesGrid").data("kendoGrid");


    }

    function onAddPropellantClick() {
        //console.log(selectedSection);
        if (selectedSection.getId() != null && selectedSection.getId() != "") {

            //console.log('Add layer');
            var grid = $("#propellantPropertiesGrid").data('kendoGrid');
            var count = grid.dataSource.total();
            //grid.dataSource.add({layerId: count + 1, layerName: 'Not Set', layerMaterial: 'Not Set'});
            var sectionLayer = new layerObj();
            sectionLayer.setId(count + 1);
            sectionLayer.setName('Not Set');
            sectionLayer.setMaterial('Not Set');
            sectionLayer.layerMaxBurningDistance = (selectedSection.sectionOuterDiameter - selectedSection.sectionInnerDiameter) / 2;
            grid.dataSource.add(sectionLayer);
            //selectedSection.getLayers().push(sectionLayer);
            //motor.setSection(selectedSection,selectedSection.sectionId);
        } else {
            alert('No section is selected!');
        }
    }

    function onEditPropellantClick() {
        if (selectedSection != null) {
            //console.log('Add layer');
            var grid = $("#propellantPropertiesGrid").data('kendoGrid');
            var selectedItem = grid.dataItem(grid.select());

            var selectedLayer = selectedSection.getLayer(selectedItem.layerId);
            console.log(selectedSection);
            console.log(selectedItem);
            console.log(selectedLayer);
            $("#propBurnRate").val(selectedLayer.layerBurningRate);
            $("#propPE").val(selectedLayer.layerPressureExponent);
            $("#propDensity").val(selectedLayer.layerDensity);
            $("#propAlpha").val(selectedLayer.layerAlpErosive);
            $("#gasTemp").val(selectedLayer.layerGasTemp);
            $("#gasConst").val(selectedLayer.layerGasConst);
            $("#heatCap").val(selectedLayer.layerHeatCapacity);
            propPropertiesWindow.data("kendoWindow").open();
            propPropertiesWindow.data("kendoWindow").center();
        } else {
            alert('No section is selected!');
        }
    }

    function onOKEditLayerClick() {
        if (selectedSection != null) {
            //console.log('Add layer');
            var grid = $("#propellantPropertiesGrid").data('kendoGrid');
            var selectedItem = grid.dataItem(grid.select());

            var selectedLayer = selectedSection.getLayer(selectedItem.layerId);
            //console.log(selectedSection);
            //console.log(selectedItem);
            selectedLayer.layerBurningRate = $("#propBurnRate").val();
            selectedLayer.layerPressureExponent = $("#propPE").val();
            selectedLayer.layerDensity = $("#propDensity").val();
            selectedLayer.layerAlpErosive = $("#propAlpha").val();
            selectedLayer.layerGasTemp = $("#gasTemp").val();
            selectedLayer.layerGasConst = $("#gasConst").val();
            selectedLayer.layerHeatCapacity = $("#heatCap").val();
            motor.setSection(selectedSection, selectedSection.sectionId);
            console.log(selectedLayer);
            propPropertiesWindow.data("kendoWindow").close();
        } else {
            alert('No section is selected!');
        }
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
        panes: [{size: "50%", max: "1200px", min: "200px", collapsible: true},
            {size: "400px"}, {size: "35%", max: "600px", min: "300px", collapsible: true}]
    });
    $("#splitter-horizontal").kendoSplitter({
        orientation: "vertical",
        panes: [
            {size: "42%", collapsible: true},
            {collapsible: false}
        ]
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
    $("#sectionDiameter_Spinner_edit").kendoNumericTextBox({
        change: onSpinnerChange,
        spin: onSpinnerSpin,
        value: sectionLengthValue
    });
    $("#sectionLength_Spinner_edit").kendoNumericTextBox({
        change: onSpinnerChange,
        spin: onSpinnerSpin,
        value: sectionLengthValue
    });
    $("#innerPortDiameter_Spinner_edit").kendoNumericTextBox({
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
    $("#okEditSectionButton").kendoButton({
        click: onOKEditSectionWindowClick
    });
    $("#cancelEditSectionButton").kendoButton({
        click: onCloseEditSectionWindowClick
    });
    $("#addPropellantPropertiesButton").kendoButton({
        click: onAddPropellantClick
    });
    $("#editPropellantPropertiesButton").kendoButton({
        click: onEditPropellantClick
    });
    $("#okEditLayerButton").kendoButton({
        click: onOKEditLayerClick
    });
    $("#removePropellantPropertiesButton").kendoButton({
    });

    $("#uploadConfig").kendoUpload();

    $("#circleToggleButton").kendoButton({
        imageUrl: "/InternalBallisticsWeb/styles/icon/DTICircleIcon.png",
        click: onCircleButtonClick,
        enable: false
    });
    $("#eightStarToggleButton").kendoButton({
        imageUrl: "/InternalBallisticsWeb/styles/icon/DTIEightStarIcon.png",
        click: onEightStarButtonClick,
        enable: false
    });
    $("#hexagonToggleButton").kendoButton({
        imageUrl: "/InternalBallisticsWeb/styles/icon/DTIHexagonIcon.png",
        click: onHexagonButtonClick,
        enable: false
    });
    $("#pentagonToggleButton").kendoButton({
        imageUrl: "/InternalBallisticsWeb/styles/icon/DTIPentagonIcon.png",
        click: onPentagonButtonClick,
        enable: false
    });
    $("#starToggleButton").kendoButton({
        imageUrl: "/InternalBallisticsWeb/styles/icon/DTIStarIcon.png",
        click: onStarButtonClick,
        enable: false
    });
    $("#wheelToggleButton").kendoButton({
        imageUrl: "/InternalBallisticsWeb/styles/icon/DTIWheelIcon.png",
        click: onWheelButtonClick,
        enable: false
    });
    $("#viewPropellantGEOMFileContent").kendoButton({
        click: function () {
            var selectedFile = $('input[name=selectedGeomFile]:checked').val();
            if (selectedFile != null) {
                $.ajax({
                    url: 'ExtractPropellantGEOMFromFile',
                    data: {fileNames: selectedFile},
                    success: onExtractGeomSuccess,
                    dataType: 'json'
                });
            }
        }
    });
    $("#generateBurningDistance").kendoButton({
        click: function () {
            var selectedGeomSrc = $('input[name=geom_src]:checked').val();
            var selectedFile = $('input[name=selectedGeomFile]:checked').val();
            if (selectedGeomSrc == 2) {
                if (selectedFile != null) {
                    $.ajax({
                        url: 'ExtractPropellantGEOMFromFile',
                        data: {fileNames: selectedFile, computed: 'true', step: $('#definedDistanceStep').val()},
                        success: onExtractAndGenerateGeomSuccess,
                        dataType: 'json'
                    });
                }
            } else {

            }
        }
    });
    $("#simulateInCurrentTabButton").kendoButton({
        click: function () {
            console.log(JSON.stringify(motor));
            $.ajax({
                url: 'CalculateThrust',
                method: 'post',
                data: {motor: JSON.stringify(motor), numSegments: $('#simNumSegments').val(), Pg: $('#simGuessPressure').val(), Isp: $('#simISP').val()},
                success: onCalculationCompleted,
                dataType: 'json'
            });
        }
    });
    $("#simulateInNewTabButton").kendoButton({
        click: function () {

        }
    });
    function onExtractAndGenerateGeomSuccess(data) {
        //console.log(data);
        //generatedBurningDistanceGrid
        var grid = $("#generatedBurningDistanceGrid").data("kendoGrid");
        var dataObj = JSON.parse(data.msg_content);
        //var dataObj = JSON.parse(data.msg_content);
        var dataSource = new kendo.data.DataSource({
            data: dataObj.generatedGeom,
            schema: {
                model: {
                    fields: {
                        distance: {type: "number"},
                        port_area: {type: "number"},
                        perimeter: {type: "number"}
                    }
                }
            },
            pageSize: 10
        });
        grid.setDataSource(dataSource);

        var motorSections = motor.getSections();
        for (var i = 0; i < motorSections.length; i++) {
            //var section = motorSections[i];
            if (motorSections[i].sectionId == selectedSection.sectionId) {
                motorSections[i].generatedGeom = dataObj.generatedGeom;
            }
        }
    }

    function onExtractGeomSuccess(data) {
        //console.log(data);
        var window = $("#viewPropellantGeomWindow").data("kendoWindow");
        var grid = $("#propellantGEOMGrid").data("kendoGrid");
        var dataObj = JSON.parse(data.msg_content);
        var dataSource = new kendo.data.DataSource({
            data: dataObj.geom,
            schema: {
                model: {
                    fields: {
                        distance: {type: "number"},
                        port_area: {type: "number"},
                        perimeter: {type: "number"}
                    }
                }
            },
            pageSize: 10
        });
        grid.setDataSource(dataSource);
        window.center();
        window.open();
    }

    function onCalculationCompleted(data) {
        //console.log(data.toString());
        var chart = $("#resultGraph_00000000").data("kendoChart");
        var dataSource = new kendo.data.DataSource({
            data: data,
            schema: {
                model: {
                    fields: {
                        pressure: {type: "number"},
                        thrust: {type: "number"},
                        time: {type: "number"}
                    }
                }
            },
            sort: {
                field: "time",
                dir: "asc"
            }
        });
        chart.setDataSource(dataSource);
    }

    var rocketMotor = SVGdraw.rect(rocketX, rockety, rocketLengthValue, rocketDiameterValue).attr({id: 'motorCase', fill: 'none', strokeWidth: 1, stroke: '#000'});
    var igniter = SVGdraw.rect(rocketX, rockety + (rocketDiameterValue / 2) - 10, 30, 20).attr({id: 'igniter', fill: 'red', strokeWidth: 1, stroke: '#000'});
    var nozzle = SVGdraw.polygon(rocketX + rocketLengthValue, rockety, rocketX + rocketLengthValue + 50, rockety - 30, rocketX + rocketLengthValue + 50, rockety + 30 + rocketDiameterValue, rocketX + rocketLengthValue, rockety + rocketDiameterValue).attr({id: 'nozzle', fill: 'none', strokeWidth: 1, stroke: '#000'});
    //nozzle.plot([[rocketX + rocketLengthValue, rockety], [rocketX + rocketLengthValue + 50, rockety - 30], [rocketX + rocketLengthValue + 50, rockety + 30 + rocketDiameterValue], [rocketX + rocketLengthValue, rockety + rocketDiameterValue]]);

    $("#resultGraph_00000000").kendoChart({
        title: {
            text: "Output Pressure"
        },
        legend: {
            visible: true
        },
        series: [{
                field: "pressure",
                name: "Pressure",
                type: "line",
                style: "smooth",
                markers: {
                    visible: false
                }
            }],
        categoryAxis: {
            field: "time",
            labels: {
                visible: true,
                step: 100,
                format: "{0:n3}"
            },
            title: {
                text: "time (s)"
            },
            majorGridLines: {
                visible: true,
                step: 10
            },
            majorTicks: {
                visible: false
            }
        },
        valueAxis: {
            title: {
                text: "Pressure (N/m^2)"
            },
            majorGridLines: {
                visible: true
            },
            visible: true
        },
        tooltip: {
            visible: true,
            shared: true,
            format: "{0:n5}"
        }
    });


});
            </script>



    </body>
</html>
