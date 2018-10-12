import QtQuick 2.0


Item {
    id: fpsRoot
    x:1100
    y: 500
    implicitWidth: 100
    implicitHeight: 50
    property int count: 0
    property int fps: 0
    z: 20
    Item {
        NumberAnimation on rotation {
            from: 0
            to: 360
            duration: 800
            loops: -1
        }
        onRotationChanged: count++;
    }
    Text {
        id: txt
        anchors.centerIn: parent
        font.family: UiController.font["wenquanyi"]
        text: "FPS " + fps
        color: "green"
        font.pixelSize: 30

    }
    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            fps = count;
            count = 0;
        }
    }
}
