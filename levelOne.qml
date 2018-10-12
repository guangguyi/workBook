import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.2

Item {
    id: geely
    property int valueHor: horslider.value*100
    property int valueVer: verslider.value*100
    property string channelName
    property string timestamp
    property string handler
    property string parameters


    Image {
        id: lync
        x: 320
        y: 36
        scale: 0.5
        source: "lyncTest.png"
    }

    Text {
        id: channelName
        x: 20
        y: 400
        font.bold: true
        text: "通道名称：  " + geely.channelName
    }
    Text {
        id: timestamp
        x: 20
        y: 450
        font.bold: true
        text: "时间戳：   " + geely.timestamp
    }
    Text {
        id: handler
        x: 20
        y: 500
        font.bold: true
        text: "协议：     " + geely.handler
    }
    Text {
        id: parameters
        x: 20
        y: 550
        font.bold: true
        text: "参数：     " + geely.parameters
    }

    Button {
        x: 20
        y: 50
        height: 50
        width: 100
        text: "进入"
        onClicked: {
            con.startWork()
        }
    }

    Button {
        x: 20
        y: 220
        height: 50
        width: 100
        text: "退出"
        onClicked: {
            con.stopWork()
        }
    }

    Slider {
        id: horslider
        x: 200
        y: 50
        width: 200
        height: 50
        stepSize: 0.01;
        value: 0.5
        onValueChanged: {
            con.controlHor(geely.valueHor)
        }
    }
    Text {
        id: horsliderText
        x: 420
        y: 66
        font.bold: true
        text: qsTr("横向控制")
    }

    Slider {
        id: verslider
        x: 270
        y: 150
        width: 50
        height: 200
        stepSize: 0.01;
        value: 0.5
        orientation: "Vertical"

        onValueChanged: {
            con.controlVer(geely.valueVer)
        }
    }
    Text {
        id: versliderText
        x: 420
        y: 236
        font.bold: true
        text: qsTr("纵向控制")
    }
}
