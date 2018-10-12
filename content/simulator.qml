import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    id: simulator

    Rectangle {
        id: line
        x: 200
        width: 3
        height: 960
        color: "dodgerblue"
    }

    Button {
        id: historyBtn
        y: 70
        width: 200
        height: 110
        text: "History File"
        font.pixelSize: 30
        background: Rectangle {
            id: historyBtnBg
            color: "dodgerblue"
            radius: 1
        }
        onClicked: {
            historyBtnBg.color = "dodgerblue"
            newSceBtnBg.color = "white"
            startBtn.text = "Start Work"
            historyFile.opacity = 1.0
            newSce.opacity = 0
            newSce.clickNum = 0
            chooseSce.opacity = 1.0
            chooseAct.opacity = 0.7
            chooseWea.opacity = 0.7
            chooseAPI.opacity = 0.7
        }
    }

    Button {
        id: newSceBtn
        anchors.top: historyBtn.bottom
        anchors.topMargin: 0
        width: 200
        height: 110
        text: "New Scenario"
        font.pixelSize: 30
        background: Rectangle {
            id: newSceBtnBg
            color: "white"
            radius: 1
        }
        onClicked: {
            historyBtnBg.color = "white"
            newSceBtnBg.color = "dodgerblue"
            startBtn.text = "Next"
            newSce.opacity = 1.0
            historyFile.opacity = 0
        }
    }

    Button {
        id: startBtn
        x: 0
        y: 850
        width: 200
        height: 110
        text: "Start Work"
        font.pixelSize: 30
        background: Rectangle {
            id: startBtnBg
            color: "dodgerblue"
            radius: 1
        }
        onClicked: {
            if(startBtn.text == "Start Work"){
                newSce.clickNum = 1;
            }
            else {
                if (newSce.clickNum == 0) {
                    newSce.clickNum = 1;
                    chooseSce.opacity = 0.7
                    chooseAct.opacity = 1.0
                    chooseWea.opacity = 0.7
                    chooseAPI.opacity = 0.7
                }
                else if(newSce.clickNum == 1) {
                    chooseSce.opacity = 0.7
                    chooseAct.opacity = 0.7
                    chooseWea.opacity = 1.0
                    chooseAPI.opacity = 0.7
                    newSce.clickNum = 2
                }
                else {
                    chooseSce.opacity = 0.7
                    chooseAct.opacity = 0.7
                    chooseWea.opacity = 0.7
                    chooseAPI.opacity = 1.0
                    newSce.clickNum = 3
                    if (chooseAPI.opacity == 1.0) {
                        startBtn.text = "Start Work"
                    }
                }              
            }
        }
    }

    Item {
        id: historyFile
        x: 200
        width: 1240
        height: 960
        opacity: 1.0

        Image {
            id: temText
            x: 170
            y: 100
            opacity: 1
            source: "../images/historyFile.png"
        }
    }
    Item {
        id: newSce
        x: 200
        width:  1240
        height: 960
        opacity: 0

        property int clickNum: 0

        Text {
            id: chooseSce
            x: 100
            y: 900
            opacity: 1
            text: qsTr("ChooseScene")
            font.pixelSize: 25
            font.bold: chooseSce.opacity == 1 ? true : false
            scale: chooseSce.opacity == 1 ? 1.3 : 1.0
        }

        Text {
            id: chooseAct
            x: 400
            y: 900
            opacity: 0.7
            text: qsTr("Choose Actors")
            font.bold: chooseAct.opacity == 1 ? true : false
            scale: chooseAct.opacity == 1 ? 1.3 : 1.0
            font.pixelSize: 25
        }

        Text {
            id: chooseWea
            x: 700
            y: 900
            opacity: 0.7
            font.bold: chooseWea.opacity == 1 ? true : false
            scale: chooseWea.opacity == 1 ? 1.3 : 1.0
            text: qsTr("Choose Weather")
            font.pixelSize: 25
        }

        Text {
            id: chooseAPI
            x: 1000
            y: 900
            opacity: 0.7
            font.bold: chooseAPI.opacity == 1 ? true : false
            scale: chooseAPI.opacity == 1 ? 1.3 : 1.0
            text: qsTr("Choose API")
            font.pixelSize: 25
        }
        Image {
            id: sceneSC
            x: 170
            y: 100
            opacity: 1
            source: chooseSce.opacity == 1 ? "../images/newScene.png" : chooseAct.opacity == 1 ?
                                                 "../images/newActor.png" : chooseWea.opacity == 1 ?
                                                     "../images/newWea.png" : chooseAPI.opacity == 1 ?
                                                         "../images/newAPI.png" : ""
        }
    }
}
