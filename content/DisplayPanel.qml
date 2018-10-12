import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    id: display
    width: 1440
    height: 960
    opacity: 1
    z: 100

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
        id: chooseScenario
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: workTxt.bottom
        anchors.topMargin: 150
        width: 200
        height: 200
        text: "Stop"
        font.pixelSize: 35
        background: Rectangle {
            id: chooseScenarioBtn
            color: "dodgerblue"
            border.color: "dodgerblue"
            border.width: 1
            radius: 100
        }
        onClicked: {

        }
    }
}
