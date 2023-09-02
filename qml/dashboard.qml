import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root
    visible: true                                                               
    //visibility: "FullScreen"
    width: 1280
    height: 400
    title: qsTr("Tesla dashboard")

    property bool parkVisible: true
    property bool driveVisible: false

    ValueSource {
        id: valueSource
    }

    Rectangle{
        id:leftScreen
        anchors{
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        width: parent.width/3.25
        color:"white"

        Text{
            id:temperature
            anchors{
                left:parent.left
                leftMargin: 20
                top:parent.top
                topMargin: 20
            }
            font.pixelSize: 20
            font.bold: false

            color:"black"
            text:"16°C"

        }

        Image{
            id:carTopviewIcon
            anchors.centerIn:parent
            height:parent.height*.8
            fillMode: Image.PreserveAspectFit
            source:"file:/home/seame-workstation07/Downloads/car_upview.png"
        }

        Text{
            id:time
            anchors{
                right:parent.right
                rightMargin: 20
                top:parent.top
                topMargin: 20
            }
            font.pixelSize: 20
            font.bold: false

            color:"black"
            text:"12:00 PM"
        }

        Text{
            id:lefttopPsi
            anchors{
                right:carTopviewIcon.left
                top:carTopviewIcon.top
                topMargin: 80
            }
            font.pixelSize: 20
            font.bold: false
            color:"black"
            text:"46 Psi"
        }

        Text{
            id:righttopPsi
            anchors{
                left:carTopviewIcon.right
                top:carTopviewIcon.top
                topMargin: 80
            }
            font.pixelSize: 20
            font.bold: false
            color:"black"
            text:"46 Psi"
        }
        Text{
            id:leftbottomPsi
            anchors{
                right:carTopviewIcon.left
                bottom:carTopviewIcon.bottom
                bottomMargin: 80
            }
            font.pixelSize: 20
            font.bold: false
            color:"black"
            text:"46 Psi"
        }
        Text{
            id:rightbottomPsi
            anchors{
                left:carTopviewIcon.right
                bottom:carTopviewIcon.bottom
                bottomMargin: 80
            }
            font.pixelSize: 20
            font.bold: false
            color:"black"
            text:"46 Psi"
        }
    }

    Rectangle{
        id:centerScreen

        anchors{
            left: leftScreen.right
            top: parent.top
            bottom: parent.bottom
        }
        width: parent.width/2.5
        color:"#d6d6d6"

        Rectangle { //bar
            width: parent.width * .85
            anchors{
                top: centerScreen.top
                topMargin: 90
            }
            anchors.horizontalCenter: parent.horizontalCenter

            height: 2
            color: "black"
        }

        Text{
            id:gear
            anchors{
                top: centerScreen.top
                topMargin: 100
            }
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 30
            font.bold: false
            color:"black"
            text:"P R N D"
        }

        Rectangle{
            id:gear_light_D
            x:gear.x + gear.width - 23 //x_center-x_gap*1.5
            visible: driveVisible
            width:25
            height:30
            radius:3

            SequentialAnimation on color {
                ColorAnimation { from: "#e6e6e6"; to: "#4d9ff7"; duration: 1500 }
            }
            opacity:1
            anchors{
                top: centerScreen.top
                topMargin: 102
            }
        }
        Text {
            id:gear_d
            x:gear.x + gear.width - 23
            visible: driveVisible
            SequentialAnimation on color {
                ColorAnimation { from: "#000000"; to: "#ffffff"; duration: 1500 }
            }
            anchors{
                top: centerScreen.top
                topMargin: 100
            }
            font.pixelSize: 30
            font.bold: false
            text:"D"
        }

        Rectangle{
            id:gear_light_P
            x:gear.x - 3
            visible: parkVisible
            width:25
            height:30
            radius:3
            SequentialAnimation on color {
            ColorAnimation { from: "#e6e6e6"; to: "#ff9090"; duration: 1500 }
            }
            opacity:1
            anchors{
                top: centerScreen.top
                topMargin: 102
            }
        }
        Text{
            id:gear_p
            x:gear.x
            color:"blue"
            visible: parkVisible
            SequentialAnimation on color {
                ColorAnimation { from: "#000000"; to: "#000000"; duration: 1500 }
            }
            anchors{
                top: centerScreen.top
                topMargin: 100
            }
            font.pixelSize: 30
            font.bold: false
            text:"P"
        }

        Item{ //park mode
            anchors.fill:centerScreen
            Text{
                id:gearPark
                visible: parkVisible
                anchors{
                    top: parent.top
                    topMargin: 30
                }
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 50
                font.bold: false
                color:"black"
                text:"P"
            }

            Image{
                id:carparkIcon
                visible:parkVisible
                anchors{
                    top: parent.top
                    topMargin: 150
                }
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width*.8
                fillMode: Image.PreserveAspectFit
                source:"file:/home/seame-workstation07/Downloads/car_park.png"
            }
        }

        Item{ //drive mode
            anchors.fill:centerScreen
            Text{
                id:speed
                visible: driveVisible
                anchors{
                    top: parent.top
                    topMargin: 0
                }
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 60
                font.bold: false
                color:"black"
                text: valueSource.kph
            }
            Text{
                id:cmpersec
                visible: driveVisible
                anchors{
                    top: speed.bottom
                    topMargin: -10
                }
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                font.bold: false
                color:"black"
                text:"CMPS"
            }

            Canvas {
                visible: driveVisible
                width: centerScreen.width
                height: centerScreen.height

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.strokeStyle = "#737373";
                    ctx.lineWidth = 2;

                    // Starting point of the line
                    var startLX = 220;
                    var startLY = 180;

                    var startRX = 300;
                    var startRY = 180;

                    // Ending point of the line
                    var endLX = 170;
                    var endLY = 330;

                    var endRX = 340;
                    var endRY = 330;

                    ctx.beginPath();
                    ctx.moveTo(startRX, startRY);
                    ctx.lineTo(endRX, endRY);
                    ctx.stroke();

                    ctx.beginPath();
                    ctx.moveTo(startLX, startLY);
                    ctx.lineTo(endLX, endLY);
                    ctx.stroke();

                }
                
                Image{
                    id:tree_r
                    x:x_center-400 //x_center-x_gap*1.5
                    y:15
                    visible: driveVisible
                    width:parent.width*.07
                    height:parent.width*.07
                    source:"file:/home/seame-workstation07/Downloads/3Dtree.png"
                    NumberAnimation on x{
                        loops: Animation.Infinite
                        from: 300; to:380; duration:1500-valueSource.kph*10;
                    }

                    NumberAnimation on y{
                        loops: Animation.Infinite
                        from: 150; to:350; duration:1500-valueSource.kph*10;
                    }
                    PropertyAnimation on width {
                        loops: Animation.Infinite
                        from: tree_l.width
                        to: tree_l.width * 1.8
                        duration: 1500
                    }

                    PropertyAnimation on height {
                        loops: Animation.Infinite
                        from: tree_l.height
                        to: tree_l.height * 1.8
                        duration: 1500
                    }
                }

                Image{
                    id:tree_l
                    x:x_center-400 //x_center-x_gap*1.5
                    y:15
                    visible: driveVisible
                    width:450 *.07
                    height:450 *.07
                    source:"file:/home/seame-workstation07/Downloads/3dtree.png"
                    NumberAnimation on x{
                        loops: Animation.Infinite
                        from: 190; to:110; duration: 1500-valueSource.kph*10;
                    }
                    NumberAnimation on y{
                        loops: Animation.Infinite
                        from: 150; to:350; duration: 1500-valueSource.kph*10;
                    }
                    PropertyAnimation on width {
                        loops: Animation.Infinite
                        from: tree_l.width
                        to: tree_l.width * 1.8
                        duration: 1500
                    }

                    PropertyAnimation on height {
                        loops: Animation.Infinite
                        from: tree_l.height
                        to: tree_l.height * 1.8
                        duration: 1500
                    }
                }

            }

            Image{
                id:cardriveIcon
                visible:driveVisible
                anchors{
                    top: parent.top
                    topMargin: 50
                }
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width
                fillMode: Image.PreserveAspectFit

                source:"file:/home/seame-workstation07/Downloads/car_back.png"
            }
        }

        Text{
            id:odoCM
            anchors{
                left: centerScreen.left
                leftMargin: 20
                bottom: centerScreen.bottom
                bottomMargin: 20
            }
            font.pixelSize: 20
            font.bold: false
            color:center_color //black
            text:valueSource.odo+"m"
        }

        Text{
            id:tripCM
            anchors{
                right: centerScreen.right
                rightMargin: 20
                bottom: centerScreen.bottom
                bottomMargin: 20
            }
            font.pixelSize: 20
            font.bold: false
            color:"black"
            text:"TRIP 100 cm"
        }
    }


    Rectangle{
        id:rightScreen
        property real batteryPercentage: 0.75 // Set battery percentage between 0 and 1

        anchors{
            left: centerScreen.right
            top: parent.top
            bottom: parent.bottom
        }
        width: parent.width/3.25
        color: side //white

        Image{
            id:batterycarIcon
            anchors.centerIn: parent
            width:parent.width
            fillMode: Image.PreserveAspectFit
            opacity: 0.7
            source:"file:/home/seame-workstation07/Downloads/tesla_frame.png"
        }

        Image{
            id:batteryIcon
            opacity: 0.7
            visible: false
            anchors.centerIn: parent
            width:parent.width
            fillMode: Image.PreserveAspectFit
            source:"file:/home/seame-workstation07/Downloads/battery.png"
        }

        ProgressBar{
            id:progressBar
            width : parent.width * 0.3

            height:parent.height * 0.2
            anchors.centerIn: parent
            value : valueSource.fuel / 100
            rotation:0
            background: Rectangle {
                color: "#e6e6e6"
                radius: 7
            }

            contentItem: Item {
                Rectangle {
                    width: progressBar.visualPosition * parent.width
                    height: parent.height
                    radius: 7
                    color: "#17a81a"

                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            SequentialAnimation on color {
                                loops: Animation.Infinite
                                ColorAnimation { from: "#10ff2c"; to: "#a0ff00"; duration: 3000 }
                                ColorAnimation { from: "#a0ff00"; to: "#10ff2c"; duration: 3000 }
                            }
                        }
                    }
                }
            }
        }

        Text {
            anchors.centerIn: progressBar
            text:valueSource.fuel + "%"
            font.pixelSize: 20
            color: black
        }

        Text {
            anchors{
                top:progressBar.bottom
                topMargin: 50
            }

            anchors.horizontalCenter: parent.horizontalCenter
            text: valueSource.travelableDis +"M"
            font.pixelSize: 25
            color: black
        }
    }
}
