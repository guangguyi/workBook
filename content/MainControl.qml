import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Particles 2.0

Rectangle {
    id: mainControl
    width: 1440
    height: 960
    color: "gray"

    property var dataOne
    property var dataTwo
    property var dataThree
    property var dataFour

    Text {
        id: geelySimulator
        text: qsTr("GEELY SIMULATOR")
        font.pixelSize: 100
        color: "dodgerblue"
        anchors.centerIn: parent
    }

    Rectangle {
        id: maskGeely
        x: 330
        y: 430
        width: 800
        height: 100
        color: "blue"
        opacity: 0
        transform: Rotation { origin.x: 380; origin.y: 50; axis { x: 0; y: 1; z: 0 } angle: 180 }
    }

    ParticleSystem { id: sys1 }
    ImageParticle {
        system: sys1
        source: "qrc:/images/glowdot.png"
        color: "blue"//"cyan"
        alpha: 1
        colorVariation: 0.1
    }

    Emitter {
        id: trailsNormal
        system: sys1
        x: 330
        y: 530
        width: 800
        height: 100

        emitRate: 500
        lifeSpan: 3000

        velocity: PointDirection {xVariation: 4; yVariation: 4;}
        acceleration: PointDirection {xVariation: 10; yVariation: 10;}
        velocityFromMovement: 8

        size: 9
        sizeVariation: 4

//        transform: Rotation { origin.x: 380; origin.y: 50; axis { x: 0; y: 1; z: 0 } angle: 180 }
    }

    SequentialAnimation {
       running: true
       PauseAnimation {duration: 2500}
       ParallelAnimation {
           NumberAnimation { target: maskGeely; property: "width"; to: 0; duration: 1000; easing.type: Easing.InOutQuad }
//           NumberAnimation { target: trailsNormal; property: "width"; to: 0; duration: 1000; easing.type: Easing.InOutQuad }
       }

       ScriptAction {
           script: {
               geelySimulator.opacity = 0;
//               trailsNormal.visible = false;
               mainControl.state = "mainMenu"
           }
       }
    }
    //用来加载运行界面及场景选择界面

    Button {
        id: quickStart
        width: 300
        height: 300
        text: "Quick Start"
        font.pixelSize: 35
        background: Rectangle {
            id: quickStartBtn
            color: "dodgerblue"
            border.color: "dodgerblue"
            border.width: 1
            radius: 5
        }
        onClicked: {
            con.startWork()
            mainControl.state = "running"
        }
    }

    Button {
        id: chooseScenario
        width: 300
        height: 300
        text: "Choose Scenario"
        font.pixelSize: 35
        background: Rectangle {
            id: chooseScenarioBtn
            color: "dodgerblue"
            border.color: "dodgerblue"
            border.width: 1
            radius: 5
        }
        onClicked: {
            mainControl.state = "chooseSce"
            con.dataRead()
        }
    }

    //场景选择界面
    Item {
        id: chooseSceItem
        width: 1440
        height: 960
        opacity: 0

        Rectangle {
            id: backRec
            width: 300
            height: 961
            border.color: "black"

            Text {
                id: title
                anchors.top: backRec.top
                anchors.topMargin: 30
                anchors.left: backRec.left
                anchors.leftMargin: 30

                text: "Scenario List"
                color: "dodgerblue"
                font.pixelSize: 35
            }
            RadioButton {
                id: buttonOne
                anchors.top: title.bottom
                anchors.topMargin: 30
                anchors.left: backRec.left
                text: "NO.1"
                checked: true

                background: Rectangle {
                    color: buttonOne.checked ? "dodgerblue" : "white"
                    implicitHeight: 100
                    implicitWidth: 300
                    border.color: buttonOne.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 2
                }
            }
            RadioButton {
                id: buttonTwo
                anchors.top: buttonOne.bottom
                anchors.left: backRec.left
                text: "NO.2"

                background: Rectangle {
                    color:  buttonTwo.checked ? "dodgerblue" : "white"
                    implicitHeight: 100
                    implicitWidth: 300
                    border.color: buttonTwo.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 2
                }
            }
            RadioButton {
                id: buttonThree
                anchors.top: buttonTwo.bottom
                anchors.left: backRec.left
                text: "NO.3"

                background: Rectangle {
                    color:  buttonThree.checked ? "dodgerblue" : "white"
                    implicitHeight: 100
                    implicitWidth: 300
                    border.color: buttonThree.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 2
                }
            }
            RadioButton {
                id: buttonFour
                anchors.top: buttonThree.bottom
                anchors.left: backRec.left
                text: "NO.4"

                background: Rectangle {
                    color:  buttonFour.checked ? "dodgerblue" : "white"
                    implicitHeight: 100
                    implicitWidth: 300
                    border.color: buttonFour.down ? "blue" : "lightgray"
                    border.width: 1
                    radius: 2
                }
            }
        }

        Text {
            id: test
            anchors.centerIn: parent
            font.pixelSize: 55
            text: (mainControl.dataOne[0])
        }

        Button {
            id: temp
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: 300
            height: 140
            text: "Start Work"
            font.pixelSize: 35
            background: Rectangle {
                id: tempBtn
                color: "dodgerblue"
                border.color: "dodgerblue"
                border.width: 1
                radius: 1
            }
            onClicked: {
                con.startWork()
                mainControl.state = "running"
            }
        }
    }

    // 模拟器运行界面
    Item {
        id: runningSce
        width: 1440
        height: 960
        opacity: 0

        Text {
            id: workTxt
            anchors.horizontalCenter: parent.horizontalCenter
            y: 200
            text: qsTr("Simulator Working")
            font.pixelSize: 95
            font.bold: true
            color: "dodgerblue"
        }
        Button {
            id: exitRunning
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: workTxt.bottom
            anchors.topMargin: 150
            width: 200
            height: 200
            text: "Stop"
            font.pixelSize: 35
            background: Rectangle {
                id: exitRunningBtn
                color: "dodgerblue"
                border.color: "dodgerblue"
                border.width: 1
                radius: 100
            }
            onClicked: {
                if(runningSce.opacity !== 0){
                    con.stopWork()
                    mainControl.state = "mainMenu"
                }
            }
        }
    }

    state: "empty"
    states: [
        State {
            name: "empty"
            PropertyChanges { target: quickStart; x: 250 }
            PropertyChanges { target: chooseScenario; x: 890 }
            PropertyChanges { target: quickStart; y: 1100 }
            PropertyChanges { target: chooseScenario; y: 1100 }

        },
        State {
            name: "mainMenu"
            PropertyChanges { target: quickStart; y: 300 }
            PropertyChanges { target: chooseScenario; y: 300 }
            PropertyChanges { target: quickStart; x: 250 }
            PropertyChanges { target: chooseScenario; x: 890 }
            PropertyChanges { target: runningSce; opacity: 0 }
            PropertyChanges { target: quickStart; scale: 1 }
            PropertyChanges { target: chooseScenario; scale: 1 }
            PropertyChanges { target: chooseSceItem; opacity: 0 }
            PropertyChanges { target: runningSce; opacity: 0 }
        },
        State {
            name: "chooseSce"
            PropertyChanges { target: quickStart; x: 570 }
            PropertyChanges { target: chooseScenario; x: 570 }
            PropertyChanges { target: quickStart; y: 300 }
            PropertyChanges { target: chooseScenario; y: 300 }
            PropertyChanges { target: quickStart; scale: 0 }
            PropertyChanges { target: chooseScenario; scale: 0 }
            PropertyChanges { target: chooseSceItem; opacity: 1 }
            PropertyChanges { target: runningSce; opacity: 0 }
        },
        State {
            name: "running"
            PropertyChanges { target: quickStart; x: 570 }
            PropertyChanges { target: chooseScenario; x: 570 }
            PropertyChanges { target: quickStart; y: 300 }
            PropertyChanges { target: chooseScenario; y: 300 }
            PropertyChanges { target: quickStart; scale: 0 }
            PropertyChanges { target: chooseScenario; scale: 0 }
            PropertyChanges { target: runningSce; opacity: 1 }
            PropertyChanges { target: chooseSceItem; opacity: 0 }
        }
    ]

    transitions: [
        Transition {
            from: "empty"
            to: "mainMenu"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: quickStart; property: "y"; duration: 1000; easing.type: Easing.InOutElastic }
                    NumberAnimation { target: chooseScenario; property: "y"; duration: 1000; easing.type: Easing.InOutElastic }
                }
            }
        },
        Transition {
            from: "mainMenu"
            to: "chooseSce"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: chooseScenario; property: "x"; duration: 500; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: quickStart; property: "x"; duration: 500; easing.type: Easing.InOutQuad }
                }
                ParallelAnimation {
                    NumberAnimation { target: quickStart; property: "scale"; duration: 300; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: chooseScenario; property: "scale"; duration: 300; easing.type: Easing.InOutQuad }
                }
                NumberAnimation { target: chooseSceItem; property: "opacity"; duration: 100; easing.type: Easing.InOutQuad }
                ScriptAction {
                    script: {
                        quickStart.y = 1100
                        chooseScenario.y = 1100
                        quickStart.scale = 1
                        chooseScenario.scale = 1
                    }
                }
            }
        },
        Transition {
            from: "mainMenu"
            to: "running"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target: chooseScenario; property: "x"; duration: 500; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: quickStart; property: "x"; duration: 500; easing.type: Easing.InOutQuad }
                }
                ParallelAnimation {
                    NumberAnimation { target: quickStart; property: "scale"; duration: 300; easing.type: Easing.InOutQuad }
                    NumberAnimation { target: chooseScenario; property: "scale"; duration: 300; easing.type: Easing.InOutQuad }
                }
                NumberAnimation { target: runningSce; property: "opacity"; duration: 300; easing.type: Easing.InOutQuad }
            }
            ScriptAction {
                script: {
                    quickStart.y = 1100
                    chooseScenario.y = 1100
                    quickStart.scale = 1
                    chooseScenario.scale = 1
                }
            }
        },
        Transition {
            from: "chooseSce"
            to: "running"
            SequentialAnimation {
                NumberAnimation { target: chooseSceItem; property: "opacity"; duration: 100; easing.type: Easing.InOutQuad }
                NumberAnimation { target: runningSce; property: "opacity"; duration: 300; easing.type: Easing.InOutQuad }
                ScriptAction {
                    script: {
                        quickStart.y = 1100
                        chooseScenario.y = 1100
                        quickStart.scale = 1
                        chooseScenario.scale = 1
                    }
                }
            }
        },
        Transition {
            from: "running"
            to: "mainMenu"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        quickStart.y = 1100
                        chooseScenario.y = 1100
                    }
                }
                NumberAnimation { target: runningSce; property: "opacity"; duration: 300; easing.type: Easing.InOutQuad }
                ParallelAnimation {
                    NumberAnimation { target: quickStart; property: "y"; duration: 1000; easing.type: Easing.InOutElastic }
                    NumberAnimation { target: chooseScenario; property: "y"; duration: 1000; easing.type: Easing.InOutElastic }
                }
            }
        }
    ]
}
