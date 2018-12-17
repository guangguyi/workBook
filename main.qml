import QtQuick 2.10
import QtCharts 2.0
import QtQuick.Controls 2.2

Item {
    id: root
    width: 1280
    height: 720

    property in: horslider.value*100
    property int valueVerADD: versliderAdd.value*100
    property string channelName
    property string timestamp
    property string handler
    property string parameters

    property string carId
    property int x_value
    property int y_value

    Loader {
        source: "./content/Fps.qml"
    }
    Loader {
        id: geely
        property int x_value: root.x_value
        source: "./content/levelOne.qml"
    }

    onX_valueChanged: {
        //        series2.clear()
        series.append(-root.y_value, root.x_value)
    }

    ParallelAnimation  {
        id: mainControl
        running: false

        NumberAnimation {target: geelyChoose; property: "y"; from: 0; to: -720
            ; duration: 500; easing.type: Easing.InOutQuad}
        NumberAnimation {target: geelyControl; property: "y"; from: 720; to: 0;
            duration: 500; easing.type: Easing.InOutQuad}
    }

    ParallelAnimation  {
        id: mainChoose
        running: false

        NumberAnimation {target: geelyChoose; property: "y"; from: -720; to: 0;
            duration: 500; easing.type: Easing.InOutQuad}
        NumberAnimation {target: geelyControl; property: "y"; from: 0; to: 720;
            duration: 500; easing.type: Easing.InOutQuad}
    }

    //    """模拟器选择界面"""
    Item {
        id: geelyChoose
        opacity: 1.0

        Button {
            id: comein
            width: 300
            height: 100
            anchors.right: chooseTwo.right
            anchors.bottom: chooseThree.bottom
            text: "进入模拟器"
            font.pixelSize: 35
            background: Rectangle {
                implicitHeight: 100
                implicitWidth: 100
                color: "lightblue"
                border.color: "lightblue"
                border.width: 1
                radius: 50
            }
            onClicked: {
                con.startWork()
                mainControl.running = true
            }
        }
        Text {
            id: onlineClient
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.top: parent.top
            anchors.topMargin: 20
            font.pixelSize: 25
            text: "在线客户端"
        }

        Rectangle {
            id: chooseOne
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.top: onlineClient.bottom
            anchors.topMargin: 20
            width: 1220
            height: 160
            border.color: "lightgray"

            RadioButton {
                id: buttonOne
                anchors.left: chooseOne.left
                anchors.leftMargin: 20
                anchors.bottom: chooseOne.bottom
                anchors.bottomMargin: 10
                text: "NO.1"
                checked: true

                background: Rectangle {
                    implicitHeight: 140
                    implicitWidth: 140
                    border.color: buttonOne.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 70
                }

            }

            RadioButton {
                id: buttonTwo
                anchors.left: buttonOne.right
                anchors.leftMargin: 20
                anchors.bottom: chooseOne.bottom
                anchors.bottomMargin: 10
                text: "NO.2"

                background: Rectangle {
                    implicitHeight: 140
                    implicitWidth: 140
                    border.color: buttonTwo.pressed ? "blue" : "lightgray"
                    border.width: 1
                    radius: 70
                }
            }
            RadioButton {
                id: buttonThree
                anchors.left: buttonTwo.right
                anchors.leftMargin: 20
                anchors.bottom: chooseOne.bottom
                anchors.bottomMargin: 10
                text: "NO.3"

                background: Rectangle {
                    implicitHeight: 140
                    implicitWidth: 140
                    border.color: buttonThree.pressed ? "blue" : "lightgray"
                    border.width: 1
                    radius: 70
                }
            }
            RadioButton {
                id: buttonFour
                anchors.left: buttonThree.right
                anchors.leftMargin: 20
                anchors.bottom: chooseOne.bottom
                anchors.bottomMargin: 10
                text: "NO.4"

                background: Rectangle {
                    implicitHeight: 140
                    implicitWidth: 140
                    border.color: buttonFour.pressed ? "blue" : "lightgray"
                    border.width: 1
                    radius: 70
                }
            }
        }
        Text {
            id: chooseCarModel
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.top: chooseOne.bottom
            anchors.topMargin: 20
            font.pixelSize: 25
            text: "模拟车型"
        }
        Rectangle {
            id: chooseTwo
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.top: chooseCarModel.bottom
            anchors.topMargin: 20
            width: 1220
            height: 160
            border.color: "lightgray"

            RadioButton {
                id: modelOne
                anchors.left: chooseTwo.left
                anchors.leftMargin: 20
                anchors.bottom: chooseTwo.bottom
                anchors.bottomMargin: 10
                text: "CAR"
                checked: true

                background: Rectangle {
                    implicitHeight: 140
                    implicitWidth: 140
                    border.color: modelOne.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 70
                }
            }
            RadioButton {
                id: modelTwo
                anchors.left: modelOne.right
                anchors.leftMargin: 20
                anchors.bottom: chooseTwo.bottom
                anchors.bottomMargin: 10
                text: "SUV"

                background: Rectangle {
                    implicitHeight: 140
                    implicitWidth: 140
                    border.color: modelTwo.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 70
                }
            }

            RadioButton {
                id: modelThree
                anchors.left: modelTwo.right
                anchors.leftMargin: 20
                anchors.bottom: chooseTwo.bottom
                anchors.bottomMargin: 10
                text: "MPV"

                background: Rectangle {
                    implicitHeight: 140
                    implicitWidth: 140
                    border.color: modelThree.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 70
                }
            }
            RadioButton {
                id: modelFour
                anchors.left: modelThree.right
                anchors.leftMargin: 20
                anchors.bottom: chooseTwo.bottom
                anchors.bottomMargin: 10
                text: "TRUNCK"

                background: Rectangle {
                    implicitHeight: 140
                    implicitWidth: 140
                    border.color: modelFour.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 70
                }
            }
            RadioButton {
                id: modelFive
                anchors.left: modelFour.right
                anchors.leftMargin: 20
                anchors.bottom: chooseTwo.bottom
                anchors.bottomMargin: 10
                text: "TANK"

                background: Rectangle {
                    implicitHeight: 140
                    implicitWidth: 140
                    border.color: modelFive.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 70
                }
            }
        }
        Text {
            id: virtualScene
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.top: chooseTwo.bottom
            anchors.topMargin: 20
            font.pixelSize: 25
            text: "模拟场景"
        }
        Rectangle {
            id: chooseThree
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.top: virtualScene.bottom
            anchors.topMargin: 20
            width: 800
            height: 160
            border.color: "lightgray"

            RadioButton {
                id: sceneOne
                anchors.left: chooseThree.left
                anchors.leftMargin: 20
                anchors.top: chooseThree.top
                anchors.topMargin: 20
                text: "十字回环高速公路"
                checked: true

                background: Rectangle {
                    implicitHeight: 30
                    implicitWidth: 200
                    border.color: sceneOne.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 1
                }
            }
            RadioButton {
                id: sceneTwo
                anchors.left: chooseThree.left
                anchors.leftMargin: 20
                anchors.top: sceneOne.bottom
                anchors.topMargin: 20
                text: "吉利汽车研究院"

                background: Rectangle {
                    implicitHeight: 30
                    implicitWidth: 200
                    border.color: sceneTwo.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 1
                }
            }
        }
    }


    //    """" 模拟器控制界面""""
    Item {
        id: geelyControl
        y: 720
        opacity: 1.0

        Button {
            id: exitPlay
            z: 100
            anchors.left: geelyControl.left
            anchors.leftMargin: 20
            anchors.top: geelyControl.top
            anchors.topMargin: 10
            text: "EXIT"
            font.pixelSize: 30
            onClicked: {
                con.stopWork()
                mainChoose.running = true
            }
            background: Rectangle {
                implicitHeight: 100
                implicitWidth: 100
                color: "lightblue"
                border.color: "lightblue"
                border.width: 1
                radius: 50
            }
        }
        Rectangle {
            id: carInfo
            anchors.left: exitPlay.right
            anchors.leftMargin: 10
            anchors.top: exitPlay.top
            width: 1100
            height: 100
            border.color: "lightgray"

            Text {
                id: currentCarInfo
                anchors.centerIn: parent
                font.pixelSize: 35
                text: qsTr("当前监控车的信息")
            }
        }
        Item {
            id: outputText
            opacity: 0

            Text {
                id: channelName
                x: 20
                anchors.bottom: timestamp.top
                anchors.bottomMargin: 30
                font.bold: true
                text: "通道名称： " + root.channelName
            }
            Text {
                id: timestamp
                x: 20
                anchors.bottom: handler.top
                anchors.bottomMargin: 30
                font.bold: true
                text: "时间戳： " + root.timestamp
            }
            Text {
                id: handler
                x: 20
                anchors.bottom: parameters.top
                anchors.bottomMargin: 30
                font.bold: true
                text: "协议： " + root.handler
            }
            Text {
                id: parameters
                x: 20
                y: 650
                font.bold: true
                text: "参数： " + root.parameters
            }

        }

        Rectangle {
            id: steer
            x: 740
            y: 70
            width: 356
            height: 356
            scale: 0.6

            property int angleValue: 0

            Image {
                id: steerAngle
                source: "images/steer.jpg"
                transform: Rotation {origin.x: 178; origin.y: 178; angle: steer.angleValue}
            }
            SequentialAnimation {
                id: angleRotationZ
                running: false
                loops: 1
                NumberAnimation {target: steer; property: "angleValue"; from: 0; to: -49;
                    duration: 2000; easing.type: Easing.Linear}
            }
            SequentialAnimation  {
                id: angleRotationTR
                running: false
                loops: 1
                NumberAnimation {target: steer; property: "angleValue"; from: 0; to: 49;
                    duration: 2000; easing.type: Easing.Linear}
            }
            SequentialAnimation  {
                id: angleRotationF
                running: false
                NumberAnimation {target: steer; property: "angleValue"; to: 0;
                    duration: 10; easing.type: Easing.Linear}
            }
        }

        Slider {
            id: horslider
            x: 816
            y: 227
            z: -2
            width: 200
            height: 50
            stepSize: 0.01;
            value: 0.5
            opacity: 0.1
            onValueChanged: {
                con.controlHor(root.valueHor)
                if(value < 0.5){
                    angleRotationZ.running = true
                    turnLRun.running = true
                }
                else if(value > 0.5) {
                    angleRotationTR.running = true
                    turnRRun.running = true
                }
            }

            onPressedChanged: {
                value = 0.5
                angleRotationZ.running = false
                angleRotationTR.running = false
                angleRotationF.running = true
            }
        }

        Slider {
            id: versliderAdd
            x: 660
            y: 420
            width: 50
            height: 200
            stepSize: 0.01;
            value: 0
            orientation: "Vertical"
            onValueChanged: {
                if (value > 0.5) {
                    con.controlVer(root.valueVer)
                }
            }
            onPressedChanged: {
                value = 0
            }
        }
        Button {
            id: vehical
            x: 720
            y: 460
            text: "加速"
            background: Rectangle {
                implicitHeight: 100
                implicitWidth: 100
                border.color: exitPlay.down ? "blue" : "black"
                border.width: 1
                radius: 50
            }
        }

        Slider {
            id: versliderDec
            x: 1160
            y: 420
            width: 50
            height: 200
            stepSize: 0.01;
            value: 1
            orientation: "Vertical"

            onValueChanged: {
                if (value < 0.5) {
                    con.controlVer(root.valueVer)
                }
            }
            onPressedChanged: {
                value = 1
            }
        }
        Button {
            id: dec
            x: 1060
            y: 460
            text: "减速"
            background: Rectangle {
                implicitHeight: 100
                implicitWidth: 100
                border.color: exitPlay.down ? "blue" : "black"
                border.width: 1
                radius: 50
            }
        }
        //        Image {
        //            id: lync
        //            x: -310
        //            y: 116
        //            z: 10
        //            scale: 0.4
        //            source: "images/lyncTest.png"
        //        }
        Item {
            id: light
            x: 20

            Image {
                id: turnL
                x: 660
                y: 364
                source: "images/turnLeft.png"
            }
            SequentialAnimation {
                id: turnLRun
                running: false
                NumberAnimation {target: turnL; property: "opacity"; from: 1.0; to: 0;
                    duration: 500; easing.type: Easing.InOutQuad}
                NumberAnimation {target: turnL; property: "opacity"; from: 0; to: 1.0;
                    duration: 500; easing.type: Easing.InOutQuad}
            }

            Image {
                id: beltOne
                anchors.left: turnL.right
                anchors.leftMargin: 50
                anchors.bottom: turnL.bottom
                source: "images/beltOneErr.png"
            }
            Image {
                id: stopStarLight
                anchors.left: beltOne.right
                anchors.leftMargin: 50
                anchors.bottom: turnL.bottom
                source: "images/stopStarLight.png"
            }
            Image {
                id: stopStartErr
                anchors.left: stopStarLight.right
                anchors.leftMargin: 150
                anchors.bottom: turnL.bottom
                source: "images/stopStartErr.png"
            }
            Image {
                id: beltTwoErr
                anchors.left: stopStartErr.right
                anchors.leftMargin: 50
                anchors.bottom: turnL.bottom
                source: "images/beltTwoErr.png"
            }
            Image {
                id: turnRight
                anchors.left: beltTwoErr.right
                anchors.leftMargin: 50
                anchors.bottom: turnL.bottom
                source: "images/turnRight.png"
            }
            SequentialAnimation {
                id: turnRRun
                running: false
                NumberAnimation {target: turnRight; property: "opacity"; from: 1.0; to: 0;
                    duration: 500; easing.type: Easing.InOutQuad}
                NumberAnimation {target: turnRight; property: "opacity"; from: 0; to: 1.0;
                    duration: 500; easing.type: Easing.InOutQuad}
            }
        }


        ChartView {
            title: "环境感知"
            x: 0
            y: 120
            width: 680
            height: 600
            theme: ChartView.ChartThemeBlueCerulean
            titleColor: "blue"
            opacity: 1.0
            animationOptions: ChartView.AllAnimations
            legend.visible: false
            antialiasing: true
            plotAreaColor: "blue"

            ValueAxis {
                id: axisX
                min: -750
                max: 750
                tickCount: 11
                labelFormat: "%.0f"
            }

            ValueAxis {
                id: axisY
                min: -350
                max: 1050
                tickCount: 11
                labelFormat: "%.0f"
            }

            LineSeries {
                id: series
                axisX: axisX
                axisY: axisY
            }

            //            Image {
            //                id: carModel
            //                x: 222
            //                y: 24
            //                scale: 0.1
            //                source: "images/car.png"
            //            }
            //            Text {
            //                id: adasd
            //                anchors.centerIn: parent
            //                text: root.x_value + "SSS" + root.y_value
            //            }
        }
    }
}
